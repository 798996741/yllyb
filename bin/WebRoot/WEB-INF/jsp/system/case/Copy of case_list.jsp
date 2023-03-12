﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="com.fh.util.Jurisdiction" %>
<%
	Jurisdiction jurisdiction=new Jurisdiction();
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
<%@ include file="../index/top.jsp"%>

<!-- 日期框 -->
<script type="text/javascript" src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
<link rel="stylesheet" href="static/ace/css/datepicker.css" />
</head>
<body class="no-skin">

	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="row">
						<div class="col-xs-12">
						
						<!-- 检索  -->
						<form action="case/listCases.do" method="post" name="userForm" id="userForm">
						<table style="margin-top:5px;">
							<tr>
								<td>
									<div class="nav-search">
									<span class="input-icon">
										<input class="nav-search-input" autocomplete="off" id="nav-search-input" type="text" name="keywords" value="${pd.keywords }" placeholder="这里输入关键词" />
										<i class="ace-icon fa fa-search nav-search-icon"></i>
									</span>
									</div>
								</td>
								<td style="vertical-align:top;padding-left:2px;">
								 	<select class="chosen-select form-control" name="USERNAME" id="username_search" data-placeholder="请选择所属用户" style="vertical-align:top;width: 120px;">
									<option value=""></option>
									<option value="">全部</option>
									<c:forEach items="${listuser}" var="role">
										<option value="${role.USERNAME }" <c:if test="${pd.USERNAME==role.USERNAME}">selected</c:if>>${role.NAME }</option>
									</c:forEach>
								  	</select>
								</td>
								<td style="vertical-align:top;padding-left:2px;"><a class="btn btn-light btn-xs" onclick="searchs();"  title="检索"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a></td>
								
							</tr>
						</table>
						<!-- 检索  -->
					
						<table id="simple-table" class="table table-striped table-bordered table-hover"  style="margin-top:5px;">
							<thead>
								<tr>
									<!--  <th class="center" style="width:35px;">
									<label class="pos-rel"><input type="checkbox" class="ace" id="zcheckbox" /><span class="lbl"></span></label>
									</th>-->
									<th class="center" style="width:50px;">序号</th>
									<th class="center">实例编码</th>
									<th class="center">实例名称</th>
									<th class="center">状态</th>
									<th class="center">描述</th>
									<th class="center">归属账号</th>
									<th class="center"><i class="ace-icon fa fa-envelope-o"></i>创建人</th>
									<th class="center"><i class="ace-icon fa fa-clock-o bigger-110 hidden-480"></i>创建时间</th>
									
									<th class="center">操作</th>
								</tr>
							</thead>
													
							<tbody>
								
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty listcase}">
									<c:forEach items="${listcase}" var="caseBean" varStatus="vs">
										
										<tr>
											
											<td class='center' style="width: 30px;">${vs.index+1}</td>
											<td class="center">${caseBean.case_code }</td>
											<td class="center">${caseBean.case_name }</td>
											<td class="center" style="color:red">
												<c:if test="${caseBean.state== 1 }">
													启动
												</c:if>
												<c:if test="${caseBean.state!= 1 }">
													停止
												</c:if>
											</td>
											<td class="center">${caseBean.cont }</td>
											<td class="center">${caseBean.NAME }</td>
											<td class="center">${caseBean.czman }</td>
											
											<td class="center">${caseBean.czdate}</td>
											<td class="center">
												
												<div class="hidden-sm hidden-xs btn-group">
													
													
													<%
														if(jurisdiction.hasQx("2102")){
													%>
														<a class="btn btn-xs btn-success" title="编辑" onclick="editUser('${caseBean.id}');">
															<i class="ace-icon fa fa-pencil-square-o bigger-120" title="编辑"></i>
														</a>
													<%
														}
													%>
													<%
														if(jurisdiction.hasQx("2103")){
													%>
														<a class="btn btn-xs btn-danger" onclick="delUser('${caseBean.id }','${caseBean.username }');">
															<i class="ace-icon fa fa-trash-o bigger-120" title="删除"></i>
														</a>
													<%
														}
													%>
												</div>
												<div class="hidden-md hidden-lg">
													<div class="inline pos-rel">
														<button class="btn btn-minier btn-primary dropdown-toggle" data-toggle="dropdown" data-position="auto">
															<i class="ace-icon fa fa-cog icon-only bigger-110"></i>
														</button>
														<ul class="dropdown-menu dropdown-only-icon dropdown-yellow dropdown-menu-right dropdown-caret dropdown-close">
															
															<%
																if(jurisdiction.hasQx("2102")){
															%>
																<li>
																	<a style="cursor:pointer;" onclick="editUser('${caseBean.ID}');" class="tooltip-success" data-rel="tooltip" title="修改">
																		<span class="green">
																			<i class="ace-icon fa fa-pencil-square-o bigger-120"></i>
																		</span>
																	</a>
																</li>
															<%
																}
															%>
															<c:if test="${QX.del == 1 }">
															<li>
																<a style="cursor:pointer;" onclick="delUser('${caseBean.ID }','${caseBean.USERNAME }');" class="tooltip-error" data-rel="tooltip" title="删除">
																	<span class="red">
																		<i class="ace-icon fa fa-trash-o bigger-120"></i>
																	</span>
																</a>
															</li>
															</c:if>
														</ul>
													</div>
												</div>
											</td>
										</tr>
									
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr class="main_info">
										<td colspan="10" class="center">没有相关数据</td>
									</tr>
								</c:otherwise>
							</c:choose>
							</tbody>
						</table>
						
					<div class="page-header position-relative">
					<table style="width:100%;">
						<tr>
							<td style="vertical-align:top;">
								<%
									if(jurisdiction.hasQx("2101")){
								%>
									<a class="btn btn-mini btn-success" onclick="add();">新增</a>
								<%
									}
								%>
								
							</td>
							<td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
						</tr>
					</table>
					</div>
					</form>
	
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
	<!-- 删除时确认窗口 -->
	<%@ include file="../index/foot.jsp"%>
	<!-- 删除时确认窗口 -->
	<script src="static/ace/js/bootbox.js"></script>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	</body>

<script type="text/javascript">
//$(top.hangge());

//检索
function searchs(){
	//top.jzts();
	//alert($("#lastLoginStart").val());
	$("#userForm").submit();
}

//删除
function delUser(id,msg){
	if(confirm("确定要删除吗?")) {
		
		var url = "<%=basePath%>case/deletecase.do?ID="+id+"&tm="+new Date().getTime();
		$.get(url,function(data){
			nextPage(${page.currentPage-1});
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
          url: '<%=basePath%>case/tocaseAdd.do?action=1'
          /*, hideFunc:function(){
              modals.info("hide me");
          },
          showFunc:function(){
              modals.info("show me");
          } */
      });
	
}

//修改
function editUser(id){
	// top.jzts();
	var winId = "userWin";
	  modals.openWin({
          winId: winId,
          title: '修改',
          width: '900px',
          url: '<%=basePath%>case/tocaseAdd.do?action=2&ID='+id
       
      });
	
}



//修改
function set(id){
	// top.jzts();
	var winId = "userWin";
	  modals.openWin({
        winId: winId,
        title: '实例设置',
        width: '900px',
        height:'400px',
        url: '<%=basePath%>case/tocaseSet.do?action=2&ID='+id
     
    });
	
}


//批量操作
function makeAll(msg){
	bootbox.confirm("确定要删除["+msg+"]吗?", function(result) {
			if(result) {
			var str = '';
			var emstr = '';
			var phones = '';
			var username = '';
			for(var i=0;i < document.getElementsByName('ids').length;i++)
			{
				  if(document.getElementsByName('ids')[i].checked){
				  	if(str=='') str += document.getElementsByName('ids')[i].value;
				  	else str += ',' + document.getElementsByName('ids')[i].value;
				  	
				  	if(emstr=='') emstr += document.getElementsByName('ids')[i].id;
				  	else emstr += ';' + document.getElementsByName('ids')[i].id;
				  	
				  	if(phones=='') phones += document.getElementsByName('ids')[i].alt;
				  	else phones += ';' + document.getElementsByName('ids')[i].alt;
				  	
				  	if(username=='') username += document.getElementsByName('ids')[i].title;
				  	else username += ';' + document.getElementsByName('ids')[i].title;
				  }
			}
			if(str==''){
				alert("您没有选择任何内容!");
				$("#zcheckbox").tips({
					side:3,
		            msg:'点这里全选',
		            bg:'#AE81FF',
		            time:8
		        });
				return;
			}else{
				if(msg == '确定要删除选中的数据吗?'){
					
					$.ajax({
						type: "POST",
						url: '<%=basePath%>case/deletecase.do?tm='+new Date().getTime(),
				    	data: {USER_IDS:str},
						dataType:'json',
						//beforeSend: validateData,
						cache: false,
						success: function(data){
							 $.each(data.list, function(i, list){
									nextPage(${page.currentPage});
							 });
						}
					});
				}
			}
		}
	});		
}

$(function() {
	//日期框
	$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
	
	//下拉框
	if(!ace.vars['touch']) {
		$('.chosen-select').chosen({allow_single_deselect:true}); 
		$(window)
		.off('resize.chosen')
		.on('resize.chosen', function() {
			$('.chosen-select').each(function() {
				 var $this = $(this);
				 $this.next().css({'width': $this.parent().width()});
			});
		}).trigger('resize.chosen');
		$(document).on('settings.ace.chosen', function(e, event_name, event_val) {
			if(event_name != 'sidebar_collapsed') return;
			$('.chosen-select').each(function() {
				 var $this = $(this);
				 $this.next().css({'width': $this.parent().width()});
			});
		});
		$('#chosen-multiple-style .btn').on('click', function(e){
			var target = $(this).find('input[type=radio]');
			var which = parseInt(target.val());
			if(which == 2) $('#form-field-select-4').addClass('tag-input-style');
			 else $('#form-field-select-4').removeClass('tag-input-style');
		});
	}

	
	//复选框全选控制
	var active_class = 'active';
	$('#simple-table > thead > tr > th input[type=checkbox]').eq(0).on('click', function(){
		var th_checked = this.checked;//checkbox inside "TH" table header
		$(this).closest('table').find('tbody > tr').each(function(){
			var row = this;
			if(th_checked) $(row).addClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', true);
			else $(row).removeClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', false);
		});
	});
});

		
</script>
</html>
