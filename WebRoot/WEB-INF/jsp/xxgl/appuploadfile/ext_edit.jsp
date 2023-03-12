<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
<link rel="stylesheet" href="static/ace/css/datepicker.css" />
<%@ include file="../../system/include/incJs_mx.jsp"%>
 <link rel="stylesheet" href="static/js/layer/theme/layer.css?t=1568076536509" media="all">
<script src="static/js/layer/layer.js?t=1568076536509"></script>
</head>
<body class="no-skin">

	<div class="main-content">
		<div class="main-content-inner">
			<div class="page-content">
				
				<div class="row">
					<div class="col-xs-12">
						<form action="appUploadFile/${msg}.do" name="userForm" id="userForm_add"
							method="post">
							<input type="hidden" name="ID" id="ID" value="${pd.ID }" />
							<div id="zhongxin" style="padding-top: 20px;">
								<table id="table_report"
									class="table table-striped table-bordered table-hover">
									
									<tr>
										<td style="width:160px;text-align: right;padding-top: 13px;">分机号:</td>
										<td><input type="text" name="ext" id="ext"
											value="${pd.Ext }" maxlength="32" placeholder="这里输入分机号"
											title="分机号" style="width:60%;" /></td>
									</tr>
									<tr>
									<td style="width:79px;text-align: right;padding-top: 13px;">分机类型:</td>

									<td>
										<select name="type" title="分机类型">
											<option value="" <c:if test="${pd.type == '' }">selected</c:if> ></option>
											<option value="0" <c:if test="${pd.type == '0' }">selected</c:if> >IP</option>
											<option value="1" <c:if test="${pd.type == '1' }">selected</c:if> >数字</option>
											<option value="2" <c:if test="${pd.type == '2' }">selected</c:if> >模拟</option>
										</select>
									</td>
									</tr>
									<tr>
										<td style="width:160px;text-align: right;padding-top: 13px;">映射号码:</td>
										<td><input type="text" name="virtual" id="virtual"
												   value="${pd.virtual }" maxlength="32" placeholder="这里输入映射号码"
												   title="映射号码" style="width:60%;" /></td>
									</tr>
									<tr>
										<td style="text-align: center;" colspan="10"><a
											class="btn btn-mini btn-primary" onclick="save();">保存</a> <a
											class="btn btn-mini btn-danger" onclick="parent.layclose();" data-btn-type="cancel"
											data-dismiss="modal">取消</a></td>
									</tr>
								</table>
							</div>

						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script type="text/javascript">
	
	
	$(document).ready(function(){
		
		$('.date-picker').datepicker({
			autoclose: true,
			todayHighlight: true
		});
	});
	//保存
	
	function save(){

		// alert($('#userForm_add').serialize());


			<%--$.ajax({--%>
	        <%--    //几个参数需要注意一下--%>
            <%--    type: "POST",//方法类型--%>
            <%--    dataType: "html",//预期服务器返回的数据类型--%>
            <%--    url: "appUploadFile/${msg}.do" ,//url--%>
            <%--    data: $('#userForm_add').serialize(),--%>
            <%--    success: function (result) {--%>
            <%--      // alert(result);//打印服务端返回的数据(调试用)--%>
			<%--		alert(result);--%>
            <%--        if (result.indexOf("success")>=0) {--%>
            <%--        	// layer.open({--%>
    		<%--			//   	type: 1,--%>
    		<%--			//   	closeBtn: 1, //不显示关闭按钮--%>
    		<%--			//   	shade: [0],--%>
    		<%--			//   	area: ['240px', '100px'],--%>
    		<%--			//   	title: "提示",--%>
    		<%--			//   	content:"<div style=\"text-align:center;padding-top:10px;color:blue;\">保存成功</div>"--%>
    		<%--			// });--%>
            <%--        	// $('#userForm_add').reset();--%>
			<%--			location.href="<%=basePath%>appUploadFile/listext.do";--%>
            <%--        }--%>

            <%--    },--%>
            <%--    error : function() {--%>
            <%--        alert("异常！");--%>
            <%--    }--%>
            <%--});--%>
		$.ajax({
			//几个参数需要注意一下
			type: "POST",//方法类型
			dataType: "html",//预期服务器返回的数据类型
			url: "appUploadFile/${msg }.do" ,//url
			data: $('#userForm_add').serialize(),
			success: function (result) {
				//  console.log(result.);//打印服务端返回的数据(调试用)
					parent.location.href="<%=basePath%>appUploadFile/listext_list.do";
				},
			error : function() {
				alert("异常！");
			}
		});
	}
	function ismail(mail){
		return(new RegExp(/^(?:[a-zA-Z0-9]+[_\-\+\.]?)*[a-zA-Z0-9]+@(?:([a-zA-Z0-9]+[_\-]?)*[a-zA-Z0-9]+\.)+([a-zA-Z]{2,})+$/).test(mail));
		}
	
	//判断用户名是否存在
	function hasU(){
		var ucode = $.trim($("#ucode").val());
		$.ajax({
			type: "POST",
			url: '<%=basePath%>appUploadFile/hasU.do',
	    	data: {ucode:ucode,tm:new Date().getTime()},
			dataType:'json',
			cache: false,
			success: function(data){
				 if("success" == data.result){
					$("#userForm_add").submit();
					//$("#zhongxin").hide();
					//$("#zhongxin2").show();
				 }else{
					$("#ucode").css("background-color","#D16E6C");
					setTimeout("$('#loginname').val('此用户名已存在!')",500);
				 }
			}
		});
	}
	
	//判断邮箱是否存在
	function hasE(USERNAME){
		var EMAIL = $.trim($("#EMAIL").val());
		$.ajax({
			type: "POST",
			url: '<%=basePath%>user/hasE.do',
	    	data: {EMAIL:EMAIL,USERNAME:USERNAME,tm:new Date().getTime()},
			dataType:'json',
			cache: false,
			success: function(data){
				 if("success" != data.result){
					 $("#EMAIL").tips({
							side:3,
				            msg:'邮箱 '+EMAIL+' 已存在',
				            bg:'#AE81FF',
				            time:3
				        });
					 $("#EMAIL").val('');
				 }
			}
		});
	}
	
	//判断编码是否存在
	function hasN(USERNAME){
		var NUM = $.trim($("#NUM").val());
		$.ajax({
			type: "POST",
			url: '<%=basePath%>user/hasN.do',
				data : {
					NUM : NUM,
					USERNAME : USERNAME,
					tm : new Date().getTime()
				},
				dataType : 'json',
				cache : false,
				success : function(data) {
					if ("success" != data.result) {
						$("#NUM").tips({
							side : 3,
							msg : '编号 ' + NUM + ' 已存在',
							bg : '#AE81FF',
							time : 3
						});
						$("#NUM").val('');
					}
				}
			});
		}
		$(function() {
			//下拉框
			
		});
	</script>
</body>
</html>
