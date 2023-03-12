package com.fh.controller.app.appuser;



import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import com.fh.service.system.appuser.AppuserManager;
import com.fh.service.system.appuser.WxManager;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
@Controller
@RequestMapping("/appwx")
public class WxController {

    //@Value("${ada.TOKEN}")
    private String TOKEN="csh";
    //微信公众号
   // @Value("${ada.APPID}")
    private String APPID="wxa8786bf0a6c71871";
   // @Value("${ada.APPSECRET}")
    private String APPSECRET="f51bc399be4e020b231bacbb4dcaa53f";
    //@Value("${ada.Port}")
    //private String adaPort;
    //@Value("${ada.IP}")
    //private String adaIP;
    //默认code
    //@Value("${ada.Code}")
    //private int code;
    //调用第三方的uid
   // private String uid = null;
    /**
     * 测试公众号连接成功或者失败
     * @return
     */
    
    
    @Resource(name="wxService")
	private WxManager wxService;
    
    /**
     * 微信接入
     * @param wc
     * @return
     * @throws IOException 
     */
    @RequestMapping(value="/connect",method = {RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    public void connectWeixin(HttpServletRequest request, HttpServletResponse response) throws IOException{
        // 将请求、响应的编码均设置为UTF-8（防止中文乱码）  
        request.setCharacterEncoding("UTF-8");  //微信服务器POST消息时用的是UTF-8编码，在接收时也要用同样的编码，否则中文会乱码；
        response.setCharacterEncoding("UTF-8"); //在响应消息（回复消息给用户）时，也将编码方式设置为UTF-8，原理同上；boolean isGet = request.getMethod().toLowerCase().equals("get"); 
      
        PrintWriter out = response.getWriter();
        boolean isGet = request.getMethod().toLowerCase().equals("get"); 
        try {
            if (isGet) {
                String signature = request.getParameter("signature");// 微信加密签名  
                String timestamp = request.getParameter("timestamp");// 时间戳  
                String nonce = request.getParameter("nonce");// 随机数  
                String echostr = request.getParameter("echostr");//随机字符串  
                
                // 通过检验signature对请求进行校验，若校验成功则原样返回echostr，表示接入成功，否则接入失败 
                if (wxService.check(TOKEN, signature, timestamp, nonce)) {  
                    System.out.println("Connect the weixin server is successful.");
                    response.getWriter().write(echostr);  
                } else {  
                    System.out.println("Failed to verify the signature!"); 
                }
            }else{
                String respMessage = "异常消息！";
                try {
                    respMessage = wxService.weixinPost(request);
                    out.write(respMessage);
                    System.out.println("The request completed successfully");
                    System.out.println("to weixin server "+respMessage);
                } catch (Exception e) {
                    System.out.println("Failed to convert the message from weixin!"); 
                }
            }
        } catch (Exception e) {
            System.out.println("Connect the weixin server is error.");
        }finally{
            out.close();
        }
    }

    
    public void sendMsg(String openid,String msg){
    	URL url;
    	OutputStream os =null;
    	InputStream is =null;
        try {
            url = new URL("http://webchat.ada-robotics.com/wx/message");
            HttpURLConnection http = (HttpURLConnection) url.openConnection();
            http.setRequestMethod("POST");
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
            System.out.println("请求返回结果:"+result);
            os.flush();
            os.close();
            
        } catch (Exception e) {
            //e.printStackTrace();
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
