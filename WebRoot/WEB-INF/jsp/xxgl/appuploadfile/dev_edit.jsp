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
						<form action="appUploadFile/${msg }.do" name="userForm" id="userForm_add"
							method="post">
							<input type="hidden" name="uid" id="uid" value="${pd.uid }" />
							<div id="zhongxin" style="padding-top: 20px;">
								<table id="table_report"
									class="table table-striped table-bordered table-hover">
									
									<tr>
										<td style="width:160px;text-align: right;padding-top: 13px;">用户名:</td>
										<td><input type="text" name="ucode" id="ucode"
											value="${pd.ucode }" maxlength="32" placeholder="这里输入用户名"
											title="用户名" style="width:60%;" /></td>
									</tr>
									<tr>
										<td style="width:160px;text-align: right;padding-top: 13px;">姓名:</td>
										<td><input type="text" name="uname" id="uname"
											value="${pd.uname }" maxlength="32" placeholder="这里输入姓名"
											title="姓名" style="width:60%;" /></td>
									</tr>
									
									<tr>
										<td style="width:160px;text-align: right;padding-top: 13px;">密码:</td>
										<td><input type="password" name="upwd" id="upwd"
											maxlength="32" placeholder="输入密码" title="密码"
											style="width:60%;" /></td>
									</tr>
									<tr>
										<td style="width:160px;text-align: right;padding-top: 13px;">确认密码:</td>
										<td><input type="password" name="chkpwd" id="chkpwd"
											maxlength="32" placeholder="确认密码" title="确认密码"
											style="width:60%;" /></td>
									</tr>
									
									<tr>
										<td style="width:160px;text-align: right;padding-top: 13px;">手机号:</td>
										<td><input type="NUMBER" name="tel" id="tel"
											value="${pd.tel }" maxlength="32" placeholder="这里输入手机号"
											title="手机号" style="width:60%;" /></td>
									</tr>
									<tr>
										<td style="width:160px;text-align: right;padding-top: 13px;">设备号:</td>
										<td><input type="text" name="devid" id="devid"
											value="${pd.devid }" maxlength="32" placeholder="这里输入设备号"
											title="设备号"
											style="width:60%;" /></td>
									</tr>
									<tr>
										<td style="width:160px;text-align: right;padding-top: 13px;">有效期:</td>
										<td><input type="text" name="yxdate" id="yxdate"
											value="${pd.yxdate }" maxlength="32" placeholder="这里输入有效期"
											title="有效期" class="span10 date-picker" data-date-format="yyyy-mm-dd" 
											style="width:60%;" /></td>
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
		//alert($("#role_id1").val());
		
		if($("#ucode").val()=="" || $("#ucode").val()=="此用户名已存在!"){
			$("#ucode").tips({
				side:3,
	            msg:'输入用户名',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#ucode").focus();
			$("#ucode").val('');
			$("#ucode").css("background-color","white");
			return false;
		}else{
			$("#ucode").val(jQuery.trim($('#ucode').val()));
		}
		
		if($("#uid").val()=="" && $("#upwd").val()==""){
			$("#upwd").tips({
				side:3,
	            msg:'输入密码',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#upwd").focus();
			return false;
		}
		if($("#upwd").val()!=$("#chkpwd").val()){
			
			$("#chkpwd").tips({
				side:3,
	            msg:'两次密码不相同',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#chkpwd").focus();
			return false;
		}
		if($("#uname").val()==""){
			$("#uname").tips({
				side:3,
	            msg:'输入姓名',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#uname").focus();
			return false;
		}
		var myreg = /^(((13[0-9]{1})|159)+\d{8})$/;
		if($("#tel").val()!=""&&$("#tel").val().length != 11 && !myreg.test($("#tel").val())){
			$("#tel").tips({
				side:3,
	            msg:'手机号格式不正确',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#tel").focus();
			return false;
		}
		
		if($("#uid").val()==""){
			hasU();
		}else{
			$.ajax({
	            //几个参数需要注意一下
                type: "POST",//方法类型
                dataType: "html",//预期服务器返回的数据类型
                url: "appUploadFile/${msg }.do" ,//url
                data: $('#userForm_add').serialize(),
                success: function (result) {
                  // alert(result);//打印服务端返回的数据(调试用)
                    if (result.indexOf("success")>=0) {
                    	layer.open({
    					  	type: 1,
    					  	closeBtn: 1, //不显示关闭按钮
    					  	shade: [0],
    					  	area: ['240px', '100px'],
    					  	title: "提示",
    					  	content:"<div style=\"text-align:center;padding-top:10px;color:blue;\">保存成功</div>"
    					});  
                    	$('#userForm_add').reset();
                    }
                   
                },
                error : function() {
                    alert("异常！");
                }
            });
			
			///$("#userForm_add").submit();
			//$("#zhongxin").hide();
			//$("#zhongxin2").show();
		}
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
