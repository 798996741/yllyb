package com.lzzj.entity.archive;


import java.util.Iterator;
import java.util.Map;
import java.util.Set;
import java.util.SortedMap;
import java.util.TreeMap;

import com.lzzj.utils.HttpClient;
import com.lzzj.utils.WxSign;


public class UnifiedorderService { 
	
	public static String unifiedOrder(WxpayBean data,String key){    
		//统一下单支付    
		String returnXml = null;    
		try {      //生成sign签名      
			SortedMap<Object,Object> parameters = new TreeMap<Object,Object>();  
			UnifiedorderService unifiedorderService=new UnifiedorderService();
			parameters.put("appid", data.getAppid());       
			parameters.put("attach",data.getAttach());      
			parameters.put("body",data.getBody());  
			//parameters.put("fee_type", "CYN");  
			parameters.put("mch_id", data.getMch_id());      
			parameters.put("nonce_str", data.getNonce_str());      
			parameters.put("notify_url", data.getNotify_url());      
			parameters.put("out_trade_no", data.getOut_trade_no());  
			parameters.put("spbill_create_ip", data.getSpbill_create_ip());  
			parameters.put("total_fee",data.getTotal_fee());   
//			parameters.put("total_fee",data.getTotal_fee());
			//System.out.println(Integer.parseInt(data.getTotal_fee()));
			parameters.put("trade_type", data.getTrade_type());     
			String sign=WxSign.createSign(parameters,key);    
			data.setSign(sign);    
			//XStream xs = new XStream(new DomDriver("UTF-8",new XmlFriendlyNameCoder("-_", "_")));      
			//xs.alias("xml", WxpayBean_n.class); 
			//String xml = xs.toXML(wxpayBean_n); 
			String xml = unifiedorderService.genXml(parameters,key,sign); 
			
			//System.out.println("统一下单xml为:\n" + xml); 
			HttpClient util =new HttpClient();
			returnXml = util.doPost("https://api.mch.weixin.qq.com/pay/unifiedorder", "UTF-8", xml);      
			System.out.println("返回结果:" + returnXml);    
		}catch (Exception e) {      
			e.printStackTrace();    
		}    
		return returnXml;  
	}  
	
	
	public static String searchOrder(WxpayBean data,String key){    
		//统一下单支付    
		String returnXml = null;    
		try {      //生成sign签名      
			SortedMap<Object,Object> parameters = new TreeMap<Object,Object>();  
			UnifiedorderService unifiedorderService=new UnifiedorderService();
			parameters.put("appid", data.getAppid()); 
			parameters.put("mch_id", data.getMch_id());    
			parameters.put("out_trade_no", data.getOut_trade_no()); 
			parameters.put("nonce_str", data.getNonce_str());  
			String sign=WxSign.createSign(parameters,key);    
			data.setSign(sign);
			String xml = unifiedorderService.genXml(parameters,key,sign); 
			System.out.println("统一下单xml为:\n" + xml); 
			HttpClient util =new HttpClient();
			returnXml = util.doPost("https://api.mch.weixin.qq.com/pay/orderquery", "UTF-8", xml);      
			System.out.println("返回结果:" + returnXml);    
		}catch (Exception e) {      
			e.printStackTrace();    
		}    
		return returnXml;  
	}  

    /** 
     * 生成xml格式的请求参数 
     *  
     * @param params 
     *            参数集合 
     * @return 
     */  
    private String genXml(SortedMap<Object,Object> parameters,String key,String sign) {  
        StringBuilder sb = new StringBuilder();  
        StringBuilder sb2 = new StringBuilder(); 
        sb2.append("<?xml version='1.0' encoding='UTF-8' standalone='yes' ?><xml>");  
        Set es = parameters.entrySet();//所有参与传参的参数按照accsii排序（升序）     
		Iterator it = es.iterator();   
		UnifiedorderService unifiedorderService=new UnifiedorderService();
		while(it.hasNext()) {       
			Map.Entry entry = (Map.Entry)it.next();       
			String k = (String)entry.getKey();       
			Object v = entry.getValue();       
			if(null != v && !"".equals(v)&& !"sign".equals(k) && !"key".equals(k)) { 
				//sb2.append(k + "=" + v + "&"); 
				
				sb2.append("<" + k + ">");  
		        sb2.append(v);  
		        sb2.append("</" + k + ">");  
			}     
		}      
        // 生成签名  
        sb2.append("<sign><![CDATA[");  
        sb2.append(sign);  
        sb2.append("]]></sign>");  
        sb2.append("</xml>");  
      
        // 这一步最关键 我们把字符转为 字节后,再使用“ISO8859-1”进行编码，得到“ISO8859-1”的字符串  
        try {  
        	//ew String(unSignParaString.getBytes("utf-8"),"gbk")
            return new String(sb2.toString().getBytes("utf-8"), "ISO8859-1"); 
        } catch (Exception e) {  
            e.printStackTrace();  
        }  
        return "";  
    }  
	
}