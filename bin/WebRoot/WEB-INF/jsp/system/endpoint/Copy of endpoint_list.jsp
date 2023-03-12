<%@ page language="java" contentType="text/html; charset=UTF-8"
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
						<form action="endpoint/listEndpoints.do" method="post" name="userForm" id="userForm">
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
								 	<select class="chosen-select form-control" name="CASEID_SEARCH" id="CASEID_SEARCH" data-placeholder="请选择所属实例" style="vertical-align:top;width: 120px;">
									<option value=""></option>
									<option value="">全部</option>
									<c:forEach items="${listcase_s}" var="caseBean" varStatus="vs">
										<option value="${caseBean.id }" <c:if test="${pd.CASEID==caseBean.id}">selected</c:if>>${caseBean.case_name }</option>
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
									<th class="center">设备编码</th>
									<th class="center">设备名称</th>
									<th class="center">接口协议</th>
									<th class="center">用户名</th>
									<th class="center">密钥</th>
									<th class="center">主题</th>
									<th class="center">所属实例</th>
									<th class="center">备注</th>
									<th class="center"><i class="ace-icon fa fa-envelope-o"></i>创建人</th>
									<th class="center"><i class="ace-icon fa fa-clock-o bigger-110 hidden-480"></i>创建时间</th>
									
									<th class="center">操作</th>
								</tr>
							</thead>
													
							<tbody>
								
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty listendpoint}">
									<c:forEach items="${listendpoint}" var="endpoint" varStatus="vs">
										
										<tr>
											<td class='center' style="width: 30px;">${vs.index+1}</td>
											<td class="center">${endpoint.endpoint_id }</td>
											<td class="center">${endpoint.endpoint_name }</td>
											<td class="center">${endpoint.NAME }</td>
											<td class="center">${endpoint.yhm }</td>
											<td class="center">${endpoint.yhpwd }</td>
											<td class="center">${endpoint.theme}</td>
											<td class="center">${endpoint.CASE_NAME }</td>
											<td class="center">${endpoint.remark}</td>
											<td class="center">${endpoint.czman}</td>
											<td class="center">${endpoint.createdate}</td>
											<td class="center">
												
												<div class="hidden-sm hidden-xs btn-group">
													
													<%
														if(jurisdiction.hasQx("2202")){
													%>
														<a class="btn btn-xs btn-success" title="编辑" onclick="editUser('${endpoint.id}');">
															<i class="ace-icon fa fa-pencil-square-o bigger-120" title="编辑"></i>
														</a>
													<%
														}
													%>
													<%
														if(jurisdiction.hasQx("2203")){
													%>
														<a class="btn btn-xs btn-danger" onclick="delUser('${endpoint.id }','${endpoint.username }');">
															<i class="ace-icon fa fa-trash-o bigger-120" title="删除"></i>
														</a>
													<%
														}
													%>
												</div>
												
											</td>
										</tr>
									
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr class="main_info">
										<td colspan="12" class="center">没有相关数据</td>
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
									if(jurisdiction.hasQx("2201")){
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
	alert(id);
	if(confirm("确定要删除吗?")) {
		
		var url = "<%=basePath%>endpoint/deleteendpoint.do?ID="+id+"&tm="+new Date().getTime();
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
          url: '<%=basePath%>endpoint/toendpointAdd.do?action=1'
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
	//alert(id);
	var winId = "userWin";
	  modals.openWin({
          winId: winId,
          title: '修改',
          width: '900px',
          url: '<%=basePath%>endpoint/toendpointAdd.do?action=2&ID='+id
       
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
						url: '<%=basePath%>endpoint/deleteendpoint.do?tm='+new Date().getTime(),
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
