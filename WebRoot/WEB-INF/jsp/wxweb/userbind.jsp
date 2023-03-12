<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
<meta charset="utf-8" />
<meta name="App-Config" content="fullscreen=yes,useHistoryState=yes,transition=yes" />
<meta content="yes" name="apple-mobile-web-app-capable" />
<meta content="yes" name="apple-touch-fullscreen" />
<meta content="telephone=no,email=no" name="format-detection" />
<meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no" />
<script src="http://g.tbcdn.cn/mtb/lib-flexible/0.3.4/??flexible_css.js,flexible.js"></script>
<script src="static/js/jquery-1.7.2.js"></script>
<link rel="stylesheet" type="text/css" href="static/weixin/css/common.css" />

<script>
    $(function () {
      	$('.nav-person').click(function () {
        	window.location.href = "appweixin/userreg?OPENID=${weiXinUser.openId}&type=1";
      	});
      	$('.nav-company').click(function () {
       		window.location.href = "appweixin/userreg?OPENID=${weiXinUser.openId}&type=2"
      	})
    })
  </script>
</head>
<body class="no-skin">
	<input type="hidden" id="OPENID" name="OPENID" value="${weiXinUser.openId}">
	<div class="bg">
    <header class="site-tit-header"></header>
    <main class="site-main">
      <div class="site-nav-wrapper">
        <div class="site-nav nav-person">
          <div class="nav-img-wrapper">
            <div class="nav-img"></div>
          </div>
          <div class="nav-title">个人用户</div>
          <div class="nav-describe">
            	实时获取适用于个人的就业、生活等政策补贴福利
          </div>
        </div>
        <div class="site-nav nav-company">
          <div class="nav-img-wrapper">
            <div class="nav-img"></div>
          </div>
          <div class="nav-title">企业用户</div>
          <div class="nav-describe">
            	实时获取适用于企业的创业、融资等扶持政策福利
          </div>
        </div>
      </div>
    </main>
    <footer class="site-footer">
      <div class="footer-title">
        	人社宝为您提供最适合您、最全面的政策咨讯政策申报最多跑一趟
      </div>
    </footer>
  </div>
</body>
</html>