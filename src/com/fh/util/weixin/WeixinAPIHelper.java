package com.fh.util.weixin;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.security.cert.X509Certificate;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSocketFactory;
import javax.net.ssl.X509TrustManager;
import javax.security.cert.CertificateException;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpHost;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.ResponseHandler;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.conn.params.ConnRoutePNames;
import org.apache.http.conn.scheme.Scheme;
import org.apache.http.impl.client.BasicResponseHandler;
import org.apache.http.impl.conn.PoolingClientConnectionManager;

import com.fh.util.weixin.AccessToken;
import com.fh.util.weixin.WeiXinUtil;


public class WeixinAPIHelper {
	

	/**

     * 微信公共账号发送给账号

     * @param content 文本内容

     * @param toUser 微信用户  

     * @return
	 * @throws IOException 
	 * @throws ClientProtocolException 

     */
	
	public static void main(String[] args){
		WeixinAPIHelper weixinAPIHelper=new WeixinAPIHelper();
		try {
			weixinAPIHelper.sendTextMessageToUser("请先点击，<a href='https://open.weixin.qq.com/connect/oauth2/authorize?appid=wxb24a2fd8af029cd6&redirect_uri=http://webchat.ada-robotics.com/recordpro/appweixin/userinfo&response_type=code&scope=snsapi_userinfo&state=1&connect_redirect=1#wechat_redirect'>注册</a>", "oAsoBwemNEoYpTMFkPdiuolFFoxo");
			//weixinAPIHelper.sendNewsToUser("oAsoBwemNEoYpTMFkPdiuolFFoxo");
		} catch (ClientProtocolException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

    public  void sendTextMessageToUser(String content,String toUser) throws ClientProtocolException, IOException{

       String json = "{\"touser\": \""+toUser+"\",\"msgtype\": \"text\", \"text\": {\"content\": \""+content+"\"}}";

       //获取access_token

       AccessToken getExistAccessToken =WeiXinUtil.getAccessToken();

       String accessToken = getExistAccessToken.getToken();

       //获取请求路径
       String action = "https://api.weixin.qq.com/cgi-bin/message/custom/send?access_token="+accessToken;

       System.out.println("json:"+json);

       try {

           connectWeiXinInterface(action,json);

       } catch (Exception e) {

           e.printStackTrace();

       }

   }

    /**

     * 微信公共账号发送给账号(本方法限制使用的消息类型是语音或者图片)

     * @param mediaId 图片或者语音内容

     * @param toUser 微信用户  

     * @param messageType 消息类型

     * @return
     * @throws IOException 
     * @throws ClientProtocolException 

     */

    public  void sendPicOrVoiceMessageToUser(String mediaId,String toUser,String msgType) throws ClientProtocolException, IOException{

        String json=null;

        if(msgType.equals("image")){

             json = "{\"touser\": \""+toUser+"\",\"msgtype\": \"image\", \"image\": {\"media_id\": \""+mediaId+"\"}}";

        }else if(msgType.equals("voice")){

            json = "{\"touser\": \""+toUser+"\",\"msgtype\": \"voice\", \"voice\": {\"media_id\": \""+mediaId+"\"}}";

        }

        //获取access_token

        AccessToken getExistAccessToken =WeiXinUtil.getAccessToken();

        String accessToken = getExistAccessToken.getToken();

       //获取请求路径

       String action = "https://api.weixin.qq.com/cgi-bin/message/custom/send?access_token="+accessToken;

       try {

           connectWeiXinInterface(action,json);

       } catch (Exception e) {

           e.printStackTrace();

       }

   }

    /**

     *  发送图文给所有的用户

     * @param openId 用户的id
     * @throws IOException 
     * @throws ClientProtocolException 

     */

    public  void sendNewsToUser(String openId) throws ClientProtocolException, IOException{

      
        String str="你是黄建凌吗？<a href=\"https://open.weixin.qq.com/connect/oauth2/authorize?appid=wxb24a2fd8af029cd6&redirect_uri=http://webchat.ada-robotics.com/recordpro/appweixin/userinfo&response_type=code&scope=snsapi_userinfo&state=1&connect_redirect=1#wechat_redirect\">注册</a>";
        String json = "{\"touser\":\""+openId+"\",\"msgtype\":\"news\",\"news\":" +

                "{\"articles\":" +str +"}"+"}";

        json = json.replace("picUrl", "picurl");

        System.out.println(json);

        //获取access_token

        AccessToken getExistAccessToken =WeiXinUtil.getAccessToken();

        String access_token = getExistAccessToken.getToken();

       //获取请求路径

       String action = "https://api.weixin.qq.com/cgi-bin/message/custom/send?access_token="+access_token;

       try {

           connectWeiXinInterface(action,json);

       } catch (Exception e) {

           e.printStackTrace();

       }

    }

    /**

     * 连接请求微信后台接口

     * @param action 接口url

     * @param json  请求接口传送的json字符串

     */

    public  void connectWeiXinInterface(String action,String json){

       URL url;

       try {

           url = new URL(action);

           HttpURLConnection http = (HttpURLConnection) url.openConnection();

           http.setRequestMethod("POST");

           http.setRequestProperty("Content-Type",  "application/x-www-form-urlencoded");

           http.setDoOutput(true);

           http.setDoInput(true);

           System.setProperty("sun.net.client.defaultConnectTimeout", "30000");// 连接超时30秒

           System.setProperty("sun.net.client.defaultReadTimeout", "30000"); // 读取超时30秒

           http.connect();

           OutputStream os = http.getOutputStream();

           os.write(json.getBytes("UTF-8"));// 传入参数

           InputStream is = http.getInputStream();

           int size = is.available();

           byte[] jsonBytes = new byte[size];

           is.read(jsonBytes);

           String result = new String(jsonBytes, "UTF-8");

           System.out.println("请求返回结果:"+result);

           os.flush();

           os.close();

       } catch (Exception e) {

           e.printStackTrace();

       }

    }
}
