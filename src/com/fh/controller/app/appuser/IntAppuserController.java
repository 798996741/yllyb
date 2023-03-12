package com.fh.controller.app.appuser;

import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.SortedMap;
import java.util.TreeMap;

import javax.annotation.Resource;
import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.dom4j.Document;
import org.jsoup.Jsoup;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.OAuthInfo;
import com.fh.service.system.appuser.AppuserManager;
import com.fh.util.AppUtil;
import com.fh.util.Jurisdiction;
import com.fh.util.MD5;
import com.fh.util.MyUtils;
import com.fh.util.PageData;
import com.fh.util.Signwx;
import com.fh.util.StringUtil;
import com.fh.util.Tools;
import com.fh.util.UuidUtil;
import com.fh.util.voice.httpclients;
import com.lzzj.entity.archive.SetBean;
import com.lzzj.entity.archive.WxpayBean;
import com.lzzj.utils.DesUtil;
import com.lzzj.utils.HttpXmlUtils;
import com.lzzj.utils.PayUtils;
import com.lzzj.utils.ResponseUtils;
import com.lzzj.utils.WxSign;
import com.lzzj.utils.XMLUtil;
import com.xxgl.service.RecordpayManager;
import com.xxgl.service.WxuserManager;
import com.xxgl.service.mng.CouponManager;


/**@author
  * 会员-接口类 
  * 相关参数协议：
  * 00	请求失败
  * 01	请求成功  
  * 02	返回空值
  * 03	请求协议参数不完整    
  * 04  用户名或密码错误
  * 05  FKEY验证失败
 */
@Controller
@RequestMapping(value="/appuser")
public class IntAppuserController extends BaseController {
    
	@Resource(name="appuserService")
	private AppuserManager appuserService;
	
	
	@Resource(name="wxuserService")
	private WxuserManager wxuserService;
	
	
	@Resource(name="couponService")
	private CouponManager couponService;
	

	@Resource(name="recordpayService")
	private RecordpayManager recordpayService;

	
	
	//操作日志登记
	@ResponseBody
	@RequestMapping(value = "/logger")
	public void logger(HttpServletResponse response,HttpServletRequest request) throws Exception { 
		//参数组
		request.setCharacterEncoding("GBK");
		response.setCharacterEncoding("GBK");
		PageData pd = new PageData();
		pd = this.getPageData();
		JSONObject object = new JSONObject();
		
		if(pd!=null&&pd.getString("uid")!=null&&!pd.getString("uid").equals("")){
			
			URLDecoder urlDecoder = new URLDecoder(); 
			System.out.println("content0:"+pd.getString("content"));
			//String content=pd.getString("content")==null?"":urlDecoder.decode(pd.getString("content"),"UTF-8");
			String content=content=new String(pd.getString("content").getBytes("iso-8859-1"),"utf-8");
			pd.put("content",content);
			System.out.println("content1:"+content);
			String user_name=pd.getString("user_name")==null?"":urlDecoder.decode(pd.getString("user_name"),"UTF-8");
			
			user_name=new String(pd.getString("user_name").getBytes("iso-8859-1"),"utf-8");
			pd.put("user_name",user_name);
			
			String method=pd.getString("method")==null?"":urlDecoder.decode(pd.getString("method"),"UTF-8");
			method=new String(pd.getString("method").getBytes("iso-8859-1"),"utf-8");
			pd.put("method",method);
			
			String uid=pd.getString("uid")==null?"":urlDecoder.decode(pd.getString("uid"),"UTF-8");
			pd.put("uid",uid);
			
			appuserService.saveDriverLog(pd);
			object.put("status", "200");
		}else{
			
			object.put("status", "201");
			object.put("msg", "提交失败");
		}
		ResponseUtils.renderJson(response, object.toString());
		//return msg.toString();
	}
	
	
	
	//用户登陆data={"data":{"devid":"358240051111110","gid":"F0F23328-F4F8-13D5-C091-05E02D1890B0","ucode":"admin","upwd":"123456"},"cmd":"LOGIN"}
	@ResponseBody
	@RequestMapping(value = "/api")
	public void api(HttpServletResponse response,HttpServletRequest request) throws Exception  { 
		//参数组
		//System.out.println(request.getParameter("data"));
		JSONObject object = new JSONObject();
		String issuccess="0",loginstr="",ucode="",uname="";
		String devid="";
		String ip=request.getRemoteAddr();
		try{
			request.setCharacterEncoding("GBK");
			response.setCharacterEncoding("GBK");
			PageData pd = new PageData();
			pd = this.getPageData();
			
			if(pd!=null&&pd.getString("data")!=null&&!pd.getString("data").equals("")){
				//System.out.println(pd.getString("data"));
				String data=DesUtil.decrypt(pd.getString("data").replaceAll(" ","+"));
				//System.out.println(data+"data");
				JSONObject string_to_json = JSONObject.fromObject(data);
				JSONObject json_to_data = string_to_json.getJSONObject("data");
				//System.out.println("devid:"+json_to_data.get("devid")+json_to_data.get("ucode"));
				devid=(String) (json_to_data.get("devid")==null?"":json_to_data.get("devid"));
				pd.put("ucode", json_to_data.get("ucode"));
				ucode=(String) json_to_data.get("ucode");
				pd.put("upwd", MD5.md5(String.valueOf(json_to_data.get("upwd"))));
				PageData pducode =appuserService.findByUcode(pd);
				if(pducode!=null){
					String openid=StringUtil.getUUID();
					uname=pducode.getString("uname");
					pd.put("devid", json_to_data.get("devid"));
					pd.put("openid", openid);
					if(pducode.getString("devid")!=null&&pducode.getString("devid").equals(devid)){
	
						JSONObject object_data = new JSONObject();
						
						appuserService.editOpenid(pd);
						//"uid":1,"uname":"系统管理员","pcode":"admin","groupid":"1","oid":
						//	"ae392c8914ef4fe3a37050a8227044a8","pic":""],"status":"200","info":"登陆成功"}
						if(pducode.get("isbind")!=null&&pducode.get("isbind").equals("1")){
							String yxdate=""; 
							if(pducode.get("yxdate")!=null&&String.valueOf(pducode.get("yxdate")).length()>=10){
								yxdate=String.valueOf(pducode.get("yxdate")).substring(0, 10);
							}
							SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
					        String nowdate=df.format(new Date());
					        int  id=getDayBetweenTwoDate(yxdate, nowdate);
					        if(id>=0){
					        	object_data.put("uid", pducode.get("uid"));
								object_data.put("openid", openid);
								object_data.put("uname", pducode.getString("uname"));
								object_data.put("ucode", pducode.getString("ucode"));
								object_data.put("groupid", pducode.getString("groupid"));
								object_data.put("oid", pducode.getString("oid"));
								object_data.put("phone", pducode.getString("PHONE")); //手机号码
								object_data.put("exclusivenum", pducode.getString("EXCLUSIVENUM"));//专属号
								object_data.put("pic", pducode.getString("pic"));
								
								object_data.put("status", "200");
								object_data.put("info", "登陆成功");
								object.put("data", object_data.toString());
								object.put("cmd", "LOGIN");
								issuccess="1";
					        }else{
					        	loginstr="登陆失败，试用时间已到期或账户已失效";
					        	object.put("status", "203");
								object.put("info", "登陆失败，试用时间已到期或账户已失效");
					        }
							
							
						}else{
							loginstr="登陆失败，账号还未绑定";
							object.put("status", "202");
							object.put("info", "登陆失败，账号还未绑定");
						}
						
					}else{
						if(pducode.getString("devid")==null||pducode.getString("devid").equals("")){
							appuserService.editOpenid(pd);
							loginstr="登陆失败，账号还未绑定";
							object.put("status", "202");
							object.put("info", "登陆失败，账号还未绑定");
						}else if(!pducode.getString("devid").equals(devid)){
							object.put("status", "300");
							loginstr="登陆失败，账号已被使用";
							object.put("info", "登陆失败，账号已被使用");
						}
					}
					
				}else{
					loginstr="登陆失败，密码或用户名不存在";
					object.put("status", "201");
					object.put("info", "登陆失败，密码或用户名不存在");
				}
			}else{
				loginstr="提交失败";
				object.put("status", "201");
				object.put("info", "提交失败");
			}
			
		}catch(Exception e){
			loginstr="登录异常";
			object.put("status", "205");
			object.put("info", "登录异常");
		}	
		PageData pd_log = new PageData();
		pd_log.put("issuccess", issuccess);
		pd_log.put("ucode", ucode);
		pd_log.put("loginstr", loginstr+"#"+object+"#"+devid);
		pd_log.put("uname", uname);
		pd_log.put("ip", ip);
		try {
			appuserService.saveLoginLog(pd_log);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//System.out.println(object.toString());
		//ResponseUtils.renderJson(response,object.toString());
		ResponseUtils.renderJson(response,DesUtil.encrypt(object.toString()));
		//return msg.toString();
	}

	public static int getDayBetweenTwoDate(String startDateStr, String endDateStr) {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        int days = 0;
        try {
            Date startDate = simpleDateFormat.parse(startDateStr);
            Date endDate = simpleDateFormat.parse(endDateStr);
            Calendar startCalendar = Calendar.getInstance();
            startCalendar.setTime(startDate);
            Calendar endCalendar = Calendar.getInstance();
            endCalendar.setTime(endDate);
            //计算两个日期相差的天数
            //startCalendar.getTime().getTime()返回long毫秒数形式,毫秒转为秒所以除以1000
            //1天=24小时，1小时=60分，1分=60秒，所以两个时间的差再除以60 * 60 * 24换算成天的形式
            days = ((int) (startCalendar.getTime().getTime() / 1000) - (int) (endCalendar.getTime().getTime() / 1000)) / (60 * 60 * 24);
 
        } catch (Exception e) {
            e.printStackTrace();
        }
        return days;
    }
	
	public static void main(String[] args) {
        String start = "2015-09-14";
        String end = "2015-09-15";
        System.out.println(getDayBetweenTwoDate(start, end));
    }
	
	
	// 拨打电话 data={"data":{"ucode":"admin","dialphone":"15606063662"},"cmd":"DIAL"}
	@ResponseBody
	@RequestMapping(value = "/dial")
	public void dial(HttpServletResponse response,HttpServletRequest request) throws Exception { 
		
		request.setCharacterEncoding("GBK");
		response.setCharacterEncoding("GBK");
		PageData pd = new PageData();
		pd = this.getPageData();
		JSONObject object_print = new JSONObject();
		
		
		if(pd!=null&&pd.getString("data")!=null&&!pd.getString("data").equals("")){
			String data=DesUtil.decrypt(pd.getString("data").replaceAll(" ","+"));
			//String data=pd.getString("data");
			//System.out.println(data+"data");
			JSONObject string_to_json = JSONObject.fromObject(data);
			JSONObject json_to_data = string_to_json.getJSONObject("data");
			pd.put("ucode", json_to_data.get("ucode"));
			PageData pducode =appuserService.findByUcode(pd);
			if(pducode!=null){
				JSONObject object_data = new JSONObject();
				
				//"uid":1,"uname":"系统管理员","pcode":"admin","groupid":"1","oid":
				//	"ae392c8914ef4fe3a37050a8227044a8","pic":""],"status":"200","info":"登陆成功"}
				String phone=pducode.getString("PHONE")==null?"":pducode.getString("PHONE");
				String exclusivenum=pducode.getString("EXCLUSIVENUM")==null?"":pducode.getString("EXCLUSIVENUM");
				String dialphone= String.valueOf(json_to_data.get("dialphone"));
				String userData=UuidUtil.get32UUID();
				System.out.println("userData:"+userData);
				
				httpclients ac = new httpclients();
				Date date = new Date();
				SimpleDateFormat df1 = new SimpleDateFormat("yyyyMMddHHmmss");
		        String datestr1=df1.format(date);
		        String sigParameter=MD5.md5(httpclients.accountSid+httpclients.authtoken+datestr1).toUpperCase();
		        String fwurl="Accounts/"+httpclients.accountSid+"/nme/exclusive/020/setnumber?sig="+sigParameter;
		        String result="";
				JSONObject object1 = new JSONObject();
				
				System.out.println("datestr1:"+datestr1+"sigParameter:"+sigParameter);
				//object.put("NTA2000", arry.toString());
				object1.put("appId", httpclients.appId);
				object1.put("servingNumber", exclusivenum);
				object1.put("calledPhoneNum", dialphone);
				object1.put("callType", "1");
				object1.put("userData", userData);
				date = new Date();
				datestr1=df1.format(date);
				sigParameter=MD5.md5(httpclients.accountSid+httpclients.authtoken+datestr1).toUpperCase();
		       	fwurl="Accounts/"+httpclients.accountSid+"/nme/exclusive/020/setoutcall?sig="+sigParameter;
		       	result=ac.post(object1.toString(),fwurl);
		       	System.out.println(result);
		       			
		       	if(result!=null&&result.indexOf("000000")>=0){
		       		object_data.put("status", "200");
					object_data.put("info", "拨号成功");
					object_data.put("calledPhoneNum", dialphone);
					object_data.put("exclusivenum", exclusivenum);//专属号
					object_print.put("data", object_data.toString());
					object_print.put("cmd", "DIAL");
		       	}else{
		       		object_print.put("status", "201");
					object_print.put("info", "拨号失败");
		       	}
			
			}else{
				object_print.put("status", "201");
				object_print.put("info", "未查询改账号信息");
			}
		}else{
			object_print.put("status", "201");
			object_print.put("info", "未获取相应的信息");
		}
		
		ResponseUtils.renderJson(response, DesUtil.encrypt(object_print.toString()));
		//ResponseUtils.renderJson(response, object_print.toString());
		//return msg.toString();
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/sync")
	public void sync(HttpServletResponse response,HttpServletRequest request) throws Exception { 
		
		request.setCharacterEncoding("GBK");
		response.setCharacterEncoding("GBK");
		PageData pd = new PageData();
		pd = this.getPageData();
		JSONObject object_print = new JSONObject();
		
		
		if(pd!=null&&pd.getString("data")!=null&&!pd.getString("data").equals("")){
			String data=DesUtil.decrypt(pd.getString("data").replaceAll(" ","+"));
			//String data=pd.getString("data");
			//System.out.println(data+"data");
			JSONObject string_to_json = JSONObject.fromObject(data);
			JSONObject json_to_data = string_to_json.getJSONObject("data");
			pd.put("uid", json_to_data.get("uid"));
			pd.put("devid", json_to_data.get("devid"));
			//pd.put("openid", json_to_data.get("gid"));
			PageData pducode =appuserService.findSysnc(pd);
			if(pducode!=null){
				JSONObject object_data = new JSONObject();
				object_print.put("status", "200");
			
			}else{
				object_print.put("status", "300");
				object_print.put("info", "在其他设备上登录");
			}
		}else{
			object_print.put("status", "201");
			object_print.put("info", "未获取相应的信息");
		}
		
		ResponseUtils.renderJson(response, DesUtil.encrypt(object_print.toString()));
		//ResponseUtils.renderJson(response, object_print.toString());
		//return msg.toString();
	}
	

	
	@ResponseBody
	@RequestMapping(value = "/time/timer")
	public void timer(HttpServletResponse response,HttpServletRequest request) throws Exception { 
		//参数组
		//System.out.println(request.getParameter("data"));
		request.setCharacterEncoding("GBK");
		response.setCharacterEncoding("GBK");
		PageData pd = new PageData();
		pd = this.getPageData();
		JSONObject object = new JSONObject();
		
		java.util.Date dt = new Date();
		System.out.println(dt.toString());   //java.util.Date的含义
		long lSysTime1 = dt.getTime() / 1000;   //得到秒数，Date类型的getTime()返回毫秒数
		object.put("data", lSysTime1);
		object.put("cmd", "LOGIN");
		ResponseUtils.renderJson(response, object.toString());
		//return msg.toString();
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/dialback")
	public void dailback(HttpServletResponse response,HttpServletRequest request) throws Exception { 
		//参数组
		//System.out.println(request.getParameter("data"));
		request.setCharacterEncoding("GBK");
		response.setCharacterEncoding("GBK");
		String userData=request.getParameter("userData");
		String callid=request.getParameter("callid");
		System.out.println("返回参数userData："+userData+"callid:"+callid);
		PageData pd = new PageData();
		pd = this.getPageData();
		JSONObject object = new JSONObject();
		
		java.util.Date dt = new Date();
		System.out.println(dt.toString());   //java.util.Date的含义
		long lSysTime1 = dt.getTime() / 1000;   //得到秒数，Date类型的getTime()返回毫秒数
		object.put("data", lSysTime1);
		object.put("cmd", "LOGIN");
		ResponseUtils.renderJson(response, object.toString());
		//return msg.toString();
	}
	
	
	
	/**
     * 图片文件上传
     */
    @ResponseBody
    @RequestMapping(value = "/AppUploadFile",method = RequestMethod.POST)
    public void appUploadFile(@RequestParam(value="upload_1") MultipartFile file,HttpServletRequest request,HttpServletResponse response,HttpSession session) throws IllegalStateException, IOException{
       
    	
    	/*"callRecPath" -> "10086_0_1551455317275.aac" 【文件名】
    	"recTime" -> "2019-03-01 23:48:37" 【录音时间】
    	"fileKey" -> "1" 【本地序号】
    	"upload_1" -> 【文件】
    	"userid" -> "1" 【用户IDid】
    	"startLong" -> "1551455317541" 【录音开始时间】
    	"inout" -> "0" 【0 呼入 1 呼出】
    	"driverId" -> "358240051111110"【设号】
    	"callNumber" -> "10086" 【电话号码】
    	"endLong" -> "1551455323501"【录音结束时间】
    	"guid" -> "4a10602d-bf94-4e1a-ba0e-0f2aa8982f37" 随机guid
    	"endTime" -> "2019-03-01 23:48:43"【结束时间】*/
    	
    	
    	JSONObject object = new JSONObject();
    	PageData pd = new PageData();
		pd = this.getPageData();
		//System.out.println(request.getParameter("callRecPath")+"callRecPath");
		pd.put("callRecPath", request.getParameter("callRecPath"));
		pd.put("recTime", request.getParameter("recTime"));
		pd.put("fileKey", request.getParameter("fileKey"));
		pd.put("startLong", request.getParameter("startLong"));
		pd.put("userid", request.getParameter("userid"));
		pd.put("inout", request.getParameter("inout"));
		pd.put("driverId", request.getParameter("driverId"));
    	
    	pd.put("callNumber", request.getParameter("callNumber"));
		pd.put("endLong", request.getParameter("endLong"));
		pd.put("guid", request.getParameter("guid"));
		pd.put("endTime", request.getParameter("endTime"));
		String path="";// 文件路径
		String fileName=file.getOriginalFilename();// 文件原名称
        if (file!=null) {// 判断上传的文件是否为空
            String type=null;// 文件类型
           
            System.out.println("上传的文件原名称:"+fileName);
            // 判断文件类型
            type=fileName.indexOf(".")!=-1?fileName.substring(fileName.lastIndexOf(".")+1, fileName.length()):null;
            if (type!=null) {// 判断文件类型是否为空
                if ("GIF".equals(type.toUpperCase())||"aac".equals(type.toUpperCase())||"AAC".equals(type.toUpperCase())||"acc".equals(type.toUpperCase())||"ACC".equals(type.toUpperCase())) {
                    // 项目在容器中实际发布运行的根路径
                    String realPath=request.getSession().getServletContext().getRealPath("/");
                    // 自定义的文件名称
                   // String trueFileName=String.valueOf(System.currentTimeMillis())+fileName;
                    // 设置存放图片文件的路径
                    path="uploadFiles/uploadImgs/"+/*System.getProperty("file.separator")+*/fileName;
                    System.out.println("存放图片的路径:"+path);
                    // 转存文件到指定的路径
                    file.transferTo(new File(realPath+path));
                    System.out.println("文件成功上传到指定目录下");
                }else {
                    System.out.println("不是我们想要的文件类型,请按要求重新上传");
                   // return null;
                }
            }else {
                System.out.println("文件类型为空");
               // return null;
            }
        }
        pd.put("uploadfile", path);
        try {
			appuserService.saveAppUploadFile(pd);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        if(!path.equals("")){
        	object.put("status", "200");
     		object.put("downpath", this.getUrl()+"uploadFiles/uploadImgs/"+fileName);
        }else{
        	object.put("status", "201");
     		object.put("downpath", "");
        }
       
		ResponseUtils.renderJson(response, object.toString());
    }
    
    
    public static String getUrl(){
	    String url = "";
	    Properties properties = new Properties();
	    
	    InputStream is = IntAppuserController.class.getClassLoader().getResourceAsStream("dbconfig.properties");
	    try
	    {
	      properties.load(is);
	    }
	    catch (IOException e)
	    {
	      e.printStackTrace();
	    }
	    url = properties.getProperty("wburl");
	    return url;
	  }

    
    
    /**修改用户
	 * @param out
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/detail")
	public ModelAndView detail(PrintWriter out) throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		
		PageData zskBean = appuserService.getZskByid(pd);		//列出会员列表
		List<PageData> zskcontList=appuserService.listZskByzsid(pd);
		mv.addObject("zskBean", zskBean);
		mv.addObject("zskcontList", zskcontList);
		mv.addObject("msg","success");
		mv.setViewName("wxweb/detail_mx");
		return mv;
	}
	
	
}
	
 