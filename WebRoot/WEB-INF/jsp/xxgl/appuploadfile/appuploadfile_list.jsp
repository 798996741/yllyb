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
 <link rel="stylesheet" href="static/js/layer/theme/layer.css?t=1568076536509" media="all">
<script src="static/js/layer/layer.js?t=1568076536509"></script>
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
				录音管理<small>录音信息</small>
			</h1>
			<ol class="breadcrumb">
				<li><a href="javascript:;" onclick="home()"> <i
						class="fa fa-dashboard"></i> 主页
				</a></li>
				<li class="active">录音信息</li>
			</ol>
		</section>
		<section class="content">
			<div class="row">
				<div class="col-xs-12">
					<div class="box">
						<div class="box-header" style="height:30px;">
							<form action="appUploadFile/list.do" method="post" name="Form" id="Form">
							
								<table  style="margin-top:5px;width:100%">
									<tr>
<%--										<td style="padding-left:15px;width:300px;">--%>
<%--											<div style="float:left;padding-top:7px;">用户名：</div><select name="uname" id="selct" style="width:200px;max-width:200px;float:left">--%>
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
<%--														<option value="${var.ucode}" >${var.uname}</option>--%>
<%--													</c:forEach>--%>
<%--												</c:if>--%>
<%--											</select>--%>
<%--										</td>--%>
										<td  style="padding-left:15px;width:20%;">
											手机号码：<input type="text"   class="nav-search-input" id="nav-search-input" autocomplete="off" name="callNumber" value="${pd.callNumber }"  style="width:120px;height:30px"/>
										</td>
										<td style="padding-left:15px;width:20%;">开始时间：<input class="span10 date-picker" name="lastStart" id="lastStart"  value="${pd.lastStart }" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:120px;height:30px"/></td>
										<td style="padding-left:15px;width:20%;">结束时间：<input class="span10 date-picker" name="lastEnd" name="lastEnd"  value="${pd.lastEnd }" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:120px;height:30px"/></td>
										<td style="vertical-align:middle;padding-left:12px"><a class="btn btn-mini btn-primary" onclick="tosearch();">查询</a></td>
									</tr>
								</table>
							</form>
						</div>
						<div class="box-body" style="margin-top:45px;">

							<table id="example2" class="table table-bordered table-hover">
								<thead>
									<tr>
										<th style="width:60px;min-width:60px;padding-left:10px"><a href="javascript:void(0)" onClick="checkl()" style="color:#2893fd" class=" l-btn-plain">全选<br/>反选</a></th>
										
<%--										<th class="center">用户名</th>--%>
										<th class="center">主叫号码</th>
										<th class="center">被叫号码</th>
										<th class="center">分机号</th>
										<!--<th class="center">设备号</th> -->
										<th class="center">呼入/呼出</th>
										<th class="center">录音时间</th>
										
										<th class="center">录音时长</th>
										
										
										<th class="center">开始时间</th>
										<th class="center">结束时间</th>
										<th class="center">播放</th>
									</tr>
								</thead>

								<tbody>
									<!-- 开始循环 -->
									<c:choose>
										<c:when test="${not empty varList}">
											<c:if test="${QX.cha != 0 }">
												<c:forEach items="${varList}" var="var" varStatus="vs">
													<tr>
														<td style="width:60px;min-width:60px;padding-left:10px"> <input type="checkbox" name="check" id="check${var.id }" value="${var.id}"></td>
<%--														<td class='center'>${var.uname}(${var.ucode})</td>--%>
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
														<td class="center">
																
														
															<a class="btn btn-xs btn-success" title="播放"
																onclick="edit('${var.id}','${var.file_name}');"> <i
																class="ace-icon fa fa-pencil-square-o bigger-120"
																title="播放"></i>
															</a>
															<a class="btn btn-xs btn-success" title="下载" type="button"
																href="${pd.baseurl}${var.file_name}"> <i
																class="ace-icon fa fa-download bigger-120"
																title="下载"></i>
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
							<div class="page-header position-relative">
								<table style="width:100%;">
									<tr>
										<td style="vertical-align:top;">
											
											<a class="btn btn-mini btn-danger" onclick="downpl()" title="批量下载" ><i class='ace-icon fa fa-download bigger-120'></i></a>
											
										</td>
										<td style="vertical-align:top;"><div class="pagination" style="float: right;margin-right:10px;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
									</tr>
								</table>
							</div>
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
		function downpl(){
			var obj = document.getElementsByName("check");
			var ids="";
		    check_val = [];
		    for(k in obj){
		        if(obj[k].checked){
		        	if(ids!=""){
		        		ids=ids+",";
		        	}
		        	ids=ids+obj[k].value;
		        }
		    }
		    if(ids==""){
		    	alert("请选择要下载的信息！");
		    	return false;
		    }
			location.href="<%=path%>/appUploadFile/download.do?id="+ids+"";
		}
		
		function checkl(){
			$("input[name='check']").each(function(){
				//$(this).attr("checked",!$(this).attr("checked"));
				this.checked=!this.checked;//用的是Dom的属性
			});
			
		}
		function tosearch(){
			//top.jzts();
			$("#Form").submit();
		}
		$(function() {
			//日期框
			$('#selct').comboSelect();
			$('.date-picker').datepicker({
				autoclose: true,
				todayHighlight: true
			});
			// $('#example2').DataTable({
			// 	'paging'      : true,
			//       'lengthChange': false,
			//       'searching'   : false,
			//       'ordering'    : false,
			//       'info'        : true,
			//       'autoWidth'   : true
		    // })
		});
		
		
		
		//修改
		function edit(id,uploadfile){
			
			<%-- var winId = "userWin";
		  	modals.openWin({
	          	winId: winId,
	          	title: '录音播放',
	          	width: '450px',
	          	height: '280px',
	          	url: '<%=basePath%>appUploadFile/goEdit.do?ID='+id
	      	}); --%>
		  	
		  	layer.open({
		  	  type: 2,
		  	  title: "录音播放",
		  	  closeBtn: 1, //不显示关闭按钮
		  	  shade: [0],
		  	  area: ['540px', '215px'],
		  	  btnAlign: 'c' ,
		  	  content: ["<%=basePath%>appUploadFile/goEdit.do?ID="+id+"", 'no']
		  	});
			
		}
		
		
		//导出excel
		function toExcel(){
			window.location.href='<%=basePath%>coupon/excel.do';
		}
	</script>
</body>
</html>