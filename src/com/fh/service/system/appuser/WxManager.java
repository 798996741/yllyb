package com.fh.service.system.appuser;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.fh.entity.Page;
import com.fh.util.PageData;


/** 会员接口类
 * @author 
 * 修改时间：
 */
public interface WxManager  {
	
	public String weixinPost(HttpServletRequest request);

	public boolean check(String tOKEN, String signature, String timestamp,	String nonce);
	
}

