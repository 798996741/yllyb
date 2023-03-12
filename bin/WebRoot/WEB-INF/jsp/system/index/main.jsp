<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>系统后台管理</title>
<!-- Tell the browser to be responsive to screen width -->
<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
<jsp:include page="../include/incJs.jsp"></jsp:include>

<!--
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
-->
<script>
	function siMenu(id, fid, MENU_NAME, MENU_URL) {
		//alert(id);

		$("#" + fid).attr("class", "active open");
		$("#" + id).attr("class", "active");
		document.getElementById("mainFrame").src = MENU_URL;

		//有标签的
		//top.mainFrame.tabAddHandler(id,MENU_NAME,MENU_URL);
		//if(MENU_URL != "druid/index.html"){
		//jzts();
		//}	
	}
	     
</script>
</head>
<body class="hold-transition skin-blue sidebar-mini"
	style="background:#ecf0f5;">
	<div class="wrapper">

		<%@ include file="head.jsp"%>
		<aside class="main-sidebar">

			<!-- sidebar: style can be found in sidebar.less -->
			<section class="sidebar">

				<!-- Sidebar user panel (optional) -->
				<div class="user-panel">
					<div class="pull-left image">
						<img src="static/ace/adminlet/dist/img/user2-160x160.jpg" class="img-circle" alt="User Image">
					</div>
					<div class="pull-left info">
						<p>${sessionUser.NAME}</p>
						<!-- Status -->
						<a href="#"><i class="fa fa-circle text-success"></i> Online</a>
					</div>
				</div>

				<!-- search form (Optional) -->

				<!-- /.search form -->

				<!-- Sidebar Menu -->
				<ul class="sidebar-menu" data-widget="tree" >
					<li class="header">菜单栏</li>
					<!-- Optionally, you can add icons to the links -->

					<c:forEach items="${menuList}" var="menu1" varStatus="sta">
						<c:if test="${menu1.hasMenu && '1' == menu1.MENU_STATE}">

							<li <c:if test="${sta.index==0}">class="active treeview"</c:if>
								<c:if test="${sta.index!=0}">class="treeview"</c:if>>
								<a style="cursor:pointer;" >
									<i class="${menu1.MENU_ICON == null ? 'menu-icon fa fa-leaf black' : menu1.MENU_ICON}"></i>
									<span style="margin-bottom:20px;padding-bottom:20px">${menu1.MENU_NAME }</span> 
									<c:if test="${'[]' != menu1.subMenu}">
										<span class="pull-right-container"> 
											<i class="fa fa-angle-left pull-right"></i>
										</span>
									</c:if> 
								</a>
								<ul class="treeview-menu" >
									<c:forEach items="${menu1.subMenu}" var="menu2">
										<c:if test="${menu2.hasMenu && '1' == menu2.MENU_STATE}">
											<li  style="marin-top:0px;padding-top:0px">
												<a onclick="siMenu('z${menu2.MENU_ID }','lm${menu1.MENU_ID }','${menu2.MENU_NAME }','${menu2.MENU_URL }')">
												<i class="fa fa-circle-o"></i>${menu2.MENU_NAME }</a>
											</li>
										</c:if>
									</c:forEach>
								</ul>
							</li>
						</c:if>
					</c:forEach>
				</ul>
				<!-- /.sidebar-menu -->
			</section>
			<!-- /.sidebar -->
		</aside>

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper" style="position: relative;">
			<!-- Content Header (Page header) -->
			<div class=" icon-btn sr-only" style="background-color:#3c8dbc;padding:10px;">
	           <i class=" fa fa-fw fa-align-justify" style="font-size:px;color:#fff;"></i>
	        </div>
			<section class="content-header">
				<h1></h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
					<li class="active">Here</li>
				</ol>
			</section>

			<!-- Main content -->
			<section class="content container-fluid" style="margin:0px;padding-top:0px;padding-left:10px;position:absolute;top:0px;left:0px;right:0px;bottom:0px;background:#ecf0f5;">
				<iframe name="mainFrame" id="mainFrame" frameborder="0" src="tab.do"
					style="margin:0 auto;padding:0px;width:100%;height:100%;display:block;background:#ecf0f5;"></iframe>
			</section>
			<!-- /.content -->
		</div>
		<!-- /.content-wrapper -->

		<!-- Main Footer -->
		<footer class="main-footer">
			<!-- To the right -->
			<div class="pull-right hidden-xs"></div>
			<!-- Default to the left -->
			<strong>Copyright &copy; 2018 yulun Ltd.</strong> All rights
			reserved.
		</footer>

		<!-- Control Sidebar -->
		<aside class="control-sidebar control-sidebar-dark">
			<!-- Create the tabs -->
			<ul class="nav nav-tabs nav-justified control-sidebar-tabs">
				<li class="active">
					<a href="#control-sidebar-home-tab" data-toggle="tab">
						<i class="fa fa-home"></i>
					</a>
				</li>
				<li>
					<a href="#control-sidebar-settings-tab" data-toggle="tab">
						<i class="fa fa-gears"></i>
					</a>
				</li>
			</ul>
			<!-- Tab panes -->
			<div class="tab-content">
				<!-- Home tab content -->
				<div class="tab-pane active" id="control-sidebar-home-tab">
					<h3 class="control-sidebar-heading">Recent Activity</h3>
					<ul class="control-sidebar-menu">
						<li>
							<a href="javascript:;"> 
								<i class="menu-icon fa fa-birthday-cake bg-red"></i>

								<div class="menu-info">
									<h4 class="control-sidebar-subheading">Langdon's Birthday</h4>
									<p>Will be 23 on April 24th</p>
								</div>
							</a>
						</li>
					</ul>
					<!-- /.control-sidebar-menu -->

					<h3 class="control-sidebar-heading">Tasks Progress</h3>
					<ul class="control-sidebar-menu">
						<li>
							<a href="javascript:;">
								<h4 class="control-sidebar-subheading">
									Custom Template Design 
									<span class="pull-right-container">
										<span class="label label-danger pull-right">70%</span>
									</span>
								</h4>
								<div class="progress progress-xxs">
									<div class="progress-bar progress-bar-danger" style="width: 70%">
									</div>
								</div>
							</a>
						</li>
					</ul>
					<!-- /.control-sidebar-menu -->

				</div>
				<!-- /.tab-pane -->
				<!-- Stats tab content -->
				<div class="tab-pane" id="control-sidebar-stats-tab">Stats TabContent</div>
				<!-- /.tab-pane -->
				<!-- Settings tab content -->
				<div class="tab-pane" id="control-sidebar-settings-tab">
					<form method="post">
						<h3 class="control-sidebar-heading">General Settings</h3>
						<div class="form-group">
							<label class="control-sidebar-subheading"> 
								Report panel usage 
								<input type="checkbox" class="pull-right" checked>
							</label>

							<p>Some information about this general settings option</p>
						</div>
						<!-- /.form-group -->
					</form>
				</div>
				<!-- /.tab-pane -->
			</div>
		</aside>
		<!-- /.control-sidebar -->
		<div class="control-sidebar-bg"></div>
	</div>
	<!-- ./wrapper -->

	
	<script>
		function jzts() {
			
		}
	</script>
</body>
</html>