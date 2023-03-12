package  com.fh.service.system.appuser.impl;

import com.alibaba.fastjson.JSON;
import com.fh.service.system.appuser.AppuserManager;
import com.fh.service.system.appuser.WxManager;
import com.fh.util.MessageUtil;
import com.fh.util.TextMessage;
import com.fh.util.Utils;
import com.fh.util.weixin.AccessToken;
import com.fh.util.weixin.WeiXinUser;
import com.fh.util.weixin.WeiXinUtil;
import com.thoughtworks.xstream.XStream;

import net.sf.json.JSONObject;

import org.apache.http.client.ClientProtocolException;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.*;

import javax.servlet.http.HttpServletRequest;

@Service("wxService")
public class WxService implements WxManager {
    /**
     * 验证签名
     *
     * @param TOKEN
     * @param timestamp
     * @param nonce
     * @param signature
     * @return
     */
    public  boolean check(String TOKEN, String timestamp, String nonce, String signature) {
        //1）将token、timestamp、nonce三个参数进行字典序排序
        String[] strs = new String[]{TOKEN, timestamp, nonce};
        Arrays.sort(strs);
        //2）将三个参数字符串拼接成一个字符串进行sha1加密
        String str = strs[0] + strs[1] + strs[2];
        String mysig = sha1(str);
        //3）开发者获得加密后的字符串可与signature对比，标识该请求来源于微信
        return mysig.equalsIgnoreCase(signature);
    }

    /**
     * 进行sha1加密
     *
     * @param
     * @return
     */
    private static String sha1(String src) {
        try {
            //获取一个加密对象
            MessageDigest md = MessageDigest.getInstance("sha1");
            //加密
            byte[] digest = md.digest(src.getBytes());
            char[] chars = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'};
            StringBuilder sb = new StringBuilder();
            //处理加密结果
            for (byte b : digest) {
                sb.append(chars[(b >> 4) & 15]);
                sb.append(chars[b & 15]);
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    /**
     * 处理微信发来的请求
     * 
     * @param request
     * @return
     */
    public String weixinPost(HttpServletRequest request) {
        String respMessage = null;
        try {

            // xml请求解析
            Map<String, String> requestMap = Utils.xmlToMap(request);

            // 发送方帐号（open_id）
            String fromUserName = requestMap.get("FromUserName");
            // 公众帐号
            String toUserName = requestMap.get("ToUserName");
            // 消息类型
            String msgType = requestMap.get("MsgType");
            // 消息内容
            String content = requestMap.get("Content");
            
            System.out.println("FromUserName is:" + fromUserName + ", ToUserName is:" + toUserName + ", MsgType is:" + msgType);

            // 文本消息
            if (msgType.equals(MessageUtil.REQ_MESSAGE_TYPE_TEXT)) {
                //这里根据关键字执行相应的逻辑，只有你想不到的，没有做不到的
                if(content.equals("xxx")){
                    
                }
                
                //自动回复
                TextMessage text = new TextMessage();
                text.setContent("the text is" + content);
                text.setToUserName(fromUserName);
                text.setFromUserName(toUserName);
                text.setCreateTime(new Date().getTime() + "");
                text.setMsgType(msgType);
                
                respMessage = Utils.textMessageToXml(text);
               
            } /*else if (msgType.equals(MessageUtil.REQ_MESSAGE_TYPE_EVENT)) {// 事件推送
                String eventType = requestMap.get("Event");// 事件类型
                
                if (eventType.equals(MessageUtil.EVENT_TYPE_SUBSCRIBE)) {// 订阅
                    respContent = "欢迎关注xxx公众号！";
                    return MessageResponse.getTextMessage(fromUserName , toUserName , respContent);
                } else if (eventType.equals(MessageUtil.EVENT_TYPE_CLICK)) {// 自定义菜单点击事件
                    String eventKey = requestMap.get("EventKey");// 事件KEY值，与创建自定义菜单时指定的KEY值对应
                    System.out.println("eventKey is:" +eventKey);
                    return xxx;
                }
            }
            //开启微信声音识别测试 2015-3-30
            else if(msgType.equals("voice"))
            {
                String recvMessage = requestMap.get("Recognition");
                //respContent = "收到的语音解析结果："+recvMessage;
                if(recvMessage!=null){
                    respContent = TulingApiProcess.getTulingResult(recvMessage);
                }else{
                    respContent = "您说的太模糊了，能不能重新说下呢？";
                }
                return MessageResponse.getTextMessage(fromUserName , toUserName , respContent); 
            }
            //拍照功能
            else if(msgType.equals("pic_sysphoto"))
            {
                
            }
            else
            {
                return MessageResponse.getTextMessage(fromUserName , toUserName , "返回为空"); 
            }*/
            // 事件推送
            else if (msgType.equals(MessageUtil.REQ_MESSAGE_TYPE_EVENT)) {
                String eventType = requestMap.get("Event");// 事件类型
                // 订阅
                if (eventType.equals(MessageUtil.EVENT_TYPE_SUBSCRIBE)) {
                    
                    TextMessage text = new TextMessage();
                    text.setContent("欢迎关注，xxx");
                    text.setToUserName(fromUserName);
                    text.setFromUserName(toUserName);
                    text.setCreateTime(new Date().getTime() + "");
                    text.setMsgType(MessageUtil.RESP_MESSAGE_TYPE_TEXT);
                    
                    respMessage = Utils.textMessageToXml(text);
                } 
                // TODO 取消订阅后用户再收不到公众号发送的消息，因此不需要回复消息
                else if (eventType.equals(MessageUtil.EVENT_TYPE_UNSUBSCRIBE)) {// 取消订阅
                    
                    
                } 
                // 自定义菜单点击事件
                else if (eventType.equals(MessageUtil.EVENT_TYPE_CLICK)) {
                    String eventKey = requestMap.get("EventKey");// 事件KEY值，与创建自定义菜单时指定的KEY值对应
                    if (eventKey.equals("customer_telephone")) {
                        TextMessage text = new TextMessage();
                        text.setContent("0755-86671980");
                        text.setToUserName(fromUserName);
                        text.setFromUserName(toUserName);
                        text.setCreateTime(new Date().getTime() + "");
                        text.setMsgType(MessageUtil.RESP_MESSAGE_TYPE_TEXT);
                        
                        respMessage = Utils.textMessageToXml(text);
                    }
                }
            }
        }
        catch (Exception e) {
           System.out.println("error......");
        }
        return respMessage;
    }
    
    /**
     * 获取公众号关注的用户openid
     * @return
     */
    public List<String> getUserOpenId(String access_token, String nextOpenid)
    {
        String path = "https://api.weixin.qq.com/cgi-bin/user/get?access_token=ACCESS_TOKEN";
       
        //String path = "https://api.weixin.qq.com/cgi-bin/user/info?access_token=ACCESS_TOKEN&openid=OPENID&lang=zh_CN";
        
        
        //path = path.replace("ACCESS_TOKEN", access_token).replace("NEXT_OPENID", nextOpenid);
        path = path.replace("ACCESS_TOKEN", access_token);
        System.out.println("path:" + path);

        List<String> result = null;
        try
        {
            JSONObject strResp = WeiXinUtil.doGetStr(path);
            System.out.println(strResp+"strResp");

            Map map = this.jsonToMap(strResp);
            Map tmapMap = (Map) map.get("data");
           // System.out.println(tmapMap.toString());
            result = (List<String>) tmapMap.get("openid");

            System.out.println(result.toString());

        }catch (IOException e)
        {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return result;
    }
    
    /**
     * 通过用户openid 获取用户信息
     * @param userOpenids
     * @return
     */
    public List<WeiXinUser> getUserInfo(List<String> userOpenids)
    {
        // 1、获取access_token
        // 使用测试 wx9015ccbcccf8d2f5 02e3a6877fa5fdeadd78d0f6f3048245
    	 AccessToken getExistAccessToken=null;
		try {
			getExistAccessToken = WeiXinUtil.getAccessToken();
		} catch (ClientProtocolException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

         String accessToken = getExistAccessToken.getToken();

        // 2、封装请求数据
        List user_list = new ArrayList<Map>();
        for (int i = 0; i < userOpenids.size(); i++)
        {
            String openid = userOpenids.get(i);
            Map tUserMap = new HashMap<String, String>();
            tUserMap.put("openid", openid);
            tUserMap.put("lang", "zh_CN");
            this.getOneUserInfo(accessToken, openid);
            user_list.add(tUserMap);
        }
        System.out.println(user_list.toString());
        Map requestMap = new HashMap<String, List>();
        requestMap.put("user_list", user_list);
        String tUserJSON = JSONObject.fromObject(requestMap).toString();

        // 3、请求调用
        String result = getUserInfobyHttps(accessToken, tUserJSON);
        System.out.println(result);

        // 4、解析返回将结果
        return parseUserInfo(result);
    }
    
    /**
     * 解析返回用户信息数据
     * @param userInfoJSON
     * @return
     */
    
    public static Map<Object, Object> jsonToMap(Object jsonObj) {
        JSONObject jsonObject = JSONObject.fromObject(jsonObj);
        Map<Object, Object> map = (Map)jsonObject;
        return map;
    }

    
    private List<WeiXinUser> parseUserInfo(String userInfoJSON)
    {
        List user_info_list = new ArrayList<WeiXinUser>();

        Map tMapData = this.jsonToMap(userInfoJSON);
        System.out.println("tMapData:"+tMapData);
        List<Map> tUserMaps = (List<Map>) tMapData.get("user_info_list");

        for (int i = 0; i < tUserMaps.size(); i++)
        {
            WeiXinUser tUserInfo = new WeiXinUser();
            tUserInfo.setSubscribe((Integer) tUserMaps.get(i).get("subscribe"));
            tUserInfo.setSex((Integer) tUserMaps.get(i).get("sex"));
            tUserInfo.setOpenId((String) tUserMaps.get(i).get("openid"));
            tUserInfo.setNickname((String) tUserMaps.get(i).get("nickname"));
            tUserInfo.setLanguage((String) tUserMaps.get(i).get("language"));
            tUserInfo.setCity((String) tUserMaps.get(i).get("city"));
            tUserInfo.setProvince((String) tUserMaps.get(i).get("province"));
            tUserInfo.setCountry((String) tUserMaps.get(i).get("country"));
            tUserInfo.setHeadImgUrl((String) tUserMaps.get(i).get("headimgurl"));
            System.out.println((String) tUserMaps.get(i).get("nickname")+(String) tUserMaps.get(i).get("openid"));
            user_info_list.add(tUserInfo);
        }

        return user_info_list;
    }

    /**
     * 调用HTTPS接口，获取用户详细信息
     * @param access_token
     * @param requestData
     * @return
     */
    private String getUserInfobyHttps(String access_token, String requestData)
    {
        // 返回报文
        JSONObject strResp = null;
        String path = "https://api.weixin.qq.com/cgi-bin/user/info/batchget?access_token=ACCESS_TOKEN";
        path = path.replace("ACCESS_TOKEN", access_token);

        try
        {
            strResp = WeiXinUtil.doPostStr(path, requestData);
        }
        catch (Exception e)
        {
            // 发生致命的异常，可能是协议不对或者返回的内容有问题
            System.out.println("Please check your provided http address!" + e);
            e.printStackTrace();
        }
        finally
        {}
        return strResp.toString();
    }
    
    private String getOneUserInfo(String access_token, String openid)
    {
        // 返回报文
        JSONObject strResp = null;
        AccessToken getExistAccessToken=null;
		try {
			getExistAccessToken = WeiXinUtil.getAccessToken();
		} catch (ClientProtocolException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

        String accessToken = getExistAccessToken.getToken();
        String path = "https://api.weixin.qq.com/cgi-bin/user/info?access_token=ACCESS_TOKEN&openid="+openid+"&lang=zh_CN";
        path = path.replace("ACCESS_TOKEN", accessToken);

        try
        {
            strResp = WeiXinUtil.doGetStr(path);
            System.out.println(strResp);
        }
        catch (Exception e)
        {
            // 发生致命的异常，可能是协议不对或者返回的内容有问题
            System.out.println("Please check your provided http address!" + e);
            e.printStackTrace();
        }
        finally
        {}
        return strResp.toString();
    }
    
    public static void main(String[] args){
    	WxService tChatUserService = new WxService();
    	 AccessToken getExistAccessToken=null;
 		try {
 			getExistAccessToken = WeiXinUtil.getAccessToken();
 		} catch (ClientProtocolException e) {
 			// TODO Auto-generated catch block
 			e.printStackTrace();
 		} catch (IOException e) {
 			// TODO Auto-generated catch block
 			e.printStackTrace();
 		}

        String accessToken = getExistAccessToken.getToken();
    	tChatUserService.getUserInfo(tChatUserService.getUserOpenId(accessToken, ""));
    }
}
