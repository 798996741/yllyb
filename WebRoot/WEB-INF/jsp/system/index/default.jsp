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
		 <div class="row" style="padding-left:20px;">
		        
		      <section class="content-header padbottom15">
		        <h1><font><font>录音统计 </font></font></h1>
		        <ol class="breadcrumb">
		          <li class="active"><font><font></font></font></li>
		        </ol>
		      </section>
		      <div class="row card-row" style="padding-left:10px;">
					
					<div class="col-md-4 col-sm-6 col-xs-12" style="cursor:pointer;width:500px;">
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
		<section class="content" style="padding-top:0px;padding-bottom:0px;margin-top:0px;marrgin-bottom:0px">
			<div class="row">
				<section class="content-header padbottom15">
					<h1>
						<font><font>今日录音信息 </font></font>
					</h1>
					<ol class="breadcrumb">
						<li class="active"><font><font></font></font></li>
					</ol>
				</section>
				<div class="col-xs-12">
					<div class="box">
						
						<div class="box-body">

							<table id="example2"
								class="table table-striped table-bordered table-hover"
								style="margin-top:5px;">
								<thead>
									<tr>
										<th class="center">主叫号码</th>
										<th class="center">被叫号码</th>
										<th class="center">分机号</th>
										<!--<th class="center">设备号</th> -->
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
												<c:forEach items="${varList}" var="var" varStatus="vs">
													<tr>

														<td class='center'>${var.calling_no}</td>
														<td class='center'>${var.called_no}</td>
														<td class='center'>${var.called_no}</td>
															<%-- <td class='center'>${var.driverId}</td> --%>
														<td class='center'>
															<c:if test="${var.direction == 0 }">
																呼入
															</c:if>
															<c:if test="${var.direction == 1 }">
																呼出
															</c:if>
														</td>
														<td class='center'>${var.start_time}</td>

														<td class='center'>${var.lylong}秒</td>


														<td class='center'>${var.start_time}</td>
														<td class='center'>${var.end_time}</td>
														
													</tr>

												</c:forEach>
										
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
		
		
		<section class="content"  style="padding-top:0px;padding-bottom:0px;margin-top:0px;marrgin-bottom:0px">
			<div class="row">
				<section class="content-header padbottom15">
					<h1>
						<font><font>本月录音统计 </font></font>
					</h1>
					<ol class="breadcrumb">
						<li class="active"><font><font></font></font></li>
					</ol>
				</section>
				<div class="col-xs-12">
					<div class="box">
						
						<div class="box-body">

							<table id="example3"
								class="table table-striped table-bordered table-hover"
								style="margin-top:5px;">
								<thead>
									<tr>
										<th class="center">时间</th>
										<th class="center">录音数量</th>
										<th class="center">录音时长</th>
									</tr>
								</thead>

								<tbody>
									<!-- 开始循环 -->
									<c:choose>
										<c:when test="${not empty varList_by}">
												<c:forEach items="${varList_by}" var="var" varStatus="vs">
													<tr>
														<td class='center'>${var.rec}</td>
														<td class='center'>${var.count}</td>
														
														
														<td class='center'>${var.allsum}</td>
														
														
													</tr>

												</c:forEach>
											
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
	<c:if test="${not empty varList}">
		<script type="text/javascript">
			$(function() {
				//日期框
				$('#example2').DataTable({
					'paging'      : true,
				      'lengthChange': false,
				      'searching'   : false,
				      'ordering'    : false,
				      'info'        : true,
				      'autoWidth'   : true
			    })
			    
			    $('#example3').DataTable({
					'paging'      : true,
				      'lengthChange': false,
				      'searching'   : false,
				      'ordering'    : false,
				      'info'        : true,
				      'autoWidth'   : true
			    })
			});
			
		</script>
	</c:if>
	<c:if test="${empty varList}">
		<script type="text/javascript">
			$(function() {
				
			    $('#example3').DataTable({
					'paging'      : true,
				      'lengthChange': false,
				      'searching'   : false,
				      'ordering'    : false,
				      'info'        : true,
				      'autoWidth'   : true
			    })
			});
			
		</script>
	</c:if>
</body>
</html>