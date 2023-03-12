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
		$('.detail-item-nav').click(function () {
			if ($(this).find(".detail-open").css("display") == "block") {
				$(".detail-open").show();
				$('.detail-item-nav-detail').hide();
				$(this).find(".detail-open").hide();
				$(this).next('.detail-item-nav-detail').show();
			}else{
				$(this).find(".detail-open").show();
				$(this).next('.detail-item-nav-detail').hide();
			}
		});
		$('.detail-item-retract').click(function () {
			$(this).parent().prev().find(".detail-open").show();
			$(this).parent().hide();
		});
		function GetRequest() {  //获取url中"?"符后的字串
		   var url = location.search;   
		   var theRequest = new Object();  
		   if (url.indexOf("?") != -1) {  
			  var str = url.substr(1);  
			  strs = str.split("&");  
			  for(var i = 0; i < strs.length; i ++) {  
				 theRequest[strs[i].split("=")[0]]=unescape(strs[i].split("=")[1]);  
			  }  
		   }  
		   return theRequest;  
		} 
		// 控制展开哪一项
		if(GetRequest() && GetRequest().nav){
			if(GetRequest().nav == 'org'){
				$('.detail-org-nav').trigger('click')
			} else if(GetRequest().nav == 'question'){
				$('.detail-question-nav').trigger('click')
			} else{
				
			}
		}
	});
  </script>
</head>
<body>
	<div class="detail-bg">
		<header class="detail-header">
			<div  class="detail-header-tit">
				${zskBean.zstitle}
			</div>
		</header>
		<main class="detail-main">
			<ul class="detail-cont">
				
				<c:if test="${not empty zskBean.sqtj}">
					<li class="detail-block detail-item-nav detail-condition-nav">
						<div class="detail-block-left">
							<span>申报条件</span>
						</div>
						<div class="detail-block-right">
							<div class="detail-open">
								<img src="static/weixin/images/open.png" />
							</div>
						</div>
					</li>
					<div class="detail-item-nav-detail">
						<div class="detail-org-detail">
							<div class="detail-org-tit color-blue gray__border bold">
								● 申请条件
							</div>
							<div class="detail-org-cont">
								${zskBean.sqtj}
							</div>
						</div>
						<div class="detail-item-retract">
							<div class="detail-item-retract-img">
								<img src="static/weixin/images/retract.png" />
							</div>
						</div>
					</div>		
				</c:if>	
				<c:if test="${not empty zskBean.lct}">
					<li class="detail-block detail-item-nav detail-org-nav">
						<div class="detail-block-left">
							<span>申请机构</span>
						</div>
						<div class="detail-block-right">
							<div class="detail-open">
								<img src="static/weixin/images/open.png" />
							</div>
						</div>
					</li>
					<div class="detail-item-nav-detail">
						<div class="detail-org-detail">
							<div class="detail-org-tit color-blue gray__border bold">
								● 申报机构
							</div>
							<div class="detail-org-cont">
								${zskBean.lct}
							</div>
							
						</div>
						<div class="detail-item-retract">
							<div class="detail-item-retract-img">
								<img src="static/weixin/images/retract.png" />
							</div>
						</div>
					</div>
				</c:if>	
				<c:if test="${not empty zskcontList}">
					<li class="detail-block detail-material-nav">
						<a href="detail-material.html">
							<div class="detail-block-left">
								<span>申请材料</span>
							</div>
							<div class="detail-block-right">
								<div class="detail-read">
									<img src="static/weixin/images/read.png" />
								</div>
							</div>
						</a>
					</li>
				</c:if>
				<c:if test="${not empty zskBean.tjbs}">
					<li class="detail-block detail-item-nav detail-submit-nav">
						<div class="detail-block-left">
							<span>条件报送</span>
						</div>
						<div class="detail-block-right">
							<div class="detail-open">
								<img src="static/weixin/images/open.png" />
							</div>
						</div>
					</li>
					<div class="detail-item-nav-detail">
						<div class="detail-org-detail">
							<div class="detail-org-tit color-blue gray__border bold">
								● 条件报送
							</div>
							<div class="detail-org-cont">
								${zskBean.tjbs}
							</div>
						</div>
						<div class="detail-item-retract">
							<div class="detail-item-retract-img">
								<img src="static/weixin/images/retract.png" />
							</div>
						</div>
					</div>
				</c:if>
				<c:if test="${not empty questionList}">
					<li class="detail-block detail-item-nav detail-question-nav">
						<div class="detail-block-left">
							<span>常见问题</span>
						</div>
						<div class="detail-block-right">
							<div class="detail-open">
								<img src="static/weixin/images/open.png" />
							</div>
						</div>
					</li>
					<div class="detail-item-nav-detail">
						<div class="detail-question-detail">
							<div class="detail-question-tit color-blue gray__border bold">
								● ${zskBean.zstitle}常见问题
							</div>
							<div class="detail-question-cont">
								<div>
									<c:forEach items="${questionList}" var="questionBean" varStatus="vs">
										<div class="detail-question-req clearfix">
											<div class="detail-question-req-icon">
												<img src="static/weixin/images/requestion-icon.png" >
											</div>
											<div class="detail-question-req-tit">
												${vs.count}、 ${questionBean.question}
											</div>
										</div>
										<div class="detail-question-answer clearfix">
											<div class="detail-question-answer-icon">
												<img src="static/weixin/images/answer-icon.png" >
											</div>
											<div class="detail-question-answer-tit">
												 ${questionBean.answer}
											</div>
										</div>
									</c:forEach>
								</div>	
								
								<div class="detail-question-end"></div>
							</div>
						</div>
						<div class="detail-item-retract">
							<div class="detail-item-retract-img">
								<img src="static/weixin/images/retract.png" />
							</div>
						</div>
					</div>	
				</c:if>
			</ul>
		</main>
	</div>
</body>
</html>