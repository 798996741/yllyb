package com.fh.util.voice;

import java.io.IOException;
import java.nio.charset.Charset;
 
import java.text.SimpleDateFormat;
import java.util.Date;

import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;
 





import Decoder.BASE64Encoder;

import com.fh.util.MD5;
import com.fh.util.UuidUtil;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
 
public class httpclients {
 
	// 接口地址
	public static String apiURL = "https://122.13.2.212:8883/2013-12-26/";
	private Log logger = LogFactory.getLog(this.getClass());
	private static final String pattern = "yyyy-MM-dd HH:mm:ss:SSS";
	private HttpClient httpClient = null;
	private HttpPost method = null;
	private long startTime = 0L;
	private long endTime = 0L;
	private int status = 0;
	public static String accountSid="00000000699efd07016a01ccaccc044c";
	public static String appId="00000000699efd07016a14d120f40618";
	public static String authtoken="d3d30381501b49f9aae817a842f626da";
	
 
	/**
	 * 接口地址
	 * 
	 * @param url
	 */
	public httpclients() {
 
		
		
		
		if (apiURL != null) {
			httpClient = new DefaultHttpClient();
			
 
		}
	}
 
	/**
	 * 调用 API
	 * 
	 * @param parameters
	 * @return
	 */
	public String post(String parameters,String fwurl) {
		String body = null;
		logger.info("parameters:" + parameters);
		Date date = new Date();
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        String datestr=df.format(date);
        SimpleDateFormat df1 = new SimpleDateFormat("yyyyMMddHHmmss");
        String datestr1=df1.format(date);
      
        String areaCode="";
        String op="";
        
    
       //	（账户 Id + 冒号 + 时间戳）
       	BASE64Encoder encoder = new BASE64Encoder();
       
		//apiURL=apiURL+fwurl;
		System.out.println(apiURL+fwurl);
		method = new HttpPost(apiURL+fwurl);
		if (method != null & parameters != null&& !"".equals(parameters.trim())) {
			try {
				byte[] textByte = (accountSid+":"+datestr1).getBytes("UTF-8");
		       	String authorization= encoder.encode(textByte); 
				// 建立一个NameValuePair数组，用于存储欲传送的参数
				method.addHeader("Content-type","application/json; charset=utf-8");
				method.setHeader("Accept", "application/json");
				method.setHeader("Authorization",authorization);
				method.setEntity(new StringEntity(parameters, Charset.forName("UTF-8")));
				startTime = System.currentTimeMillis();
 
				HttpResponse response = httpClient.execute(method);
				
				endTime = System.currentTimeMillis();
				int statusCode = response.getStatusLine().getStatusCode();
				
				logger.info("statusCode:" + statusCode);
				logger.info("调用API 花费时间(单位：毫秒)：" + (endTime - startTime));
				if (statusCode != HttpStatus.SC_OK) {
					logger.error("Method failed:" + response.getStatusLine());
					status = 1;
				}
 
				// Read the response body
				body = EntityUtils.toString(response.getEntity());
 
			} catch (IOException e) {
				// 网络错误
				status = 3;
			} finally {
				logger.info("调用接口状态：" + status);
			}
  
		}
		return body;
	}
 
	public static void main(String[] args) {
		httpclients ac = new httpclients();
		Date date = new Date();
		SimpleDateFormat df1 = new SimpleDateFormat("yyyyMMddHHmmss");
        String datestr1=df1.format(date);
        String sigParameter=MD5.md5(accountSid+authtoken+datestr1).toUpperCase();
       /* String fwurl="Accounts/"+accountSid+"/nme/exclusive/020/setnumber?sig="+sigParameter;
        JSONObject object = new JSONObject();
      //object.put("NTA2000", arry.toString());
        object.put("appId", appId);
  		object.put("servingNumber", "02022953114");
  		object.put("phoneNumber", "18060679662");
  		object.put("icDisplayFlag", "1");
  		object.put("needRecord", "1");
  		object.put("cdrNotifyUrl", "http://114.116.85.109:8050/yllyb/appuser/dialback");
  		 
  		//System.out.println(object.toString());
  		String result=ac.post(object.toString(),fwurl);*/
  		//System.out.println(result);
		//if(result!=null&&result.indexOf("000000")>=0){
			JSONObject object1 = new JSONObject();
			//object.put("NTA2000", arry.toString());
			String userData=UuidUtil.get32UUID();
			object1.put("appId", appId);
			object1.put("servingNumber", "02022953114");
			object1.put("calledPhoneNum", "13705934512");
			object1.put("callType", "1");
			 
			date = new Date();
			datestr1=df1.format(date);
			sigParameter=MD5.md5(accountSid+authtoken+datestr1).toUpperCase();
	       	String fwurl="Accounts/"+accountSid+"/nme/exclusive/020/setoutcall?sig="+sigParameter;
			
	       	//{"statusCode":"000000","msg":"","data":{"callId":"19043016092512170001012600467f63"}}
	       	
			System.out.println(ac.post(object1.toString(),fwurl));
		//}
		
	}
 
	/**
	 * 0.成功 1.执行方法失败 2.协议错误 3.网络错误
	 * 
	 * @return the status
	 */
	public int getStatus() {
		return status;
	}
 
	/**
	 * @param status
	 *            the status to set
	 */
	public void setStatus(int status) {
		this.status = status;
	}
 
	/**
	 * @return the startTime
	 */
	public long getStartTime() {
		return startTime;
	}
 
	/**
	 * @return the endTime
	 */
	public long getEndTime() {
		return endTime;
	}
}
