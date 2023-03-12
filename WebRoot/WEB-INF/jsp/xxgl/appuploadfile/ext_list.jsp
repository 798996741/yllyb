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
				录音管理<small>录音配置</small>
			</h1>
			<ol class="breadcrumb">
				<li><a href="javascript:;" onclick="home()"> <i
						class="fa fa-dashboard"></i> 主页
				</a></li>
				<li class="active">录音配置</li>
			</ol>
		</section>
		<section class="content">
			<div class="row">
				<div class="col-xs-12">
					<div class="box">
						<div class="box-header">

						</div>
						<div class="box-header" style="height:30px;">
							<form action="appUploadFile/listext_list.do" method="post" name="Form" id="Form_user">

								<table  style="margin-top:5px;width:100%">
									<tr>
										<%--										<td style="padding-left:15px;width:20%;">--%>
										<%--											用户名：<input type="text"  class="nav-search-input" id="nav-search-input" autocomplete="off" name="uname" value="${pd.uname }"  style="width:120px;height:30px"/>--%>
										<%--										</td>--%>
										<%--										<td  style="padding-left:15px;width:20%;">--%>
										<%--											手机号码：<input type="text"   class="nav-search-input" id="nav-search-input" autocomplete="off" name="tel" value="${pd.tel }"  style="width:120px;height:30px"/>--%>
										<%--										</td>--%>

										<td style="vertical-align:middle;padding-left:12px">
<%--											<a class="btn btn-mini btn-primary" onclick="tosearch();"  title="检索">--%>
<%--												查询--%>
<%--											</a>--%>
											<c:if test="${QX.add == 1 }">
												<a class="btn btn-mini btn-primary" onclick="add();">新增</a>
											</c:if>
										</td>
									</tr>
								</table>
							</form>
						</div>
						<div class="box-body" style="margin-top:50px">

							<table id="example2"
								   class="table table-striped table-bordered table-hover example2"
								   style="margin-top:5px;">
								<thead>
								<tr>
									<th style="width:40px;min-width:40px;padding-left:10px"><a href="javascript:void(0)" onClick="checkl()" style="color:#2893fd" class=" l-btn-plain">全选<br/>反选</a></th>

									<th class="center">分机号</th>
									<th class="center">分机类型</th>
									<th class="center">映射号码</th>

								</tr>
								</thead>

								<tbody>
								<!-- 开始循环 -->
								<c:choose>
									<c:when test="${not empty varList}">
										<c:if test="${QX.cha != 0 }">
											<c:forEach items="${varList}" var="var" varStatus="vs">
												<tr>
													<td style="width:40px;min-width:40px;padding-left:10px"> <input type="checkbox" name="check" id="check${var.ucode }" value="${var.ucode}"></td>
													<td class='center'>${var.Ext}</td>
													<td class='center'>
														<c:if test="${var.type == '' or  var.type == null}">

														</c:if>
														<c:if test="${var.type == 0 }">
														IP
														</c:if>
														<c:if test="${var.type == 1 }">
														数字
														</c:if>
														<c:if test="${var.type == 2 }">
															模拟
														</c:if>
													</td>
													<td class='center'>${var.virtual}</td>
													<td class="center">
														<c:if test="${QX.del == 1 }">


															<a class="btn btn-xs btn-primary" title="删除"
															   onclick="bind('${var.ID}');"> <i
																	class="ace-icon fa fa-minus-circle bigger-120"
																	title="删除"></i>
															</a>

														</c:if>
														<c:if test="${QX.edit == 1 }">
															<a class="btn btn-xs btn-success" title="修改"
															   onclick="edit('${var.ID}');"> <i
																	class="ace-icon fa fa-pencil-square-o bigger-120"
																	title="修改"></i>
															</a>
														</c:if>
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
		function tosearch(){
			//top.jzts();
			$("#Form_user").submit();
		}



		function checkl(){
			$("input[name='check']").each(function(){
				//$(this).attr("checked",!$(this).attr("checked"));
				this.checked=!this.checked;//用的是Dom的属性
			});

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
				'lengthChange': true,
				'searching'   : false,
				'ordering'    : false,
				'info'        : true,
				'autoWidth'   : true,
				"oLanguage": {
					"sSearch": "快速搜索:",
					"bAutoWidth": true,
					"sLengthMenu": "每页显示 _MENU_ 条记录",
					"sZeroRecords": "Nothing found - 没有记录",
					"sInfo": "当前显示 _START_ 到 _END_ 条,共 _TOTAL_ 条",
					"sInfoEmpty": "显示0条记录",
					"sInfoFiltered": "(从 _MAX_ 条中过滤)",
					// "sProcessing":"<div style=''><img src='../static/img/loader.gif'><span>加载中...</span></div>",
					"oPaginate": {
						"sPrevious": "上一页",
						"sNext": "下一页",
						"sLast": ">>",
						"sFirst": "<<"
					}
				}
			})
		});



		//修改
		var index;
		function edit(id){
			// alert(id);
			index=layer.open({
				type: 2,
				title: "修改",
				closeBtn: 1, //不显示关闭按钮
				shade: [0],
				area: ['640px', '450px'],
				btnAlign: 'c' ,
				content: ["<%=basePath%>appUploadFile/goEditext.do?ID="+id]
			});
		}

		function layclose(){
			layer.close(index);
		}


		function add(){

			index=layer.open({
				type: 2,
				title: "添加",
				closeBtn: 1, //不显示关闭按钮
				shade: [0],
				area: ['640px', '450px'],
				btnAlign: 'c' ,
				content: ["<%=basePath%>appUploadFile/goAddext.do"]
			});
		}
		//删除
		function bind(id){
			var str="删除分机号";
			bootbox.confirm("确定要"+str+"吗?", function(result) {
				if(result) {
					top.jzts();
					var url = "<%=basePath%>appUploadFile/delext.do?id="+id;
					$.get(url,function(data){
						tosearch();
					});
				}
			});
		}


		//导出excel
		function toExcel(){
			window.location.href='<%=basePath%>coupon/excel.do';
		}
	</script>
</body>
</html>