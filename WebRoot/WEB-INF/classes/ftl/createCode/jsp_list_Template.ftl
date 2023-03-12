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
<!-- 下拉框 -->
<link rel="stylesheet" href="static/ace/css/chosen.css" />
<!-- jsp文件头和头部 -->
<!-- 日期框 -->
<%@ include file="../system/include/incJs_mx.jsp"%>
<link rel="stylesheet" href="static/ace/css/datepicker.css" />
</head>
<body class="no-skin">

	<!-- Content Wrapper. Contains page content -->
	<div class="content-wrapper" style="width:100%;margin-left:0px;">
		<!-- Content Header (Page header) -->
		<section class="content-header">
			<h1>
				<small>${TITLE}</small>
			</h1>
			<ol class="breadcrumb">
				<li><a href="javascript:;" onclick="home()"> <i
						class="fa fa-dashboard"></i> 主页
				</a></li>
				<li class="active">${TITLE}</li>
			</ol>
		</section>

		<!-- Main content -->
		<section class="content">
			<div class="row">
				<div class="col-xs-12">
					<div class="box">
						<div class="box-header">
			              	<c:if test="${r"${QX.add == 1 }"}">
								<a class="btn btn-mini btn-success" onclick="add();">新增</a>
							</c:if>
			            </div>
						<!-- /.box-header -->
						<div class="box-body">
							<table id="example2" class="table table-bordered table-hover">
							<thead>
								<tr>
									<th class="center" style="width:35px;">
									<label class="pos-rel"><input type="checkbox" class="ace" id="zcheckbox" /><span class="lbl"></span></label>
									</th>
									<th class="center" style="width:50px;">序号</th>
								<#list fieldList as var>
									<th class="center">${var[2]}</th>
								</#list>
									<th class="center">操作</th>
								</tr>
							</thead>
													
							<tbody>
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${r"${not empty varList}"}">
									<c:if test="${r"${QX.cha == 1 }"}">
									<c:forEach items="${r"${varList}"}" var="var" varStatus="vs">
										<tr>
											<td class='center'>
												<label class="pos-rel"><input type='checkbox' name='ids' value="${r"${var."}${objectNameUpper}_ID${r"}"}" class="ace" /><span class="lbl"></span></label>
											</td>
											<td class='center' style="width: 30px;">${r"${vs.index+1}"}</td>
										<#list fieldList as var>
											<td class='center'>${r"${var."}${var[0]}${r"}"}</td>
										</#list>
											<td class="center">
												<c:if test="${r"${QX.edit != 1 && QX.del != 1 }"}">
												<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="ace-icon fa fa-lock" title="无权限"></i></span>
												</c:if>
												<div class="">
													<c:if test="${r"${QX.edit == 1 }"}">
													<a class="btn btn-xs btn-success" title="编辑" onclick="edit('${r"${var."}${objectNameUpper}_ID${r"}"}');">
														<i class="ace-icon fa fa-pencil-square-o bigger-120" title="编辑"></i>
													</a>
													</c:if>
													<c:if test="${r"${QX.del == 1 }"}">
													<a class="btn btn-xs btn-danger" onclick="del('${r"${var."}${objectNameUpper}_ID${r"}"}');">
														<i class="ace-icon fa fa-trash-o bigger-120" title="删除"></i>
													</a>
													</c:if>
												</div>
												
											</td>
										</tr>
									
									</c:forEach>
									</c:if>
									<c:if test="${r"${QX.cha == 0 }"}">
										<tr>
											<td colspan="100" class="center">您无权查看</td>
										</tr>
									</c:if>
								</c:when>
								<c:otherwise>
									<tr class="main_info">
										<td colspan="100" class="center" >没有相关数据</td>
									</tr>
								</c:otherwise>
							</c:choose>
							</tbody>
						</table>
						
						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
				</div>
				<!-- /.page-content -->
			</div>
		</div>
		<!-- /.main-content -->

		<!-- 返回顶部 -->
		<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
			<i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
		</a>

	</div>
	<!-- /.main-container -->

	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<script src="static/ace/js/bootbox.js"></script>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script type="text/javascript">
		//$(top.hangge());//关闭加载状态
		//检索
		function tosearch(){
			//top.jzts();
			$("#Form").submit();
		}
		$(function () {
		    $('#example2').DataTable({
		      'paging'      : true,
		      'lengthChange': false,
		      'searching'   : true,
		      'ordering'    : true,
		      'info'        : true,
		      'autoWidth'   : true
		    })
		})
		function home(){
			parent.document.getElementById("mainFrame").src="<%=basePath%>login_default.do";
		}
		
		//新增
		function add(){
			var winId = "userWin";
		  	modals.openWin({
	          	winId: winId,
	          	title: '新增',
	          	width: '900px',
	          	height: '450px',
	          	url: '<%=basePath%>${objectNameLower}/goAdd.do'
	          	/*, hideFunc:function(){
	             	 modals.info("hide me");
	          	},
	          	showFunc:function(){
	              	modals.info("show me");
	          	} */
	      	});
			
		}
		
		//删除
		function del(Id){
			bootbox.confirm("确定要删除吗?", function(result) {
				if(result) {
					
					var url = "<%=basePath%>${objectNameLower}/delete.do?${objectNameUpper}_ID="+Id+"&tm="+new Date().getTime();
					$.get(url,function(data){
						//tosearch();
						location.href="<%=path%>/${objectNameLower}/list.do";
					});
				}
			});
		}
		
		//修改
		function edit(Id){
			var winId = "userWin";
		  	modals.openWin({
	          	winId: winId,
	          	title: '新增',
	          	width: '900px',
	          	height: '450px',
	          	url: '<%=basePath%>${objectNameLower}/goEdit.do?${objectNameUpper}_ID='+Id
	          	/*, hideFunc:function(){
	             	 modals.info("hide me");
	          	},
	          	showFunc:function(){
	              	modals.info("show me");
	          	} */
	      	});
			
			
		}
		
	
		
		//导出excel
		function toExcel(){
			window.location.href='<%=basePath%>${objectNameLower}/excel.do';
		}
	</script>


</body>
</html>