﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<html lang="en">
<head>
<base href="<%=basePath%>">
<!-- 下拉框 -->
<!-- jsp文件头和头部 -->
<%-- 
<%@ include file="../index/top.jsp"%> --%>
<%@ include file="../../system/include/incJs_mx.jsp"%>
<link href="static/dist/skin/blue.monday/css/jplayer.blue.monday.min.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="static/dist/jplayer/jquery.jplayer.min.js"></script>
<style>
.table th {
	font-size: 14px;
}

.table td {
	font-size: 14px;
}
</style>
</head>
<body class="no-skin">
	<div class="content-wrapper" style="width:100%;margin-left:0px;">
		<section class="content-header">
			<h1>
				录音信息<small>话单信息</small>
			</h1>
			<ol class="breadcrumb">
				<li><a href="javascript:;" onclick="home()"> <i
						class="fa fa-dashboard"></i> 主页
				</a></li>
				<li class="active">录音记录</li>
			</ol>
		</section>
		<section class="content">
			<div class="row">
				<div class="col-xs-12">
					<div class="box">
						<div class="box-header">
							
						</div>
						<div class="box-body">

							<table id="example2"
								class="table table-striped table-bordered table-hover"
								style="margin-top:5px;">
								<thead>
									<tr>
										<th class="center">本地号码</th>
										<th class="center">拨打电话</th>
										<th class="center">专属号码</th>
										<th class="center">拨打时间</th>
										<th class="center">通话时长</th>
										<th class="center">账号</th>
										<th class="center">接收时间</th>
										<th class="center">播放</th>
									</tr>
								</thead>

								<tbody>
									<!-- 开始循环 -->
									<c:choose>
										<c:when test="${not empty varList}">
											<c:if test="${QX.cha == 1 }">
												<c:forEach items="${varList}" var="var" varStatus="vs">
													<tr>
														<td class='center'>${var.callerNum}</td>
														<td class='center'>${var.calleeNum}</td>
														<td class='center'>${var.calleeShowNum}</td>
														<td class='center'>${var.startTime}至${var.endTime}</td>
														<td class='center'>${var.duration}秒</td>
														<td class='center'>${var.ucode}</td>
														<td class='center'>${var.jsdate}</td>
														<td class="center">
																
														
															<a class="btn btn-xs btn-success" title="播放"
																onclick="edit('${var.id}','${var.recordUrl}');"> <i
																class="ace-icon fa fa-pencil-square-o bigger-120"
																title="播放"></i>
															</a> 
														</td>
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

							<!-- /.box-body -->
						</div>
						<!-- /.box -->

					</div>
					<!-- /.col -->
				</div>
				<!-- /.row -->
		</section>
		<!-- /.content -->
	</div>

	<!-- /.main-container -->

	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<!-- 删除时确认窗口 -->
	<script src="static/ace/js/bootbox.js"></script>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<script type="text/javascript">
		//$(top.hangge());//关闭加载状态
		//检索
		function tosearch(){
			//top.jzts();
			//$("#Form").submit();
		}
		$(function() {
			$('#example2').DataTable({
				'paging'      : true,
			      'lengthChange': false,
			      'searching'   : true,
			      'ordering'    : true,
			      'info'        : true,
			      'autoWidth'   : true
		    })
		});
		
		
		
		//修改
		function edit(id,uploadfile){
			
			var winId = "userWin";
		  	modals.openWin({
	          	winId: winId,
	          	title: '录音播放',
	          	width: '450px',
	          	height: '280px',
	          	url: '<%=basePath%>dail/goEdit.do?ID='+id
	      	});
			
		}
		
		
		//导出excel
		function toExcel(){
			window.location.href='<%=basePath%>coupon/excel.do';
		}
	</script>
</body>
</html>