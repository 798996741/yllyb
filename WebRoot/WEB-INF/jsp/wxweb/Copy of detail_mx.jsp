<%@ page language="java" contentType="text/html ; charset=UTF-8" pageEncoding="UTF-8" %>
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
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8"/>
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
			$('.detail-org').click(function () {
				$(this).toggleClass('active').next().toggle();
			});
			$('.detail-material_nav ul li').click(function () {
				$('.detail-material__wrapper ul li').hide();
				$('.detail-material__wrapper ul li').eq($(this).index()).show();
			});
			$('.detail-material_nav ul li').eq(0).trigger("click");
			
		});
  </script>
</head>
<body>
	<div class="detail-bg">
		<header class="detail-header"></header>
		<main>
			<div class="detail-cont">
				<div class="detail-block">
					<div class="detail-title color-green gray__border">
						● ${zskBean.zstitle}
						<c:if test="${not empty questionList}">
							<a href="appweixin/question_mx?zsid=${zskBean.zsid}" class="common-question">
								<img src="static/weixin/images/question_btn.png" />
							</a>
						</c:if>
					</div>
					<div class="detail-org color-blue gray__border bold">
						申报机构
						<div class="arrow-icon"></div>
					</div>
					<div class="detail-org-cont">
						${zskBean.lct}
					</div>
				</div>
				<div class="detail-block">
					<div class="detail-org color-blue bold">申请材料</div>
					<div class="detail-material">
						<div class="detail-material_nav">
							<ul>
								<c:forEach items="${zskcontList}" var="zskcont" varStatus="vs">
									<li <c:if test="${vs.index==0 }">class="order-bg order-bg-one"</c:if>
										<c:if test="${vs.index==1 }">class="order-bg order-bg-two"</c:if>
										<c:if test="${vs.index==2 }">class="order-bg order-bg-three"</c:if>
										<c:if test="${vs.index==3 }">class="order-bg order-bg-four"</c:if>
										<c:if test="${vs.index==4 }">class="order-bg order-bg-five"</c:if>
										<c:if test="${vs.index==5 }">class="order-bg order-bg-six"</c:if>
										<c:if test="${vs.index==6 }">class="order-bg order-bg-seven"</c:if>
										<c:if test="${vs.index==7 }">class="order-bg order-bg-eight"</c:if>
										<c:if test="${vs.index==8 }">class="order-bg order-bg-nine"</c:if>
										<c:if test="${vs.index==9 }">class="order-bg order-bg-tenth"</c:if>
										
										<c:if test="${vs.index==10 }">class="order-bg order-bg-eleven"</c:if>
										<c:if test="${vs.index==11 }">class="order-bg order-bg-twelve"</c:if>
									>
										<p >
										 <c:if test="${fn:length(zskcont.cont)>'10'}">
										 	${fn:substring(zskcont.cont, 0, 10)}...
										 </c:if>
										  <c:if test="${fn:length(zskcont.cont)<='10'}">
										 	${zskcont.cont }
										 </c:if>
										</p>
									</li>
								</c:forEach>
							</ul>
						</div>
						<div class="detail-material__wrapper">
							<ul>
								<c:forEach items="${zskcontList}" var="zskcont" varStatus="vs">
								
									<li class="detail-material__item">
										<div class="detail-material__title color-blue gray__border">
											${zskcont.cont }
										</div>
										<div class="detail-material__content">
											<div class="material-content__item color-blue gray__border">
												| 材料模板
												<c:if test="${not empty zskcont.searchtemp}">
													<a href="appweixin/zskcont_mx?action=rdsqb&id=${zskcont.id }&zsid=${zskcont.zsid }" class="detail-material__look">
														<img src="static/weixin/images/look.png">
													</a>
												</c:if>
											</div>
											<div class="material-content__item color-blue gray__border">
												| 材料来源
												<c:if test="${not empty zskcont.zsget}">
													<a href="appweixin/zskcont_mx?action=zsget&id=${zskcont.id }&zsid=${zskcont.zsid }" class="detail-material__todo">
														<img src="static/weixin/images/todo.png">
													</a>
												</c:if>
											</div>
											<div class="detail-material__detail">
												<p>您可在住所所属社区单位领取纸质表单，参考模板填写即可。若有疑问，可继续提问小宝机器人，他会辅助您填写。</p>
											</div>
											<div class="material-content__item color-blue gray__border">
												| 材料要求
											</div>
											<div class="detail-material__detail">
												${zskcont.descrpit }
											</div>
										</div>
									</li>
								</c:forEach>
								
							</ul>
						</div>
					</div>
				</div>
				<div class="detail-block">
					<div class="detail-more color-blue gray__border">
						属于以下情况的还需报送材料
					</div>
					<div class="detail-other-material color-gray">
						${zskBean.tjbs}
					</div>
				</div>
			</div>
		</main>
		<footer class="site-footer"></footer>
	</div>
</body>
</html>