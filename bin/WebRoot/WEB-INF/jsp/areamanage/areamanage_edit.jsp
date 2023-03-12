<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
	<base href="<%=basePath%>">
	<!-- 下拉框 -->
	<link rel="stylesheet" href="static/ace/css/chosen.css" />
	<!-- 日期框 -->
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
					
					<form action="areamanage/${msg }.do" name="Form_add" id="Form_add" method="post">
						<input type="hidden" name="AREA_ID" id="AREA_ID" value="${pd.AREA_ID}"/>
						<input type="hidden" name="PARENT_ID" id="PARENT_ID" value="${null == pd.PARENT_ID ? AREA_ID:pd.PARENT_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:120px;text-align: right;padding-top: 13px;">上级:</td>
								<td>
									<div>
										<b>${null == pds.NAME ?'(无) 此为顶级':pds.NAME}</b>
									</div>
								</td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">名称:</td>
								<td><input type="text" name="NAME" id="NAME" value="${pd.NAME}"  placeholder="这里输入名称" title="名称" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">地区编码:</td>
								<td><input type="text" name="AREA_CODE" id="AREA_CODE" value="${pd.AREA_CODE}" maxlength="40" placeholder="这里输入地区编码" title="地区编码" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">地区级别:</td>
								<td><input type="text" name="AREA_LEVEL" id="AREA_LEVEL" value="${pd.AREA_LEVEL}" maxlength="2" placeholder="这里输入地区级别" title="地区级别" style="width:98%;" readonly="readonly"/></td>
							</tr>
							<tr>
								<td style="text-align: center;" colspan="10">
									<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
									<a class="btn btn-mini btn-danger"  data-btn-type="cancel" data-dismiss="modal">取消</a>
								</td>
							</tr>
						</table>
						</div>
						<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
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
</div>
<!-- /.main-container -->


	<!-- 页面底部js¨ -->
	<%@ include file="../system/index/foot.jsp"%>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		<script type="text/javascript">
		//$(top.hangge());
		//保存
		function save(){
			if($("#NAME").val()==""){
				$("#NAME").tips({
					side:3,
		            msg:'请输入名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#NAME").focus();
				return false;
			}
			if($("#AREA_CODE").val()==""){
				$("#AREA_CODE").tips({
					side:3,
		            msg:'请输入地区编码',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#AREA_CODE").focus();
			return false;
			}
			if($("#AREA_LEVEL").val()==""){
				$("#AREA_LEVEL").tips({
					side:3,
		            msg:'请输入地区级别',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#AREA_LEVEL").focus();
			return false;
			}
			var formData = $('#Form_add').serialize();
			formData += "&action=" + '${msg}';
			$.ajax({
	            //几个参数需要注意一下
                type: "POST",//方法类型
                dataType: "json",//预期服务器返回的数据类型
                async: false,
                url: "<%=basePath%>areamanage/checkCode.do" ,//url
                data: formData,
                success: function (data) {
					console.log(data);//打印服务端返回的数据(调试用)
					if(data.success){
						$("#zhongxin").hide();
						$("#zhongxin2").show();
						$.ajax({
				            //几个参数需要注意一下
			                type: "POST",//方法类型
			                dataType: "html",//预期服务器返回的数据类型
			                url: "areamanage/${msg}.do" ,//url
			                data: $('#Form_add').serialize(),
			                success: function (result) {
			                  //  console.log(result.);//打印服务端返回的数据(调试用)
			                    if (result.indexOf("success")>=0) {
			                    	parent.location.href="<%=basePath%>areamanage/listTree.do?AREA_ID=${AREA_ID}";
			                    }
			                },
			                error : function() {
			                    alert("异常！");
			                }
			            });
					}else{
						$("#AREA_CODE").tips({
	    					side:3,
	    		            msg:'你输入的编号已存在,请重新输入',
	    		            bg:'#AE81FF',
	    		            time:2
	    		        });
	    				$("#AREA_CODE").focus();
					}
                },
                error : function() {
                    alert("异常！");
                }
            });
		}
		
		$(function() {
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
		});
		</script>
</body>
</html>