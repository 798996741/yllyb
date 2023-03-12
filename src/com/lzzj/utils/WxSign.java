package com.lzzj.utils;


import java.util.Iterator;
import java.util.Map;
import java.util.Random;
import java.util.Set;
import java.util.SortedMap;


public class WxSign {          
	private static String characterEncoding = "UTF-8";    
	@SuppressWarnings("rawtypes")  
	public static String createSign(SortedMap<Object,Object> parameters,String key){     
		StringBuffer sb = new StringBuffer();     
		Set es = parameters.entrySet();//所有参与传参的参数按照accsii排序（升序）     
		Iterator it = es.iterator();     
		while(it.hasNext()) {       
			Map.Entry entry = (Map.Entry)it.next();       
			String k = (String)entry.getKey();       
			Object v = entry.getValue();       
			if(null != v && !"".equals(v)&& !"sign".equals(k) && !"key".equals(k)) { 
				sb.append(k + "=" + v + "&");       
			}     
		}   
		
		sb.append("key=" + key);  
		System.out.println(sb);
		String sign = MD5Util.MD5Encode(sb.toString(),"UTF-8").toUpperCase();     
		return sign;   
	}      
	public static String getNonceStr() {    
		Random random = new Random();    
		return MD5Util.MD5Encode(String.valueOf(random.nextInt(10000)),"UTF-8");  
	}    
	public static String getTimeStamp() {    
		return String.valueOf(System.currentTimeMillis() / 1000);  
	}  
	public static void main(String[] args){
		WxSign sxSign=new WxSign();
		//String sign="appid=wxc8afaaef08c507cc&attach=无忧考证班&bank_type=CFT&cash_fee=1&fee_type=CNY&is_subscribe=N&mch_id=1307052501&nonce_str=8cb94e7a9661ea20b1293c589216d396&openid=o3IIZs_fPU8hjBD8htogYSkCZANM&out_trade_no=201601185632000043&result_code=SUCCESS&return_code=SUCCESS&time_end=20160118141103&total_fee=1&trade_type=NATIVE&transaction_id=1004920886201601182764936275&key=12345678901234567890123456789012";
		
		
		String sign="appid=wxc8afaaef08c507cc&attach=无忧考证班&bank_type=CFT&" +
				"cash_fee=1&fee_type=CNY&is_subscribe=N&mch_id=1307052501&" +
				"nonce_str=a63fc8c5d915e1f1a40f40e6c7499863&openid=o3IIZs_fPU8hjBD8htogYSkCZANM&" +
				"out_trade_no=20160118563200008&result_code=SUCCESS&" +
				"return_code=SUCCESS&time_end=20160118160307&total_fee=1&" +
				"trade_type=NATIVE&transaction_id=1004920886201601182766710559&" +
				"key=12345678901234567890123456789012";
		//sign3c61a276361ea3a8e90fc7ff1c56a2e0
		//tenpaySign7588b960222ca7a13dd0b220e11b484f
		//String sign="appid=wxc8afaaef08c507cc&attach=会计冲刺班&body=会计冲刺班&fee_type=CYN&mch_id=1307052501&nonce_str=C3E4035AF2A1CDE9F21E1AE1951AC80B&notify_url=http://127.0.0.1:8080/snkjsnew/control/payNotifyUrl.jsp&out_trade_no=20160111348100002&spbill_create_ip=192.168.1.6&total_fee=100&trade_type=NATIVE&key=ZHANGYINFENGHUANGJIANLING1234567";
		 //sign56d2ca867fbe7840ba0263d3f7befe36
		// tenpaySignab01a83d080d822637839a957f77ff7d
		
		System.out.println("sb:"+MD5Util.MD5Encode(sign,"UTF-8"));
		
		
	}
}