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
<html lang="en">
<head>
<base href="<%=basePath%>">
<!-- 下拉框 -->
<!-- jsp文件头和头部 -->
<%-- 
<%@ include file="../index/top.jsp"%> --%>
<%@ include file="../../system/include/incJs_mx.jsp"%>
<!-- 日期框 -->
<link rel="stylesheet" href="static/ace/css/datepicker.css" />
<script src="static/js/jquery.combo.select.js"></script>
<link rel="stylesheet" href="static/css/combo.select.css">
<style>
th {
	font-size: 14px;
}

td {
	font-size: 14px;
}
</style>
</head>
<body class="no-skin">
	<div class="content-wrapper" style="width:100%;margin-left:0px;">
		<section class="content-header">
			<h1>
				录音管理<small>录音信息统计</small>
			</h1>
			<ol class="breadcrumb">
				<li><a href="javascript:;" onclick="home()"> <i
						class="fa fa-dashboard"></i> 主页
				</a></li>
				<li class="active">录音统计</li>
			</ol>
		</section>
		<section class="content">
			<div class="row">
				<div class="col-xs-12">
					<div class="box">
						<div class="box-header" style="height:30px;width:100%">
							<form action="appUploadFile/listTj.do" method="post" name="Form" id="Form">
							
								<table style="margin-top:5px;width:100%;">
									<tr>
<%--										<td style="padding-left:15px;width:300px;">--%>
<%--											<div style="float:left;padding-top:7px;">用户名：</div><select name="uname" style="width:200px;max-width:200px;float:left">--%>
<%--												--%>
<%--												<c:if test="${not empty pd.uname}">--%>
<%--													<option value=""></option>--%>
<%--													<c:forEach items="${userList}" var="var" varStatus="vs">--%>
<%--														<option value="${var.ucode}" <c:if test="${pd.uname ==var.ucode}">selected</c:if>>${var.uname}</option>--%>
<%--													</c:forEach>--%>
<%--												</c:if>--%>
<%--												<c:if test="${empty pd.uname}">--%>
<%--													<option value=""></option>--%>
<%--													<c:forEach items="${userList}" var="var" varStatus="vs">--%>
<%--														<option value="${var.ucode}" <c:if test="${sessionUser.USERNAME ==var.ucode}">selected</c:if>>${var.uname}</option>--%>
<%--													</c:forEach>--%>
<%--												</c:if>--%>
<%--											</select>--%>
<%--										</td>--%>
										
										<td style="padding-left:15px;width:25%;">开始时间：<input class="span10 date-picker" name="lastStart" id="lastStart"  value="${pd.lastStart }" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:160px;height:30px"/></td>
										<td style="padding-left:15px;width:25%;">结束时间：<input class="span10 date-picker" name="lastEnd" name="lastEnd"  value="${pd.lastEnd }" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:160px;height:30px"/></td>
										<td style="vertical-align:middle;padding-left:2px"><a class="btn btn-mini btn-primary" onclick="tosearch();">查询</a></td>
									</tr>
								</table>
							</form>
						</div>
						<div class="box-body" style="margin-top:50px;">

							<table id="example2"
								class="table table-striped table-bordered table-hover"
								style="margin-top:5px;">
								<thead>
									<tr>
										<th class="center">用户名</th>
										<th class="center">时间</th>
										<th class="center">录音数量</th>
										<th class="center">录音时长</th>
									</tr>
								</thead>

								<tbody>
									<!-- 开始循环 -->
									<c:choose>
										<c:when test="${not empty varList}">
											<c:if test="${QX.cha != 0 }">
												<c:forEach items="${varList}" var="var" varStatus="vs">
													<tr>
														<td class='center'>${var.ext_no}</td>
														<td class='center'>${var.rec}</td>
														<td class='center'>${var.count}</td>
														
														
														<td class='center'>${var.allsum}</td>
														
														
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
			$("#Form").submit();
		}
		$(function() {
			//日期框
			$('select').comboSelect();
			$('.date-picker').datepicker({
				autoclose: true,
				todayHighlight: true
			});
			$('#example2').DataTable({
				'paging'      : true,
			      'lengthChange': false,
			      'searching'   : false,
			      'ordering'    : false,
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
	          	url: '<%=basePath%>appUploadFile/goEdit.do?ID='+id
	      	});
			
		}
		
		
		//导出excel
		function toExcel(){
			window.location.href='<%=basePath%>coupon/excel.do';
		}
	</script>
</body>
</html>