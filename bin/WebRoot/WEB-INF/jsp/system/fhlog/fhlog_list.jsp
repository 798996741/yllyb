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
	 .pagination input{
	 	height:33px;
	 }
	 .pagination select{
	 	height:32px;
	 }
	</style>
</head>
<body class="no-skin">


<!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper" style="width:100%;margin-left:0px;">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        	系统管理
        <small>日志管理</small>
      </h1>
      <ol class="breadcrumb">
        <li>
			<a href="javascript:;" onclick="home()">
				<i class="fa fa-dashboard"></i> 主页
			</a>
		</li>
		<li class="active">日志管理</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content">
      <div class="row">
        <div class="col-xs-12">
          <div class="box">
            
            <!-- /.box-header -->
            <div class="box-body">
              <table id="example2" class="table table-bordered table-hover">
                <thead>
                <tr>
                  	<!-- <th class="center" style="width:35px;">
					<label class="pos-rel"><input type="checkbox" class="ace" id="zcheckbox" /><span class="lbl"></span></label>
					</th> -->
					<th class="center" style="width:50px;">序号</th>
					<th class="center">用户名</th>
					<th class="center">事件</th>
					<th class="center">操作时间</th>
					<th class="center">操作</th>
                </tr>
                </thead>
                <tbody>
                
                <c:choose>
						<c:when test="${not empty varList}">
							<c:if test="${QX.cha == 1 }">
							<c:forEach items="${varList}" var="var" varStatus="vs">
								<tr>
									
									<td class='center' style="width: 30px;">${vs.index+1}</td>
									<td class='center' style="width: 200px;">${var.USERNAME}</td>
									<td class='center'>${var.CONTENT}</td>
									<td class='center' style="width: 150px;">${var.CZTIME}</td>
									<td class="center" style="width: 50px;">
										<c:if test="${QX.edit != 1 && QX.del != 1 }">
										<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="ace-icon fa fa-lock" title="无权限"></i></span>
										</c:if>
										<div class="hidden-sm hidden-xs btn-group">
											<c:if test="${QX.del == 1 }">
											<a class="btn btn-xs btn-danger" onclick="del('${var.FHLOG_ID}');">
												<i class="ace-icon fa fa-trash-o bigger-120" title="删除"></i>
											</a>
											</c:if>
										</div>
										<div class="hidden-md hidden-lg">
											<div class="inline pos-rel">
												<button class="btn btn-minier btn-primary dropdown-toggle" data-toggle="dropdown" data-position="auto">
													<i class="ace-icon fa fa-cog icon-only bigger-110"></i>
												</button>
	
												<ul class="dropdown-menu dropdown-only-icon dropdown-yellow dropdown-menu-right dropdown-caret dropdown-close">
													<c:if test="${QX.del == 1 }">
													<li>
														<a style="cursor:pointer;" onclick="del('${var.FHLOG_ID}');" class="tooltip-error" data-rel="tooltip" title="删除">
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
							</c:if>
							<c:if test="${QX.cha == 0 }">
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
		$(function() {
		
		
		});
		
		//新增
		function add(){
			var winId = "userWin";
		  	modals.openWin({
	          	winId: winId,
	          	title: '新增',
	          	width: '580px',
	          	height: '355px',
	          	url: '<%=basePath%>tagent/goAdd.do'
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
					top.jzts();
					var url = "<%=basePath%>tagent/delete.do?TAGENT_ID="+Id+"&tm="+new Date().getTime();
					$.get(url,function(data){
						location.href="<%=basePath%>tagent/list.do";
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
	          	width: '580px',
	          	height: '355px',
	          	url: '<%=basePath%>tagent/goEdit.do?TAGENT_ID='+Id
	          	/*, hideFunc:function(){
	             	 modals.info("hide me");
	          	},
	          	showFunc:function(){
	              	modals.info("show me");
	          	} */
	      	});
			
			
		}
		
		//批量操作
		function makeAll(msg){
			bootbox.confirm(msg, function(result) {
				if(result) {
					var str = '';
					for(var i=0;i < document.getElementsByName('ids').length;i++){
					  if(document.getElementsByName('ids')[i].checked){
					  	if(str=='') str += document.getElementsByName('ids')[i].value;
					  	else str += ',' + document.getElementsByName('ids')[i].value;
					  }
					}
					if(str==''){
						bootbox.dialog({
							message: "<span class='bigger-110'>您没有选择任何内容!</span>",
							buttons: 			
							{ "button":{ "label":"确定", "className":"btn-sm btn-success"}}
						});
						$("#zcheckbox").tips({
							side:1,
				            msg:'点这里全选',
				            bg:'#AE81FF',
				            time:8
				        });
						return;
					}else{
						if(msg == '确定要删除选中的数据吗?'){
							top.jzts();
							$.ajax({
								type: "POST",
								url: '<%=basePath%>tagent/deleteAll.do?tm='+new Date().getTime(),
						    	data: {DATA_IDS:str},
								dataType:'json',
								//beforeSend: validateData,
								cache: false,
								success: function(data){
									 $.each(data.list, function(i, list){
											tosearch();
									 });
								}
							});
						}
					}
				}
			});
		};
		
		//导出excel
		function toExcel(){
			window.location.href='<%=basePath%>tagent/excel.do';
		}
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