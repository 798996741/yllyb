<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
<!-- jsp文件头和头部 --><%-- 
<%@ include file="../index/top.jsp"%> --%>
<%@ include file="../../system/include/incJs_mx.jsp"%>
<!-- 日期框 -->
</head>
<body class="no-skin">


<!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper" style="width:100%;margin-left:0px;">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        	系统管理
        <small>用户管理</small>
      </h1>
      <ol class="breadcrumb">
        <li>
			<a href="javascript:;" onclick="home()">
				<i class="fa fa-dashboard"></i> 主页
			</a>
		</li>
		<li class="active">用户管理</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content">
      <div class="row">
        <div class="col-xs-12">
          <div class="box">
            <div class="box-header">
              	<c:if test="${QX.add == 1 }">
					<a class="btn btn-mini btn-success" onclick="add();">新增</a>
				</c:if>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
              <table id="example2" class="table table-bordered table-hover">
                <thead>
                <tr>
                  	<!-- <th class="center" style="width:35px;">
					<label class="pos-rel"><input type="checkbox" class="ace" id="zcheckbox" /><span class="lbl"></span></label>
					</th> -->
					<th class="center" style="width:50px;">序号</th>
					<th class="center">编号</th>
					<th class="center">用户名</th>
					<th class="center">姓名</th>
					<th class="center">角色</th>
					<th class="center"><i class="ace-icon fa fa-envelope-o"></i>邮箱</th>
					<th class="center"><i class="ace-icon fa fa-clock-o bigger-110 hidden-480"></i>最近登录</th>
					<th class="center">上次登录IP</th>
					<th class="center">操作</th>
                </tr>
                </thead>
                <tbody>
                
               <c:choose>
					<c:when test="${not empty userList}">
						<c:if test="${QX.cha == 1 }">
						<c:forEach items="${userList}" var="user" varStatus="vs">
									
							<tr>
								
								<td class='center' style="width: 30px;">${vs.index+1}</td>
								<td class="center">${user.NUM }</td>
								<td class="center"><a onclick="viewUser('${user.USERNAME}')" style="cursor:pointer;">${user.USERNAME }</a></td>
								<td class="center">${user.NAME }</td>
								<td class="center">${user.ROLE_NAME }</td>
								<td class="center"><a title="发送电子邮件" style="text-decoration:none;cursor:pointer;" <c:if test="${QX.email == 1 }">onclick="sendEmail('${user.EMAIL }');"</c:if>>${user.EMAIL }&nbsp;<i class="ace-icon fa fa-envelope-o"></i></a></td>
								<td class="center">${user.LAST_LOGIN}</td>
								<td class="center">${user.IP}</td>
								<td class="center">
									
									<div class="hidden-sm hidden-xs btn-group">
										
										<c:if test="${QX.edit == 1 }">
										<a class="btn btn-xs btn-success" title="编辑" onclick="editUser('${user.USER_ID}');">
											<i class="ace-icon fa fa-pencil-square-o bigger-120" title="编辑"></i>
										</a>
										</c:if>&nbsp;&nbsp;&nbsp;&nbsp;
										<c:if test="${QX.del == 1 }">
										<a class="btn btn-xs btn-danger"  style="margin-left:10px" onclick="delUser('${user.USER_ID }','${user.USERNAME }');">
											<i class="ace-icon fa fa-trash-o bigger-120" title="删除"></i>
										</a>
										</c:if>
									</div>
									
								</td>
							</tr>
						
						</c:forEach>
						</c:if>
						<c:if test="${QX.cha == 0 }">
							<tr>
								<td colspan="10" class="center">您无权查看</td>
							</tr>
						</c:if>
					</c:when>
					<c:otherwise>
						<tr class="main_info">
							<td colspan="10" class="center">没有相关数据</td>
						</tr>
					</c:otherwise>
				</c:choose>
                
                </tbody>
               
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
  <!-- /.content-wrapper -->

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
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script type="text/javascript">
		
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
//$(top.hangge());

//检索
function searchs(){
	//top.jzts();
	//alert($("#lastLoginStart").val());
	$("#userForm").submit();
}

//删除
function delUser(userId,msg){
	if(confirm("确定要删除["+msg+"]吗?")) {
		
		var url = "<%=basePath%>user/deleteU.do?USER_ID="+userId+"&tm="+new Date().getTime();
		$.get(url,function(data){
			nextPage(${page.currentPage});
		});
	}
}

//新增
function add(){
	 //top.jzts();
	 var winId = "userWin";
	  modals.openWin({
          winId: winId,
          title: '新增',
          width: '900px',
          url: '<%=basePath%>user/goAddU.do'
          /*, hideFunc:function(){
              modals.info("hide me");
          },
          showFunc:function(){
              modals.info("show me");
          } */
      });
	 
}

//修改
function editUser(user_id){
	// top.jzts();
	var winId = "userWin";
	  modals.openWin({
          winId: winId,
          title: '新增',
          width: '900px',
          url: '<%=basePath%>user/goEditU.do?USER_ID='+user_id
          /*, hideFunc:function(){
              modals.info("hide me");
          },
          showFunc:function(){
              modals.info("show me");
          } */
      });
	
}


//去发送短信页面
function sendSms(phone){
	 //top.jzts();
	 var diag = new top.Dialog();
	 diag.Drag=true;
	 diag.Title ="发送短信";
	 diag.URL = '<%=basePath%>head/goSendSms.do?PHONE='+phone+'&msg=appuser';
	 diag.Width = 600;
	 diag.Height = 265;
	 diag.CancelEvent = function(){ //关闭事件
		diag.close();
	 };
	 diag.show();
}

//去发送电子邮件页面
function sendEmail(EMAIL){
	// top.jzts();
	 var diag = new top.Dialog();
	 diag.Drag=true;
	 diag.Title ="发送电子邮件";
	 diag.URL = '<%=basePath%>head/goSendEmail.do?EMAIL='+EMAIL;
	 diag.Width = 660;
	 diag.Height = 486;
	 diag.CancelEvent = function(){ //关闭事件
		diag.close();
	 };
	 diag.show();
}

//发站内信
function sendFhsms(username){
	 //top.jzts();
	 var diag = new top.Dialog();
	 diag.Drag=true;
	 diag.Title ="站内信";
	 diag.URL = '<%=basePath%>fhsms/goAdd.do?username='+username;
	 diag.Width = 660;
	 diag.Height = 444;
	 diag.CancelEvent = function(){ //关闭事件
		diag.close();
	 };
	 diag.show();
}

$(function() {
	
});

//导出excel
function toExcel(){
	var keywords = $("#nav-search-input").val();
	var lastLoginStart = $("#lastLoginStart").val();
	var lastLoginEnd = $("#lastLoginEnd").val();
	var ROLE_ID = $("#role_id").val();
	window.location.href='<%=basePath%>user/excel.do?keywords='+keywords+'&lastLoginStart='+lastLoginStart+'&lastLoginEnd='+lastLoginEnd+'&ROLE_ID='+ROLE_ID;
}

//打开上传excel页面
function fromExcel(){
	 //top.jzts();
	 var diag = new top.Dialog();
	 diag.Drag=true;
	 diag.Title ="EXCEL 导入到数据库";
	 diag.URL = '<%=basePath%>user/goUploadExcel.do';
	 diag.Width = 300;
	 diag.Height = 150;
	 diag.CancelEvent = function(){ //关闭事件
		 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
			 if('${page.currentPage}' == '0'){
				// top.jzts();
				 setTimeout("self.location.reload()",100);
			 }else{
				 nextPage(${page.currentPage});
			 }
		}
		diag.close();
	 };
	 diag.show();
}	

//查看用户
function viewUser(USERNAME){
	if('admin' == USERNAME){
		bootbox.dialog({
			message: "<span class='bigger-110'>不能查看admin用户!</span>",
			buttons: 			
			{ "button":{ "label":"确定", "className":"btn-sm btn-success"}}
		});
		return;
	}
	// top.jzts();
	 var diag = new top.Dialog();
	 diag.Drag=true;
	 diag.Title ="资料";
	 diag.URL = '<%=basePath%>user/view.do?USERNAME='+USERNAME;
	 diag.Width = 469;
	 diag.Height = 380;
	 diag.CancelEvent = function(){ //关闭事件
		diag.close();
	 };
	 diag.show();
}
		
</script>
</body>
</html>
