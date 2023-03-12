package com.shpro.task;

import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import javax.annotation.Resource;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;








import com.fh.controller.app.appuser.WeiXinUserInfoController;
import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.SendBean;
import com.fh.entity.system.User;
import com.fh.service.system.appuser.AppuserManager;
import com.fh.service.system.appuser.WeiXinUserInfoService;
import com.fh.service.system.dictionaries.DictionariesManager;
import com.fh.service.system.fhlog.FHlogManager;
import com.fh.util.Jurisdiction;
import com.fh.util.Logger;
import com.fh.util.PageData;
import com.fh.util.Tools;
import com.shpro.service.zcinfo.ZcinfoManager;


@Component
public class AfterPromptMessageTask extends BaseController{

	protected Logger logger = Logger.getLogger(this.getClass());
	
	@Resource(name="weiXinUserInfoService")
	private WeiXinUserInfoService weiXinUserInfoService;
	
	@Resource(name="zcinfoService")
	private ZcinfoManager zcinfoService;
	
	@Resource(name="appuserService")
	private AppuserManager appuserService;
	
	@Resource(name="weiXinUserInfoService")
	private WeiXinUserInfoService userService;
	//用户名
	private static String Uid = "fuzhoukeer";

	//接口安全秘钥
	private static String Key = "d41d8cd98f00b204e980";

	Properties properties = new Properties();
	InputStream is =null;
	WeiXinUserInfoController weiXinUserInfoController=new WeiXinUserInfoController();
	

	@Resource(name="fhlogService")
	private FHlogManager FHLOG;

	


	public static void main(String[] args){
		/*float money=1;
		float bondEh=10;
		float bond=10;
		BigDecimal bd = new BigDecimal(money-bondEh);
		bd = bd.setScale(2, RoundingMode.HALF_UP);

		System.out.print(((money-bondEh)+bond)<0);

		String smsText = "您有未关闭陪护床,已扣除违 约金,请及时关锁";
		//System.out.println(MESSAGE);
		if(smsText.indexOf("box_code_str")>=0){
			//smsText=smsText.replace("box_code_str", box_code_str);
		}
		HttpClientUtil client = HttpClientUtil.getInstance();
		//UTF发送  短信提醒日志
		int result = client.sendMsgUtf8(Uid, Key, smsText, "15606063662");
		if(result > 0){
			System.out.println("UTF8成功发送条数=="+result);
		}else{
			System.out.println(client.getErrorMsg(result));
		}*/
		
		
		
		boolean result=false;
		try {
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date oldDate1 = format.parse("2018-12-19 10:03:00"); //这里时间可以自己定
			Date oldDate2 = format.parse("2018-12-19 12:00:00"); //这里时间可以自己定
			
			System.out.println(new AfterPromptMessageTask().plusDay(1, "2019-04-02"));
			//System.out.println(oldDate1.compareTo(oldDate2)); //判断,如果时间在这时间后,就执行后面操作
			//jztime：2018-12-19 12:59:00
			//result = new AfterPromptMessageTask().compare("2018-12-19 11:03:01", "2018-12-19 12:58:03");
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//new AfterPromptMessageTask().isTime("01:59", "12:59", 1, "18:00", "2018-12-19 11:00:00");
		//System.out.println(result);
	}


	@Scheduled(cron = "0/60 * * * * ? ") // 自动发送
	public void taskSendmsg() {
		//System.out.println("1");
		try {
			
			Properties properties = new Properties();
			Calendar c = Calendar.getInstance();  
			InputStream is = AfterPromptMessageTask.class.getClassLoader().getResourceAsStream("dbconfig.properties");
			try {
				properties.load(is);
			} catch (IOException e) {
				e.printStackTrace();
			}
			// 数据源进行各种有效的控制：
		   // 设置驱动
			String timerTime=properties.getProperty("timer.Time");//监听时间
			
			///timer = new Timer(true);   
			SimpleDateFormat df = new SimpleDateFormat("HH:mm");//设置日期格式
			String dqdate=df.format(new Date());
			//System.out.println(timerTime+dqdate);
			boolean boo=false;
			String senddate="";
			String date="";
			if(dqdate.equals(timerTime)){//时间相等
				PageData pd=new PageData();
				List<PageData> zskcontList=weiXinUserInfoService.listSendZsk(pd);
				for(PageData zskpd:zskcontList){ //获取需要发送的内容
					boo=false;
					String zsid=zskpd.get("zsid").toString();
					String zstitle=zskpd.getString("zstitle");
					String sendday=zskpd.get("sendday").toString()==null?"0":zskpd.get("sendday").toString();
					PageData zskend=weiXinUserInfoService.listSendLogByzsid(zskpd); //判断是否已经发送
					if(zskend==null){
						boo=true;
					}else{
						senddate=zskend.get("senddate").toString().substring(0,10); 
						if(senddate!=null&&this.plusDay(Integer.parseInt(sendday), senddate)){
							boo=true;
						}
					}
					if(boo){ //需要发送
						//List<PageData> zsksendList=weiXinUserInfoService.listSendZskByzsid(zskpd);//根据zsid 获取条件
						//
						List<PageData> zcinfoList=zcinfoService.listAll(zskpd);
						for(PageData zcinfopd:zcinfoList){ //获取需要发送的内容
							String AGE=zcinfopd.getString("AGE")==null?"0":zcinfopd.getString("AGE");
							String USERTYPE=zcinfopd.getString("USERTYPE")==null?"":zcinfopd.getString("USERTYPE");
							String JOB=zcinfopd.getString("JOB")==null?"":zcinfopd.getString("JOB");
							String SEX=zcinfopd.getString("SEX")==null?"":zcinfopd.getString("SEX");
							String CAPTAIL=zcinfopd.getString("CAPTAIL")==null?"":zcinfopd.getString("CAPTAIL");
							String ZYJR=zcinfopd.getString("ZYJR")==null?"":zcinfopd.getString("ZYJR");
							
							String OPENID=zcinfopd.getString("OPENID")==null?"":zcinfopd.getString("OPENID");
							
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
							pd.put("objList",objlist);
							pd.put("zsid",zsid);
							List<PageData> questionList=appuserService.listZsidByfield(pd);
							if(questionList.size()>0){ //符合条件
								pd.put("openid", OPENID);
								pd.put("zsid", zsid);
								pd.put("zstitle", zstitle);
								weiXinUserInfoController.sendMsg(OPENID, zstitle);
								//保存日志
								weiXinUserInfoService.saveSendlog(pd);
							}
							
						}
						
					}
					
					
				}
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			System.out.println("执行失败，一分钟后重新执行！");
			e.printStackTrace();
			logger.error(e.toString(), e);
		}

	}

	 public static boolean plusDay(int num,String endDate) throws ParseException{
		 SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		 Date  currdate = format.parse(endDate);
		 System.out.println("现在的日期是：" + currdate);
		 Calendar ca = Calendar.getInstance();
         ca.setTime(currdate);
         
		 ca.add(Calendar.DATE, num);// num为增加的天数，可以改变的
		 currdate = ca.getTime();
		 String enddate = format.format(currdate);
		 System.out.println("增加天数以后的日期：" + enddate);
		 
		 SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");//设置日期格式
	     String dqdate=df.format(new Date());
		 
		 boolean boo=false;
		 if(enddate.equals(dqdate)){
			 boo=true;
		 }
		 return boo;
	}
	
	

	 //方法一：需要传入一个Object数组，然后返回去重后的数组  
    public static String[] ifRepeat(String[] arr){  
        //用来记录去除重复之后的数组长度和给临时数组作为下标索引  
        int t = 0;  
        //临时数组  
        String[] tempArr = new String[arr.length];  
        //遍历原数组  
        for(int i = 0; i < arr.length; i++){  
            //声明一个标记，并每次重置  
            boolean isTrue = true;  
            //内层循环将原数组的元素逐个对比  
            for(int j=i+1;j<arr.length;j++){  
                //如果发现有重复元素，改变标记状态并结束当次内层循环  
                if(arr[i]==arr[j]){  
                    isTrue = false;  
                    break;  
                }  
            }  
            //判断标记是否被改变，如果没被改变就是没有重复元素  
            if(isTrue){  
                //没有元素就将原数组的元素赋给临时数组  
                tempArr[t] = arr[i];  
                //走到这里证明当前元素没有重复，那么记录自增  
                t++;  
            }  
        }  
        //声明需要返回的数组，这个才是去重后的数组  
        String[]  newArr = new String[t];  
        //用arraycopy方法将刚才去重的数组拷贝到新数组并返回  
        System.arraycopy(tempArr,0,newArr,0,t);  
        return newArr;  
    }  
	
	
}
