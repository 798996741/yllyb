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

</head>
<body>
	<div class="detail-bg">
        <header class="detail-header"></header>
        <main class="page-main">
            <div class="detail-cont">
                <div class="detail-block">
                    <div class="detail-title color-blue gray__border">
                        ● ${zskcontBean.cont }
                    </div>
                    <div>
                        <div class="template-notice color-blue">温馨提示：以下为材料范本仅供参考，请根据实际情况调整内容。</div>
                        <ul>
                            <li>
                                <div class="template-img">
                                	<c:if test="${pd.action=='zsget'}">
                                    	${zskcontBean.zsget }
                                    </c:if>
                                    <c:if test="${pd.action!='zsget'}">
                                    	${zskcontBean.searchtemp }
                                    </c:if>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </main>
        <footer class="site-footer"></footer>
    </div>
</body>
</html>