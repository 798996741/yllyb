package com.lzzj.utils;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;


public class Signature {

	private static char[] hexChar = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F' };
	
	public static String generateMAC(Map<String, String> params,String secret_key) {
	
		return encryptBySHA(generateParamStr(params) + "&" + secret_key);
	}
	

	public static boolean verifyMAC(Map<String, String> params,String secret_key) {
		
		String mac = params.get("mac");
		if(mac != null && mac.equals(generateMAC(params,secret_key)))
			return true;
		else
			return false;
	}
	

    private static String generateParamStr(Map<String, String> params) {
        
        List<String> paramList = new ArrayList<String>();
        for (String key : params.keySet()) {
            if ("mac".equals(key)) {
                continue;
            }
            String val = params.get(key);
            paramList.add(key + "=" + val);
        }
        
        if (paramList.size() == 0) {
            return null;
        }
        
        Collections.sort(paramList);
       
        StringBuilder sb = new StringBuilder();
        sb.append(paramList.get(0));
        for (int i = 1; i < paramList.size(); i++) {
            sb.append("&").append(paramList.get(i));
        }
        System.out.println(sb.toString());
        return sb.toString();
    }

   
    private static String bytesToHexStr(byte[] bytes) {
        StringBuffer sb = new StringBuffer(bytes.length * 2);
        for (int i = 0; i < bytes.length; i++) {
            sb.append(hexChar[(bytes[i] & 0xf0) >>> 4]);
            sb.append(hexChar[bytes[i] & 0x0f]);
        }
        return sb.toString();
    }

    

   
    private static String encryptBySHA(String content) {
        if (content == null)
            return null;

        try {
            MessageDigest md = MessageDigest.getInstance("SHA-1");
            byte[] output = md.digest(content.getBytes("UTF-8"));
           // System.out.println(bytesToHexStr(output)+"kkkkkkkkkkkkk");
            return bytesToHexStr(output);
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        return null;
    }
}
