<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">

<!-- jsp文件头和头部 -->
<%@ include file="../include/incJs_mx.jsp"%>
</head>
<body class="no-skin" style="background:rgb(236,240,245)">

	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		
        <section class="content" style="background:rgb(236,240,245)">
        
        	 <div class="row">
		        
		      <section class="content-header padbottom15">
		        <h1><font><font>录音统计 </font></font></h1>
		        <ol class="breadcrumb">
		          <li class="active"><font><font></font></font></li>
		        </ol>
		      </section>
		      <div class="row card-row" style="padding-left:10px;">
					
					<div class="col-md-4 col-sm-6 col-xs-12" style="cursor:pointer">
						<div class="info-box card-box">
							<div class="info-box-top">
								<span class="info-box-title">录音总时长  <span class="text-hongse">${pd_allcount.allsum }</span></span><span
									class="info-icon"><i
									class="icon icon-chengse font20 icon-guanzhu"></i></span>
							</div>
							<div class="info-box-bottom">
								<span class="info-number">录音总数  <span class="text-lvse">${pd_allcount.count }</span></span><span
									class="info-undone">本月录音数  <span class="text-hongse">${pd_monthcount.count }</span></span><span
									class="info-task">本日录音数  <span class="text-lvse">${pd_daycount.count }</span></span>
							</div>
						</div>
					</div>
				</div>
		      
		      </div>
		      
		      <div class="row">

				<section class="content-header padbottom15">
					<h1>
						<font><font>今日录音信息 </font></font>
					</h1>
					<ol class="breadcrumb">
						<li class="active"><font><font></font></font></li>
					</ol>
				</section>
				<div class="row card-row" style="padding-left:10px;">
				
					<table id="dataList" class="table table-striped table-bordered table-hover"
								style="margin-top:5px;">
								<thead>
									<tr>
										<th class="center">用户名</th>
										<th class="center">电话号码</th>
										<th class="center">设备号</th>
										<th class="center">呼入/呼出</th>
										<th class="center">录音时间</th>
										
										<th class="center">录音时长</th>
										<th class="center">开始时间</th>
										<th class="center">结束时间</th>
									</tr>
								</thead>

								<tbody>
									<!-- 开始循环 -->
									<c:choose>
										<c:when test="${not empty varList}">
											<c:if test="${QX.cha != 0 }">
												<c:forEach items="${varList}" var="var" varStatus="vs">
													<tr>
														<td class='center'>${var.uname}(${var.ucode})</td>
														<td class='center'>${var.callNumber}</td>
														<td class='center'>${var.driverId}</td>
														<td class='center'>
															<c:if test="${var.callinout == 0 }">
																呼入
															</c:if>
															<c:if test="${var.callinout == 1 }">
																呼出
															</c:if>
														</td>
														<td class='center'>${var.recTime}</td>
														
														<td class='center'>${var.lylong}秒</td>
														
														
														<td class='center'>${var.endTime}</td>
														<td class='center'>${var.czdate}</td>
														
													</tr>

												</c:forEach>
											</c:if>
											<c:if test="${QX.cha == 0 }">
												<tr>
													<td colspan="100" class="center">您无权查看</td>
												</tr>
											</c:if>
										</c:when>
										<c:otherwise>
											<tr class="main_info">
												<td colspan="100" class="center">没有相关数据</td>
											</tr>
										</c:otherwise>
									</c:choose>
								</tbody>
							</table>
				
				</div>

			</div>
		      
        
        </section>
    </div>
	<script type="text/javascript">
		//$(top.hangge());
		$(function() {
			//日期框
			alert($('#dataList'));
			$('#dataList').DataTable({
				'paging'      : true,
			      'lengthChange': false,
			      'searching'   : false,
			      'ordering'    : false,
			      'info'        : true,
			      'autoWidth'   : true
		    })
		});
		
		
	</script>
<script type="text/javascript" src="static/ace/js/jquery.js"></script>
</body>
</html>