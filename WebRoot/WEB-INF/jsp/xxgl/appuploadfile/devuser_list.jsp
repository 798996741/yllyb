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
<!-- 日期框 -->
<link rel="stylesheet" href="static/ace/css/datepicker.css" />
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
		<!-- <section class="content-header">
			<h1>
				录音管理<small>账户管理</small>
			</h1>
			<ol class="breadcrumb">
				<li><a href="javascript:;" onclick="home()"> <i
						class="fa fa-dashboard"></i> 主页
				</a></li>
				<li class="active">账户管理</li>
			</ol>
		</section> -->
		<div class="modal-header">
			<h4 class="modal-title" id="myModalLabel" style="float: left;">
			</h4>
			<div class="new-tb" style="float: right;" data-dismiss="modal"
				title="关闭"></div>
		</div>
		<section class="content">
			<div class="row">
				<div class="col-xs-12">
					<div class="box">
						<div class="box-header" style="height:30px;">
							<%-- <form action="appUploadFile/devuser_list.do" method="post" name="Form" id="Form_user">
							
								<table  style="margin-top:5px;width:100%">
									<tr>
										<td style="padding-left:15px;width:20%;">
											用户名：<input type="text"  class="nav-search-input" id="nav-search-input" autocomplete="off" name="uname" value="${pd.uname }"  style="width:120px;height:30px"/>
										</td>
										<td  style="padding-left:15px;width:20%;">
											手机号码：<input type="text"   class="nav-search-input" id="nav-search-input" autocomplete="off" name="callNumber" value="${pd.callNumber }"  style="width:120px;height:30px"/>
										</td>
										
										<td style="vertical-align:middle;padding-left:2px"><a class="btn btn-light btn-xs" onclick="tosearch();"  title="检索"><i class="ace-icon fa fa-search nav-search-icon"></i></a></td>
									</tr>
								</table>
							</form> --%>
						</div>
						<div class="box-body" >

							<table id="example_user"
								class="table table-striped table-bordered table-hover"
								style="margin-top:5px;">
								<thead>
									<tr>
										<th style="width:40px;min-width:40px;padding-left:10px"><a href="javascript:void(0)" onClick="checkl()" style="color:#2893fd" class=" l-btn-plain">全选<br/>反选</a></th>
										
										<th class="center">用户名</th>
										<th class="center">用户姓名</th>
										<th class="center">手机号码</th>
										<th class="center">操作人</th>
										<th class="center">操作时间</th>
										
										<!-- <th class="center">操作</th> -->
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
														<td class='center'>${var.ucode}</td>
														<td class='center'>${var.uname}</td>
														<td class='center'>${var.tel}</td>
														
														<td class='center'>${var.czman}</td>
														<td class='center'>${var.czdate}</td>
														<%-- <td class="center">
																
														
															<a class="btn btn-xs btn-success" title="播放"
																onclick="edit('${var.id}','${var.uploadfile}');"> <i
																class="ace-icon fa fa-pencil-square-o bigger-120"
																title="播放"></i>
															</a> 
														</td> --%>
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
							<table style="width:100%">
								<tr style="width:100%;text-align: center;">
									<td style="text-align: center;" colspan="5"><a
										class="btn btn-mini btn-primary" onclick="saveusers();">保存</a> <a
										class="btn btn-mini btn-danger" id="gbck" data-btn-type="cancel"
										data-dismiss="modal">取消</a></td>
								</tr>
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

	<!-- /.main-container -->


	<script type="text/javascript">
		//$(top.hangge());//关闭加载状态
		//检索
		function tosearch(){
			//top.jzts();
			$("#Form_user").submit();
		}
		
		function saveusers(){
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
		    	//alert("请选择要下载的人员信息！");
		    	//return false;
		    }
		    document.getElementById("DEVUSERS").value=ids;
		    
		    document.getElementById("userstr").innerHTML=ids;
		    
		    $("#choiceuserWin").trigger("click");
		   	//$("#choiceuserWin").modal('toggle');
		    //alert(ids);
		}
		
		function checkl(){
			$("input[name='check']").each(function(){
				//$(this).attr("checked",!$(this).attr("checked"));
				this.checked=!this.checked;//用的是Dom的属性
			});
			
		}
		$(function() {
			//日期框
			
			/* $('#example_user').DataTable({
				'paging'      : true,
			      'lengthChange': false,
			      'searching'   : false,
			      'ordering'    : false,
			      'info'        : true,
			      'autoWidth'   : true
		    }) */
		});
		
		
		
		//修改
		function edit(id,uploadfile){
			
			var winId = "userWin";
		  	modals.openWin({
	          	winId: winId,
	          	title: '录音播放',
	          	width: '450px',
	          	height: '280px',
	          	url: '<%=basePath%>appUploadFile/goEdit.do?ID='+id
	      	});
			
		}
		
		
		//导出excel
		function toExcel(){
			window.location.href='<%=basePath%>coupon/excel.do';
		}
	</script>
</body>
</html>