package com.fh.util.weixin;
import java.util.ArrayList;

import java.util.Date;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import com.alibaba.fastjson.JSONObject;

public class httpclient {

	/*入参说明
	 * 
	 * param url 请求地址
	 * param jsonObject	请求的json数据
	 * param encoding	编码格式
	 * 
	 * */
	public static String jsonPost(String url,JSONObject jsonObject,String encoding){
		CloseableHttpClient httpclient = HttpClientBuilder.create().build();
		HttpPost post = new HttpPost(url);
		String response = null;
		try {
			StringEntity s = new StringEntity(jsonObject.toString());
			s.setContentEncoding(encoding);
			s.setContentType("application/json");//发送json数据需要设置contentType
			post.setEntity(s);
			HttpResponse res = httpclient.execute(post);
			if(res.getStatusLine().getStatusCode() == HttpStatus.SC_OK){
				String result = EntityUtils.toString(res.getEntity());// 返回json格式：
				response = JSONObject.toJSONString(result);
			}
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
		return response;
	}


	/*入参说明
	 * 
	 * param url 请求地址
	 * param map	请求的map数据
	 * param encoding	编码格式
	 * 
	 * */
	public static String mapPost(String url, Map<String,Object> map, String encoding){
		CloseableHttpClient httpClient = null;
		HttpPost httpPost = null;
		String result = null;
		try{
			httpClient = HttpClients.createDefault();
			httpPost = new HttpPost(url);
			//设置参数
			List<NameValuePair> list = new ArrayList<NameValuePair>();
			Iterator iterator = map.entrySet().iterator();
			while(iterator.hasNext()){
				Map.Entry<String,String> elem = (Map.Entry<String, String>) iterator.next();
				list.add(new BasicNameValuePair(elem.getKey(),String.valueOf(elem.getValue())));
			}
			if(list.size() > 0){
				UrlEncodedFormEntity entity = new UrlEncodedFormEntity(list,encoding);
				httpPost.setEntity(entity);
			}
			HttpResponse response = httpClient.execute(httpPost);
			if(response != null){
				HttpEntity resEntity = response.getEntity();
				if(resEntity != null){
					result = EntityUtils.toString(resEntity,encoding);
				}
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return result;
	}


	public static void main(String[] args) {
		String result = "";

		//一个json数据的post请求
		//版本号
		Integer apiVersion = 1;
		//时间戳
		Long txnDate = new Date().getTime();

		//封装json数据
		JSONObject obj = new JSONObject();
		obj.put("apiVersion", apiVersion);
		obj.put("txnDate", txnDate);

		//提交请求
		result = jsonPost("请求地址", obj,"utf-8");
		System.out.println(result);
		//当时在测试的时候，返回的参数会出现中文乱码。这个是因为返回的参数使用了Unicode编码。所以用json转一下就可以了。

		JSONObject jsonObject=JSONObject.parseObject(result);
		result = jsonObject.toJSONString();


		System.out.println("---------------------------------------------");


		//一个map数据的post请求
		//版本号
		Integer apiVersion2 =1;
		//时间戳
		Long txnDate2 = new Date().getTime();

		//封装map数据
		Map<String, Object> obj2 = new HashMap<String, Object>();
		obj2.put("apiVersion2", apiVersion2);
		obj2.put("txnDate2", txnDate2);

		//提交请求
		result = mapPost("请求地址", obj2,"utf-8");
		System.out.println(result);

	}
}
