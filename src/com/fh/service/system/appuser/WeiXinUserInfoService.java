package com.fh.service.system.appuser;

import java.util.List;
import java.util.Map;

import com.fh.util.PageData;
import com.fh.util.weixin.WeiXinUser;
/**
 * 用于进行微信用户个人信息的操作接口
 */
public interface WeiXinUserInfoService {
     /**
      * 获取到微信个人用户的信息
      * @param accessToken
      * @param openId
      * @return
      */
     WeiXinUser getUserInfo(String accessToken, String openId);
 
     /**
      *用于获取网页授权后的信息字段，其中主要是获取openId
      * @param code  授权码
      * @return
      */
     Map<String,String> getAuthInfo(String code);
 
     /**
      * 进行网页授权的认证
      * @param code 授权码
      * @return
      */
     Map<String,String> oauth2GetOpenid(String code);
     
     
 	public List<PageData> listSendZsk(PageData pd)throws Exception;
     
   	public List<PageData> listSendZskByzsid(PageData pd)throws Exception;
     
   	public PageData listSendLogByzsid(PageData pd)throws Exception;
   	
   	public void saveSendlog(PageData pd)throws Exception ;
   	
	public List<PageData> listDictBytype(PageData pd)throws Exception;
    
   	public PageData listDictByid(PageData pd)throws Exception;
}