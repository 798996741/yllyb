package com.fh.controller.app.appuser;



import org.apache.http.client.ClientProtocolException;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fh.controller.base.BaseController;
import com.fh.entity.SendBean;
import com.fh.service.system.appuser.AppuserManager;
import com.fh.service.system.appuser.WeiXinUserInfoService;
import com.fh.service.system.appuser.WxManager;
import com.fh.util.Jurisdiction;
import com.fh.util.MD5;
import com.fh.util.PageData;
import com.fh.util.weixin.WeiXinUser;
import com.fh.util.weixin.WeiXinUtil;
import com.fh.util.weixin.WeixinAPIHelper;
import com.lzzj.utils.ResponseUtils;
import com.shpro.entity.AreaManage;
import com.shpro.service.areamanage.AreaManageManager;
import com.shpro.service.zcinfo.ZcinfoManager;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.fh.entity.TreeNode;
/**
 * @author huangjianling
 * @create 2018-01-18 17:47
 * @desc 获取微信用户的所有信息，这个主要是为了不要用户自己填写个人信息
 **/
@Controller
@RequestMapping(value="/appweixin")
public class WeiXinUserInfoController extends BaseController {
 
	@Resource(name="appuserService")
	private AppuserManager appuserService;
	
	 @Resource(name="weiXinUserInfoService")
	private WeiXinUserInfoService userService;
 
	@Resource(name="zcinfoService")
	private ZcinfoManager zcinfoService;
	@Resource(name="areamanageService")
	private AreaManageManager areamanageService;
    /**
     * 进行网页授权，便于获取到用户的绑定的内容
     * @param request
     * @param session
     * @param map
     * @return
     * @throws Exception 
     */
    @RequestMapping("/userinfo")
    public ModelAndView check(HttpServletRequest request , HttpSession session, Map<String, Object> map) throws Exception {
        //首先判断一下session中，是否有保存着的当前用户的信息，有的话，就不需要进行重复请求信息
        WeiXinUser  weiXinUser = null ;
        ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
        if(session.getAttribute("currentUser") != null){
            weiXinUser = (WeiXinUser) session.getAttribute("currentUser");
        }else {
            /**
             * 进行获取openId，必须的一个参数，这个是当进行了授权页面的时候，再重定向了我们自己的一个页面的时候，
             * 会在request页面中，新增这个字段信息，要结合这个ProjectConst.Get_WEIXINPAGE_Code这个常量思考
             */
            String code = request.getParameter("code");
            try {
                //得到当前用户的信息(具体信息就看weixinUser这个javabean)
            	System.out.println("code"+code);
                weiXinUser = getTheCode(session, code);
                //将获取到的用户信息，放入到session中
                session.setAttribute("currentUser", weiXinUser);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        map.put("weiXinUser", weiXinUser);
        mv.addObject("OPENDID", weiXinUser.getOpenId());
       
        //测试
       // weiXinUser=new WeiXinUser();
        //weiXinUser.setOpenId("983WXXDewojdd");
        
        
        mv.addObject("weiXinUser",weiXinUser);
        pd.put("AREA_LEVEL", "2");
        List<PageData> arealist =areamanageService.listAll(pd);
        mv.addObject("arealist",arealist);
        
        
        mv.setViewName("wxweb/userbind");
		return mv;
    }
 
    @RequestMapping("/userreg")
    public ModelAndView userreg(HttpServletRequest request , HttpSession session, Map<String, Object> map) throws Exception {
        //首先判断一下session中，是否有保存着的当前用户的信息，有的话，就不需要进行重复请求信息
        WeiXinUser  weiXinUser = null ;
        ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
        pd=this.getPageData();
       // map.put("weiXinUser", weiXinUser);
      //  mv.addObject("OPENDID", weiXinUser.getOpenId());
        //测试
        mv.addObject("OPENID",pd.getString("OPENID"));
        //pd.put("AREA_LEVEL", "2");
        List<PageData> arealist =areamanageService.listAll(pd);
        mv.addObject("arealist",arealist);
        
        List<TreeNode> data = new ArrayList<>();
        TreeNode maparea = new TreeNode(null, null, null);
        for(PageData pdarea:arealist){
        	maparea = new TreeNode(pdarea.getString("AREA_CODE"), pdarea.getString("NAME"), pdarea.getString("PARENT_ID"));
        	//System.out.println("json1:"+maparea);
            data.add(maparea);
        }

        
       List<TreeNode> nodeList = new ArrayList();

        for(TreeNode node1:data){
        	 boolean mark = false;
        	 for(TreeNode node2:data){
        		if(node1.getPid()!=null&&node1.getPid().equals(node2.getId())){
        			mark = true;
        			if(node2.getChildren()==null)
        				node2.setChildren(new ArrayList<TreeNode>());
        			 	node2.getChildren().add(node1);
        			break;
        		}
        	}
        	if(!mark){
        		nodeList.add(node1);
        	}
        }	
        String json = JSON.toJSONString(nodeList);
        json=json.replace("pid", "parent");
        json=json.replace("id", "value");
       // System.out.println(json);
        
       // System.out.println(JSON.toJSONString(data));
       // JSONArray result = listToTree(JSONArray.parseArray(JSON.toJSONString(data)),"id","pid","children");
        //System.out.println(JSON.toJSONString(result));
        pd.put("dict_type", "byyx");
    	List<PageData> byyxlist =userService.listDictBytype(pd);
        mv.addObject("byyxlist",byyxlist);
        mv.addObject("byyxjson", JSON.toJSONString(byyxlist).replace("id", "value").replace("dict_name", "text"));
       
       
        mv.addObject("areajson",json);
        if(pd.getString("type")!=null&&pd.getString("type").equals("1")){
            mv.setViewName("wxweb/personuser");
        }else{
        	pd.put("dict_type", "captail");
        	List<PageData> captaillist =userService.listDictBytype(pd);
        	
        	pd.put("dict_type", "qygm");
        	List<PageData> qygmlist =userService.listDictBytype(pd);
        	
        	System.out.println(JSON.toJSONString(captaillist));
        	if(captaillist!=null&&captaillist.size()>0){
                mv.addObject("captaillist",JSON.toJSONString(captaillist).replace("id", "value").replace("dict_name", "text"));
        		
        	}
        	
        	if(qygmlist!=null&&qygmlist.size()>0){
                mv.addObject("qygmjson",JSON.toJSONString(qygmlist).replace("id", "value").replace("dict_name", "text"));
        	}
            mv.setViewName("wxweb/companyuser");
        }
       
		return mv;
    }
    
    public static JSONArray listToTree(JSONArray arr,String id,String pid,String child){
    	JSONArray r = new JSONArray();
    	JSONObject hash = new JSONObject();
    	//将数组转为Object的形式，key为数组中的id
    	for(int i=0;i<arr.size();i++){
    		JSONObject json = (JSONObject) arr.get(i);
    		hash.put(json.getString(id), json);
    	}
    	//遍历结果集
    	for(int j=0;j<arr.size();j++){
    		//单条记录
    		JSONObject aVal = (JSONObject) arr.get(j);
    		//在hash中取出key为单条记录中pid的值
    		//System.out.println(aVal.get(j)+String.valueOf(aVal.get(pid)));
    		//if(aVal.get(pid)!=null){
    			JSONObject hashVP = (JSONObject) hash.get(aVal.get(pid).toString());
        		//如果记录的pid存在，则说明它有父节点，将她添加到孩子节点的集合中
    			System.out.println(aVal.get(j)+String.valueOf(aVal.get(pid))+"hashVP:"+hashVP);
        		if(hashVP!=null){
        			//检查是否有child属性
        			if(hashVP.get(child)!=null){
        				JSONArray ch = (JSONArray) hashVP.get(child);
        				ch.add(aVal);
        				hashVP.put(child, ch);
        			}else{
        				JSONArray ch = new JSONArray();
        				ch.add(aVal);
        				hashVP.put(child, ch);
        			}
        		}else{
        			r.add(aVal);
        		}
    		//}
    		
    	}
    	return r;
    }
    
    /**
     * 获取用户的openId
     * @param session
     * @param code
     * @return 返回封装的微信用户的对象
     */
    private WeiXinUser getTheCode(HttpSession session, String code) {
        Map<String,String>  authInfo = new HashMap<>();
        String openId = "";
        if (code != null)
        {
            // 调用根据用户的code得到需要的授权信息
            authInfo= userService.getAuthInfo(code);
           //获取到openId
            openId = authInfo.get("Openid");
            System.out.println("openId:"+openId);
        }
        // 获取基础刷新的接口访问凭证（目前还没明白为什么用authInfo.get("AccessToken");这里面的access_token就不行）
        String accessToken="";
		try {
			accessToken = WeiXinUtil.getAccessToken().getToken();
		} catch (ClientProtocolException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        //获取到微信用户的信息
        WeiXinUser userinfo = userService.getUserInfo(accessToken ,openId);
 
        return userinfo;
    }
    
    
    //发送信息
    @RequestMapping("/sendMsg")
    public void String(HttpServletRequest request , HttpSession session){
    	String openid=request.getParameter("openid");
    	WeixinAPIHelper weixinAPIHelper=new WeixinAPIHelper();
		try {
			PageData pd_zcinfo = new PageData();
			PageData pd = new PageData();
			pd.put("OPENID", openid);
			pd_zcinfo=zcinfoService.findByOpenId(pd);
			if(pd_zcinfo==null||pd_zcinfo.getString("OPENID")==null){
				PageData pd_param = new PageData();
				//PageData pd = new PageData();
				pd.put("param_name", "register_send");
				pd_param=zcinfoService.findParam(pd);
				
				String sendstr="";
				if(pd_param!=null){
					sendstr=pd_param.getString("param_val");
				}else{
					sendstr="您好，感谢您关注政策申领机器人^福社宝^。\n\n小宝将为您提供最新的政策精准推送、政策申领指南以及便民咨询等服务。\n\n快来注册成为我们^福社宝^的粉丝吧，小宝将为您量身推送，您需要的政策福利信息。<a href='https://open.weixin.qq.com/connect/oauth2/authorize?appid=wxb24a2fd8af029cd6&redirect_uri=http://webchat.ada-robotics.com/recordpro/appweixin/userinfo&response_type=code&scope=snsapi_userinfo&state=1&connect_redirect=1#wechat_redirect'>马上注册</a>";
				}
				weixinAPIHelper.sendTextMessageToUser(sendstr, openid);
			}
			//weixinAPIHelper.sendNewsToUser("oAsoBwemNEoYpTMFkPdiuolFFoxo");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
    
    
    
    
    
    /**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/saveZcinfo")
	public void saveZcinfo(PrintWriter out) throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("WXUSER_ID", this.get32UUID());	//主键
		PageData pd_zcinfo = new PageData();
		pd_zcinfo=zcinfoService.findByOpenId(pd);
		if(pd_zcinfo!=null&&pd_zcinfo.getString("OPENID")!=null){
			out.write("error");
			out.close();
		}else{
			//userinfo
			String AGE=pd.getString("AGE")==null?"0":pd.getString("AGE");
			String USERTYPE=pd.getString("USERTYPE")==null?"":pd.getString("USERTYPE");
			String JOB=pd.getString("JOB")==null?"":pd.getString("JOB");
			String SEX=pd.getString("SEX")==null?"":pd.getString("SEX");
			String CAPTAIL=pd.getString("CAPTAIL")==null?"":pd.getString("CAPTAIL");
			String ZYJR=pd.getString("ZYJR")==null?"":pd.getString("ZYJR");
			
			String OPENID=pd.getString("OPENID")==null?"":pd.getString("OPENID");
			int age=Integer.parseInt(AGE);
			
			

			List<SendBean> objlist = new ArrayList<>();
			SendBean sendBean=new SendBean();
			if(!AGE.equals("0")){
				sendBean=new SendBean();
				sendBean.setField("age");
				sendBean.setTypevalue(AGE);
				objlist.add(sendBean);
			}
			if(!USERTYPE.equals("")){
				sendBean=new SendBean();
				if(USERTYPE.equals("1")){
					USERTYPE="个人";
				}
				if(USERTYPE.equals("2")){
					USERTYPE="企业";
				}
				sendBean.setField("usertype");
				sendBean.setTypevalue(USERTYPE);
				objlist.add(sendBean);
			}
			if(!JOB.equals("")){
				sendBean=new SendBean();
				sendBean.setField("job");
				sendBean.setTypevalue(JOB);
				objlist.add(sendBean);
			}
			if(!ZYJR.equals("")){
				sendBean=new SendBean();
				sendBean.setField("zyjr");
				sendBean.setTypevalue(ZYJR);
				objlist.add(sendBean);
			}
			if(!SEX.equals("")){
				sendBean=new SendBean();
				if(SEX.equals("1")){
					SEX="男";
				}
				if(SEX.equals("2")){
					SEX="女";
				}
				sendBean.setField("sex");
				sendBean.setTypevalue(SEX);
				objlist.add(sendBean);
			}

			if(!CAPTAIL.equals("")){
				sendBean=new SendBean();
				pd.put("dict_type", "captail");
				pd.put("dict_id", CAPTAIL);
	        	PageData captailBean =userService.listDictByid(pd);
	        	if(captailBean!=null){
	        		CAPTAIL=captailBean.getString("dict_name");
	        	}
				sendBean.setField("captail");
				sendBean.setTypevalue(CAPTAIL);
				objlist.add(sendBean);
			}
			//缴纳社保
			if(!JOB.equals("")){
				sendBean=new SendBean();
				sendBean.setField("job");
				sendBean.setTypevalue(JOB);
				objlist.add(sendBean);
			}
			
			pd.put("objList",objlist);
			List<PageData> questionList=appuserService.listZsidByfield(pd);
			//System.out.println("questionList:"+questionList);
			for(PageData pdzsid:questionList){
				String zsid=String.valueOf(pdzsid.get("zsid"));
				
				
				pd.put("zsid", zsid);
				PageData zskBean = appuserService.getZskByid(pd);		//列出会员列表
				this.sendMsg(OPENID, zskBean.getString("zstitle"));
				
			}
			if(age>=45&&age<=50&&JOB.equals("0")&&USERTYPE.equals("1")){
				WeixinAPIHelper weixinAPIHelper=new WeixinAPIHelper();
				try {
					String msg="1.<a href='http://webchat.ada-robotics.com/recordpro/appweixin/detail?action=rhsq'>就业困难人员社保</a>\n"
							+ "2.<a href='http://webchat.ada-robotics.com/recordpro/appweixin/detail?action=sbbt'>领取失业金补贴</a>\n"
							+ "3.<a href='http://webchat.ada-robotics.com/recordpro/appweixin/detail?action=sbbtsq'>子女高校毕业一年未就业怎么办</a>";
					//System.out.println("1111");
					
					//this.sendMsg(OPENID, "个人就业困难人员社保补贴");
					
					//this.sendMsg(OPENID, "领取失业金补贴");
					//this.sendMsg(OPENID, "子女高校毕业一年未就业怎么办");
					//weixinAPIHelper.sendTextMessageToUser(msg,OPENID);
					//weixinAPIHelper.sendNewsToUser("oAsoBwemNEoYpTMFkPdiuolFFoxo");
				}  catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
			zcinfoService.save(pd);
			out.write("success");
			out.close();
		}
		
		
	}
    
	public static void main(String[] args){
		WeixinAPIHelper weixinAPIHelper=new WeixinAPIHelper();
        try {
			weixinAPIHelper.sendTextMessageToUser("1", "oAsoBwemNEoYpTMFkPdiuolFFoxo");
		} catch (ClientProtocolException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		};
		WeiXinUserInfoController weiXinUserInfoController=new WeiXinUserInfoController();
		weiXinUserInfoController.sendMsg("oAsoBwemNEoYpTMFkPdiuolFFoxo", "子女高校毕业一年未就业怎么办");
	}
	
	
	
	
	 public void sendMsg(String openid,String msg){
    	URL url;
    	OutputStream os =null;
    	InputStream is =null;
        try {
        	
        	//String Content=request.getParameter("Content")==null?"":request.getParameter("Content");	
        	//String FromUserName=request.getParameter("FromUserName")==null?"":request.getParameter("FromUserName");	
        	//String MsgId=request.getParameter("MsgId")==null?"":request.getParameter("MsgId");
        	//String CreateTime=request.getParameter("CreateTime")==null?"":request.getParameter("CreateTime");
        	java.util.Date dt = new Date();
    		long CreateTime = dt.getTime() / 1000;   //得到秒数，Date类型的getTime()返回毫秒数
        	String MsgId=CreateTime+"11";
        	//System.out.println(URLEncoder.encode(msg,"utf-8"));
            url = new URL("http://webchat.ada-robotics.com/wx/sendAda?Content="+URLEncoder.encode(msg,"utf-8")+"&FromUserName="+openid+"&CreateTime="+CreateTime+"&MsgId="+MsgId+"");
            HttpURLConnection http = (HttpURLConnection) url.openConnection();
            http.setRequestMethod("GET");
            http.setRequestProperty("Content-Type",  "application/x-www-form-urlencoded");
            http.setDoOutput(true);
            http.setDoInput(true);
            System.setProperty("sun.net.client.defaultConnectTimeout", "30000");// 连接超时30秒
            System.setProperty("sun.net.client.defaultReadTimeout", "30000"); // 读取超时30秒
            http.connect();
            os = http.getOutputStream();
            String json=msg;
            os.write(json.getBytes("UTF-8"));// 传入参数
            is = http.getInputStream();
            int size = is.available();
            byte[] jsonBytes = new byte[size];
            is.read(jsonBytes);
            String result = new String(jsonBytes, "UTF-8");
           // System.out.println("请求返回结果:"+result);
            
            
            this.readStringXml(result);
            os.flush();
            os.close();
            
        } catch (Exception e) {
            e.printStackTrace();
        	if(os!=null){
        		 try {
					os.flush();
					os.close();
				} catch (IOException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
                 
        	}
        }

    }
	 
	 public void readStringXml(String xml) {
        Document doc = null;
        try {
            // 读取并解析XML文档
            // SAXReader就是一个管道，用一个流的方式，把xml文件读出来
            // SAXReader reader = new SAXReader(); //User.hbm.xml表示你要解析的xml文档
            // Document document = reader.read(new File("User.hbm.xml"));
            // 下面的是通过解析xml字符串的
            doc = DocumentHelper.parseText(xml); // 将字符串转为XML
            Element rootElt = doc.getRootElement(); // 获取根节点
           // System.out.println("根节点：" + rootElt.getName()+rootElt.elementText("ToUserName")); // 拿到根节点的名称
            String username=rootElt.elementText("ToUserName");
            String Content=rootElt.elementText("Content");
        	WeixinAPIHelper weixinAPIHelper=new WeixinAPIHelper();
            weixinAPIHelper.sendTextMessageToUser(Content, username);;
           
        } catch (DocumentException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
	
	@RequestMapping(value = "/getAreaByparent")
	@ResponseBody
	public void getAreaByparent(HttpServletResponse response,HttpServletRequest request) throws Exception{
		response.setContentType("textml;charset=UTF-8"); 
		JSONObject object = new JSONObject();
		List<JSONObject> objectlist = new ArrayList();
		JSONObject object_new = new JSONObject();
		PageData pd = new PageData();
		pd=this.getPageData();
		List<AreaManage> areaList = areamanageService.listByParentId(String.valueOf(pd.getString("PARENT_ID")));	//判断是否tokenid失效
		if(areaList.size() > 0 ){
			for(AreaManage area:areaList){
				 object = new JSONObject();
				 object.put("AREA_CODE", area.getFAREA_CODE());
				 object.put("AREA_ID", area.getAREA_ID());
				 object.put("AREA_NAME", area.getNAME());
				 objectlist.add(object);
			}
		}
		ResponseUtils.renderJson(response, objectlist.toString());
	}
	
	
	@RequestMapping("/detail")
    public ModelAndView detail(HttpServletRequest request , HttpSession session, Map<String, Object> map) throws Exception {
        //首先判断一下session中，是否有保存着的当前用户的信息，有的话，就不需要进行重复请求信息
        WeiXinUser  weiXinUser = null ;
        ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
        pd=this.getPageData();
       // map.put("weiXinUser", weiXinUser);
      //  mv.addObject("OPENDID", weiXinUser.getOpenId());
        //测试
       
        if(pd.getString("action")!=null){
        	 String tzurl="wxweb/detail_"+pd.getString("action");
            mv.setViewName(tzurl);
        }
		return mv;
    }
	
	@RequestMapping("/detail_mx")
    public ModelAndView detail_mx(HttpServletRequest request , HttpSession session, Map<String, Object> map) throws Exception {
        //首先判断一下session中，是否有保存着的当前用户的信息，有的话，就不需要进行重复请求信息
        WeiXinUser  weiXinUser = null ;
        ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
        pd=this.getPageData();
       // map.put("weiXinUser", weiXinUser);
      //  mv.addObject("OPENDID", weiXinUser.getOpenId());
        //测试
        PageData zskBean = appuserService.getZskByid(pd);		//列出会员列表
		List<PageData> zskcontList=appuserService.listZskByzsid(pd);
		List<PageData> questionList=appuserService.listQuestionByzsid(pd);
		mv.addObject("pd", pd);
		mv.addObject("zskBean", zskBean);
		mv.addObject("zskcontList", zskcontList);
		mv.addObject("questionList", questionList);
		mv.addObject("msg","success");
		mv.setViewName("wxweb/detail_mx");
		return mv;
    }
	
	
	@RequestMapping("/detail_material")
    public ModelAndView detail_material(HttpServletRequest request , HttpSession session, Map<String, Object> map) throws Exception {
        //首先判断一下session中，是否有保存着的当前用户的信息，有的话，就不需要进行重复请求信息
        WeiXinUser  weiXinUser = null ;
        ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
        pd=this.getPageData();
       // map.put("weiXinUser", weiXinUser);
      //  mv.addObject("OPENDID", weiXinUser.getOpenId());
        //测试
        PageData zskBean = appuserService.getZskByid(pd);		//列出会员列表
		List<PageData> zskcontList=appuserService.listZskByzsid(pd);
		for(PageData pd_zsk:zskcontList){
			
			String zsget=pd_zsk.getString("zsget")==null?"":pd_zsk.getString("zsget");
			if(zsget.indexOf("appweixin/detail_mx.do")>=0){
				pd_zsk.put("isurl", "1");
				zsget=zsget.replace("<p>", "").replace("</p>", "").replace("<br>", "");
			}
			pd_zsk.put("zsget", zsget);
			
		}
		
		//List<PageData> questionList=appuserService.listQuestionByzsid(pd);
		mv.addObject("pd", pd);
		
		mv.addObject("zskBean", zskBean);
		mv.addObject("zskcontList", zskcontList);
		//mv.addObject("questionList", questionList);
		mv.addObject("msg","success");
		mv.setViewName("wxweb/detail_material");
		return mv;
    }
	
	
	@RequestMapping("/zskcont_mx")
    public ModelAndView zskcont_mx(HttpServletRequest request , HttpSession session, Map<String, Object> map) throws Exception {
        //首先判断一下session中，是否有保存着的当前用户的信息，有的话，就不需要进行重复请求信息
        WeiXinUser  weiXinUser = null ;
        ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
        pd=this.getPageData();
       // map.put("weiXinUser", weiXinUser);
        //  mv.addObject("OPENDID", weiXinUser.getOpenId());
        //测试
        String action=pd.getString("action")==null?"":pd.getString("action");
        if(action.equals("source")){
        	PageData zskcontBean = appuserService.getSourceByid(pd);		//列出会员列表
        	mv.addObject("zskcontBean", zskcontBean);
        	mv.addObject("pd", pd);
        }else{
	        PageData zskcontBean = appuserService.getZskcontByid(pd);		//列出会员列表
	        PageData zskBean = appuserService.getZskByid(pd);		//列出会员列表
			mv.addObject("zskcontBean", zskcontBean);
			mv.addObject("zskBean", zskBean);
			mv.addObject("pd", pd);
			mv.addObject("msg","success");
        }
		mv.setViewName("wxweb/zskcont_mx");
		return mv;
    }
	
	
	@RequestMapping("/question_mx")
    public ModelAndView question_mx(HttpServletRequest request , HttpSession session, Map<String, Object> map) throws Exception {
        //首先判断一下session中，是否有保存着的当前用户的信息，有的话，就不需要进行重复请求信息
        WeiXinUser  weiXinUser = null ;
        ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
        pd=this.getPageData();
       // map.put("weiXinUser", weiXinUser);
      //  mv.addObject("OPENDID", weiXinUser.getOpenId());
        //测试
        PageData zskBean = appuserService.getZskByid(pd);		//列出会员列表
		List<PageData> questionList=appuserService.listQuestionByzsid(pd);
		mv.addObject("zskBean", zskBean);
		mv.addObject("questionList", questionList);
		mv.addObject("msg","success");
		mv.setViewName("wxweb/question_mx");
		return mv;
    }
	
	
	
	@RequestMapping("/template")
    public ModelAndView template(HttpServletRequest request , HttpSession session, Map<String, Object> map) throws Exception {
        //首先判断一下session中，是否有保存着的当前用户的信息，有的话，就不需要进行重复请求信息
        ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
        pd=this.getPageData();
        if(pd.getString("action")!=null){
        	 String tzurl="wxweb/template_"+pd.getString("action");
            mv.setViewName(tzurl);
        }
		return mv;
    }
	
    

	public void send(String openid,String msg){
		URL url;
		OutputStream os =null;
		InputStream is =null;
		try {
       	
       	//String Content=request.getParameter("Content")==null?"":request.getParameter("Content");	
       	//String FromUserName=request.getParameter("FromUserName")==null?"":request.getParameter("FromUserName");	
       	//String MsgId=request.getParameter("MsgId")==null?"":request.getParameter("MsgId");
       	//String CreateTime=request.getParameter("CreateTime")==null?"":request.getParameter("CreateTime");
       	java.util.Date dt = new Date();
   		long CreateTime = dt.getTime() / 1000;   //得到秒数，Date类型的getTime()返回毫秒数
       	String MsgId=CreateTime+"11";
        Date date = new Date();

        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        String datestr=df.format(date);
        SimpleDateFormat df1 = new SimpleDateFormat("yyyyMMddHHmmss");
        String datestr1=df1.format(date);
        String accountSid="00000000699efd07016a01ccaccc044c";
        String type="00000000699efd07016a01ccaccc044c";
        String areaCode="";
        String op="";
        
        //POST /2013-12-26/Accounts/8a000da854e74cfc0154ead9b9930000/nme/exclusive/010/setoutcall?sig =FB8E61DA357DA7BF6E14DD2D62226000 HTTP/1.1
       // Accept:application/json 
        //Content-Type:application/json;
       // charset=utf-8 
       // Authorization:Zm000DgwODEzYzM3ZGE1MzAxM2M4MDRmODA3MjAwN2M6MjAxMzAyMDEx 
        String NTA2000="{\"appId\":\"8a216da85607361a01560b33149502c50000\",  \"servingNumber\":\"01053820008\",  \"phoneNumber\":\"13500111111\",  \"callType\":\"1\" }";
         
        String sigParameter=MD5.md5(accountSid+"d3d30381501b49f9aae817a842f626da"+datestr1);
       	 String fwurl=datestr+"/Accounts/00000000699efd07016a01ccaccc044c/exclusive/010/setoutcall?sig="+sigParameter;
       //	/Accounts/{accountSid}/nme/{type}/{areaCode}/[/{op}]?sig={sigParameter} 
       	//System.out.println(URLEncoder.encode(msg,"utf-8"));
           url = new URL(fwurl);
           String authorization="";
           
           HttpURLConnection http = (HttpURLConnection) url.openConnection();
           http.setRequestMethod("POST");
          // http.s.setHeader("Accept-Charset", "utf-8");  

           http.setRequestProperty("Content-Type",  "application/json;charset=utf-8");
           http.setDoOutput(true);
           http.setDoInput(true);
           System.setProperty("sun.net.client.defaultConnectTimeout", "30000");// 连接超时30秒
           System.setProperty("sun.net.client.defaultReadTimeout", "30000"); // 读取超时30秒
           http.connect();
           os = http.getOutputStream();
           String json=msg;
           os.write(json.getBytes("UTF-8"));// 传入参数
           is = http.getInputStream();
           int size = is.available();
           byte[] jsonBytes = new byte[size];
           is.read(jsonBytes);
           String result = new String(jsonBytes, "UTF-8");
          // System.out.println("请求返回结果:"+result);
           
           
           this.readStringXml(result);
           os.flush();
           os.close();
           
       } catch (Exception e) {
           e.printStackTrace();
       	if(os!=null){
       		 try {
					os.flush();
					os.close();
				} catch (IOException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
                
       	}
       }

   }
	 
	
}
