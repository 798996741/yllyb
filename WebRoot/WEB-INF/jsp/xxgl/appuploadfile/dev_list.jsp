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
<%@ include file="../../system/include/incJs_mx.jsp"%>
 <link rel="stylesheet" href="static/js/layer/theme/layer.css?t=1568076536509" media="all">
<script src="static/js/layer/layer.js?t=1568076536509"></script>
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
				录音管理<small>账户管理</small>
			</h1>
			<ol class="breadcrumb">
				<li><a href="javascript:;" onclick="home()"> <i
						class="fa fa-dashboard"></i> 主页
				</a></li>
				<li class="active">账户管理</li>
			</ol>
		</section> 
		
		<section class="content">
			<div class="row">
				<div class="col-xs-12">
					<div class="box">
						 <div class="box-header">
			              	
			            </div>
						<div class="box-header" style="height:30px;">
							<form action="appUploadFile/dev_list.do" method="post" name="Form" id="Form_user">
							
								<table  style="margin-top:5px;width:100%">
									<tr>
										<td style="padding-left:15px;width:20%;">
											用户名：<input type="text"  class="nav-search-input" id="nav-search-input" autocomplete="off" name="uname" value="${pd.uname }"  style="width:120px;height:30px"/>
										</td>
										<td  style="padding-left:15px;width:20%;">
											手机号码：<input type="text"   class="nav-search-input" id="nav-search-input" autocomplete="off" name="tel" value="${pd.tel }"  style="width:120px;height:30px"/>
										</td>
										
										<td style="vertical-align:middle;padding-left:12px">
											<a class="btn btn-mini btn-primary" onclick="tosearch();"  title="检索">
												查询
											</a>
											<c:if test="${QX.add == 1 }">
												<a class="btn btn-mini btn-primary" onclick="add();">新增</a>
											</c:if>		
										</td>
									</tr>
								</table>
							</form>
						</div>
						<div class="box-body" style="margin-top:50px">

							<table id="example_user"
								class="table table-striped table-bordered table-hover"
								style="margin-top:5px;">
								<thead>
									<tr>
										<th style="width:40px;min-width:40px;padding-left:10px"><a href="javascript:void(0)" onClick="checkl()" style="color:#2893fd" class=" l-btn-plain">全选<br/>反选</a></th>
										
										<th class="center">用户名</th>
										<th class="center">用户姓名</th>
										<th class="center">手机号码</th>
										<th class="center">设备号</th>
										<th class="center">有效期</th>
										<th class="center">是否绑定设备</th>
										<th class="center">绑定人</th>
										<th class="center">绑定时间</th>
										<th class="center">操作</th>
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
														<td class='center'>${var.devid}</td>
														<td class='center'>${var.yxdate}</td>
														<td class='center'>
															<c:if test="${var.isbind == 1 }">
																已绑定
															</c:if>
															<c:if test="${var.isbind != 1 }">
																未绑定
															</c:if>
														</td>
														<td class='center'>${var.bindman}</td>
														<td class='center'>${var.binddate}</td>
														<td class="center">
															<c:if test="${QX.del == 1 }">	
																<c:if test="${var.isbind == 1 }">
																
																	<a class="btn btn-xs btn-primary" title="解除绑定"
																		onclick="bind('${var.uid}','0','${var.devid}');"> <i
																		class="ace-icon fa fa-minus-circle bigger-120"
																		title="解除绑定"></i>
																	</a> 
																</c:if>
																<c:if test="${var.isbind != 1 }">
																	<a class="btn btn-xs btn-primary" title="绑定设备"
																		onclick="bind('${var.uid}','1','${var.devid}');"> <i
																		class="ace-icon fa fa-plus-circle bigger-120"
																		title="绑定设备"></i>
																	</a> 
																</c:if>
															</c:if>
															<c:if test="${QX.edit == 1 }">
																<a class="btn btn-xs btn-success" title="修改"
																	onclick="edit('${var.uid}');"> <i
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
			
			 $('#example_user').DataTable({
				'paging'      : true,
			      'lengthChange': false,
			      'searching'   : false,
			      'ordering'    : false,
			      'info'        : true,
			      'autoWidth'   : true
		    })
		});
		
		
		
		//修改
		var index;
		function edit(uid){
			
			index=layer.open({
		  	  type: 2,
		  	  title: "账户修改",
		  	  closeBtn: 1, //不显示关闭按钮
		  	  shade: [0],
		  	  area: ['640px', '450px'],
		  	  btnAlign: 'c' ,
		  	  content: ["<%=basePath%>appUploadFile/goEditDev.do?uid="+uid+"", 'no']
		  	});
		}
		
		function layclose(){
			layer.close(index);
		}
		
		
		function add(){
			
			index=layer.open({
		  	  type: 2,
		  	  title: "账户添加",
		  	  closeBtn: 1, //不显示关闭按钮
		  	  shade: [0],
		  	  area: ['640px', '450px'],
		  	  btnAlign: 'c' ,
		  	  content: ["<%=basePath%>appUploadFile/goAddDev.do", 'no']
		  	});
		}
		//删除
		function bind(uid,isbind,devid){
			var str="";
			if(isbind=='0'){
				str="解除绑定设备";
			}else{
				//alert(devid);
				if(devid==""){
					layer.open({
					  	type: 1,
					  	closeBtn: 1, //不显示关闭按钮
					  	shade: [0],
					  	area: ['240px', '100px'],
					  	title: "提醒",
					  	content:"<div style=\"text-align:center;padding-top:10px;color:blue;\">设备为空无法绑定！</div>"
					});  
					return fasle;
				}
				str="绑定设备";
			}
			bootbox.confirm("确定要"+str+"吗?", function(result) {
				if(result) {
					top.jzts();
					var url = "<%=basePath%>appUploadFile/binddev.do?uid="+uid+"&isbind="+isbind+"&tm="+new Date().getTime();
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