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
	$('.detail-material-item').click(function () {
		if ($(this).find(".detail-open").css("display") == "block") {
			$(".detail-open").show();
			$(".detail-material-item-detail").hide();
			$(this).find(".detail-open").hide();
			$(this).next(".detail-material-item-detail").show();
		}else{
			$(this).find(".detail-open").show();
			$(this).next(".detail-material-item-detail").hide();
		}
	});
	$('.detail-material-retract').click(function () {
		$(this).parent().hide();
		$(this).parent().prev().find(".detail-open").show();
	});
	$('.footer-nav-1').click(function(){
		window.location.href = 'appweixin/detail_mx.do?zsid=${zskBean.zsid}&nav=org'
	})
	$('.footer-nav-2').click(function(){
		window.location.href = 'appweixin/detail_mx.do?zsid=${zskBean.zsid}&nav=tjbs'
	})
	$('.footer-nav-3').click(function(){
		window.location.href = 'appweixin/detail_mx.do?zsid=${zskBean.zsid}&nav=question'
	})
});

  </script>
</head>
<body>
	<div class="detail-bg">
		<header class="detail-header">
			<div class="detail-header-tit" style="padding-left:10px;">
				${zskBean.zstitle}
			</div>
		</header>
		<main class="detail-main">
			<ul class="detail-material-cont">
				<c:forEach items="${zskcontList}" var="zskcont" varStatus="vs">
					<li 
						<c:if test="${vs.index==0 }">class="detail-material-item detail-material-item-one"</c:if>
						<c:if test="${vs.index==1 }">class="detail-material-item detail-material-item-two"</c:if>
						<c:if test="${vs.index==2 }">class="detail-material-item detail-material-item-three"</c:if>
						<c:if test="${vs.index==3 }">class="detail-material-item detail-material-item-four"</c:if>
						<c:if test="${vs.index==4 }">class="detail-material-item detail-material-item-one"</c:if>
						<c:if test="${vs.index==5 }">class="detail-material-item detail-material-item-two"</c:if>
						<c:if test="${vs.index==6 }">class="detail-material-item detail-material-item-three"</c:if>
						<c:if test="${vs.index==7 }">class="detail-material-item detail-material-item-four"</c:if>
						<c:if test="${vs.index==8 }">class="detail-material-item detail-material-item-two"</c:if>
						<c:if test="${vs.index==9 }">class="detail-material-item detail-material-item-one"</c:if>
					
					>
						<div class="detail-material-tit-wrapper">
							<div class="detail-material-order">
								${vs.count}
							</div>
							<div class="detail-material-tit">
								${zskcont.cont }
							</div>
						</div>
						<c:if test="${not empty zskcont.searchtemp||not empty zskcont.zsget||not empty zskcont.descrpit}">
							<div>
								<div class="detail-open">
									<img src="static/weixin/images/open.png" />
								</div>
							</div>
						</c:if>
					</li>
					<div class="detail-material-item-detail">
						<c:if test="${not empty zskcont.searchtemp}">
							<div class="detail-material-template color-blue">
								<div class="detail-material__tit">| 材料模板</div>
								<a href="<%=path %>/appweixin/zskcont_mx?action=rdsqb&id=${zskcont.id }&zsid=${zskcont.zsid }" class="detail-material__look">
									<img src="static/weixin/images/look.png">
								</a>
							</div>
						</c:if>
						<c:if test="${not empty zskcont.zsget}">
							<div class="detail-material-source">
								<div class="detail-material-source__tit color-blue gray__border">
									<div class="detail-material__tit">| 材料来源</div>
									<c:if test="${not empty zskcont.isurl}">
										<a href="${zskcont.zsget}" class="detail-material__todo">
											<img src="static/weixin/images/todo.png">
										</a>
									</c:if>
									<%-- <c:if test="${empty zskcont.isurl}">
										<a href="appweixin/zskcont_mx?action=zsget&id=${zskcont.id }&zsid=${zskcont.zsid }" class="detail-material__todo">
											<img src="static/weixin/images/todo.png">
										</a>
									</c:if> --%>
								</div>
								<div class="detail-material-source__cont">
									<p>${zskcont.zsget}</p>
								</div>
							</div>
						</c:if>
						<c:if test="${not empty zskcont.descript}">
							<div class="detail-material-demand">
								<div class="detail-material-demand__tit color-blue gray__border">
									<div class="detail-material__tit">| 材料要求</div>
								</div>
								<div class="detail-material-demand__cont">
									${zskcont.descript }			
								</div>
							</div>
						</c:if>
						<div class="detail-material-retract">
							<div class="detail-item-retract-img">
								<img src="static/weixin/images/retract.png">
							</div>
						</div>
					</div>
				</c:forEach>
			</ul>
		</main>
		<footer>
				<div class="footer-fix">
					<div class="footer-nav">
						<div class="footer-nav-item footer-nav-1">
							
						</div>
					</div>
					<div class="footer-nav">
						<div class="footer-nav-item footer-nav-2">
							
						</div>
					</div>
					<div class="footer-nav">
						<div class="footer-nav-item footer-nav-3">
							
						</div>
					</div>
				</div>
			</footer>
		
		</div>
</body>
</html>