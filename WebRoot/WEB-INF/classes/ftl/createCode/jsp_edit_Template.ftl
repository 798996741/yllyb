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
	<!-- 日期框 -->
	<link rel="stylesheet" href="static/ace/css/datepicker.css" />
</head>
<body class="no-skin">
	<!-- /section:basics/navbar.layout -->
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><li class="fa fa-remove"></li></button>
		<h5 class="modal-title">${TITLE}</h5>
	</div>
	
	<div class="modal-body">
					
					<form action="${objectNameLower}/${r"${msg }"}.do" name="Form_add" id="Form_add" method="post">
						<input type="hidden" name="${objectNameUpper}_ID" id="${objectNameUpper}_ID" value="${r"${pd."}${objectNameUpper}_ID${r"}"}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
				<#list fieldList as var>
					<#if var[3] == "是">
						<#if var[1] == 'Date'>
							<tr>
								<td style="width:110px;text-align: right;padding-top: 13px;">${var[2] }:</td>
								<td><input class="span10 date-picker" name="${var[0] }" id="${var[0] }" value="${r"${pd."}${var[0] }${r"}"}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="${var[2] }" title="${var[2] }" style="width:35%;"/></td>
							</tr>
						<#elseif var[1] == 'Integer'>
							<tr>
								<td style="width:110px;text-align: right;padding-top: 13px;">${var[2] }:</td>
								<td><input type="number" name="${var[0] }" id="${var[0] }" value="${r"${pd."}${var[0] }${r"}"}" maxlength="32" placeholder="这里输入${var[2] }" title="${var[2] }" style="width:35%;"/></td>
							</tr>
						<#elseif var[1] == 'Double'>
							<tr>
								<td style="width:110px;text-align: right;padding-top: 13px;">${var[2] }:</td>
								<td><input type="number" name="${var[0] }" id="${var[0] }" value="${r"${pd."}${var[0] }${r"}"}" maxlength="32" placeholder="这里输入${var[2] }" title="${var[2] }" style="width:35%;"/></td>
							</tr>
						<#else>
							<tr>
								<td style="width:110px;text-align: right;padding-top: 13px;">${var[2] }:</td>
								<td><input type="text" name="${var[0] }" id="${var[0] }" value="${r"${pd."}${var[0] }${r"}"}" maxlength="${var[5] }" placeholder="这里输入${var[2] }" title="${var[2] }" style="width:35%;"/></td>
							</tr>
						</#if>
					</#if>
				</#list>
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


		<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	
		<script type="text/javascript">
		//$(top.hangge());
		//保存
		function save(){
		<#list fieldList as var>
		<#if var[3] == "是">
			if($("#${var[0] }").val()==""){
				$("#${var[0] }").tips({
					side:3,
		            msg:'请输入${var[2] }',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#${var[0] }").focus();
			return false;
			}
		</#if>
		</#list>
			$("#zhongxin").hide();
			$("#zhongxin2").show();
			$.ajax({
            //几个参数需要注意一下
            
            	 type: "POST",//方法类型
                dataType: "html",//预期服务器返回的数据类型
             	 url: "${objectNameLower}/${r"${msg }"}.do" ,//url
                data: $('#Form_add').serialize(),
                success: function (result) {
                  //  console.log(result.);//打印服务端返回的数据(调试用)
                    if (result.indexOf("success")>=0) {
                    	location.href="<%=path%>/${objectNameLower}/list.do";
                    }
                   
                },
                error : function() {
                    alert("异常！");
                }
                
            });
            
            
		}
		
		$(function() {
			//日期框
			//$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
		});
		</script>
</body>
</html>