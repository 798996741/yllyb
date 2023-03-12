<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" 	+ request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
 <%@ include file="../../system/include/incJs_mx.jsp"%>
<style>
.pagination input {
	height: 33px;
}

.pagination select {
	height: 32px;
}
</style>
</head>
<body class="no-skin">


	<!-- Content Wrapper. Contains page content -->
	<div class="content-wrapper" style="width:100%;margin-left:0px;">
		<!-- Content Header (Page header) -->
		<section class="content-header">
			<h1>
				系统管理 <small>实例管理管理</small>
			</h1>
			<ol class="breadcrumb">
				<li><a href="javascript:;" onclick="home()"> <i
						class="fa fa-dashboard"></i> 主页
				</a></li>
				<li class="active">实例管理</li>
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
										<th class="center">
											<i class="ace-icon fa fa-clock-o bigger-110 hidden-480"></i>创建时间</th>

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


															<c:if test="${QX.edit == 1 }">
																<a class="btn btn-xs btn-success" title="编辑"
																	onclick="editUser('${caseBean.id}');"> <i
																	class="ace-icon fa fa-pencil-square-o bigger-120"
																	title="编辑"></i>
																</a>
															</c:if>
															<c:if test="${QX.del == 1 }">
																<a class="btn btn-xs btn-danger" style="margin-left:10px;"
																	onclick="delUser('${caseBean.id }','${caseBean.username }');">
																	<i class="ace-icon fa fa-trash-o bigger-120" title="删除"></i>
																</a>
															</c:if>
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
		//$(top.hangge());//关闭加载状态
		//检索
		function tosearch(){
			//top.jzts();
			$("#Form").submit();
		}
		
		//删除
		function delUser(id,msg){
			if(confirm("确定要删除吗?")) {
				
				var url = "<%=basePath%>case/deletecase.do?ID="+id+"&tm="+new Date().getTime();
				$.get(url,function(data){
					location.href="<%=path%>/case/listCases.do";
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
	<script>
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
</script>

</body>
</html>