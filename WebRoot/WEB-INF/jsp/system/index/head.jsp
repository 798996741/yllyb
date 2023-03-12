
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script>
window.onload = function ()
{
	//alert($("[data-toggle='offcanvas']"));
	$("[data-toggle='offcanvas']").click();
	
} 
</script>
<header class="main-header">

	<!-- Logo -->
	<a class="logo"> <!-- mini logo for sidebar mini 50x50 pixels --> <!-- logo for regular state and mobile devices -->
		<span class="logo-lg">录音宝管理系统</span>
	</a>

	<!-- Header Navbar -->
	<nav class="navbar navbar-static-top" role="navigation">
		<!-- Sidebar toggle button-->
		<a class="sidebar-toggle" data-toggle="offcanvas" role="button"> <span
			class="sr-only">Toggle navigation</span>
		</a>
		<!-- Navbar Right Menu -->
		<div class="navbar-custom-menu">
			<ul class="nav navbar-nav">
				<!-- Messages: style can be found in dropdown.less-->

				<!-- User Account Menu -->
				<li class="dropdown user user-menu">
					<!-- Menu Toggle Button --> 
					<a class="dropdown-toggle" data-toggle="dropdown"> <!-- The user image in the navbar--> <img
						src="static/ace/adminlet/dist/img/user2-160x160.jpg"
						class="user-image" alt="User Image"> <!-- hidden-xs hides the username on small devices so only the image appears. -->
						<span class="hidden-xs">${sessionUser.NAME}</span>
				</a>
					<ul class="dropdown-menu">
						<!-- The user image in the menu -->
						<li class="user-header">
							<img src="static/ace/adminlet/dist/img/user2-160x160.jpg" class="img-circle" alt="User Image">
							<p>${sessionUser.USERNAME}</p>
						</li>
						<!-- Menu Body -->
						<li class="user-body"></li>
						<!-- Menu Footer-->
						<li class="user-footer">
							<div class="pull-right">
								<a href="logout" class="btn btn-default btn-flat">退出</a>
							</div>
						</li>
					</ul>
				</li>
			</ul>
		</div>
	</nav>
</header>
