<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
<!-- 下拉框 -->
</head>
<body class="no-skin">

	<!-- Horizontal Form -->
	<div class="box box-info">
		<div class="box-header with-border">
			<h3 class="box-title">用户添加</h3>
		</div>
		<!-- /.box-header -->
		<!-- form start -->
		<form action="user/${msg }.do" name="userForm" id="userForm_add"
			method="post">
			<input type="hidden" name="USER_ID" id="user_id" value="${pd.USER_ID }" />
			<div id="zhongxin" style="padding-top: 13px;">
				<table id="table_report" class="table table-striped table-bordered table-hover">
					<c:if test="${fx != 'head'}">
						<tr>
							<td style="width:79px;text-align: right;padding-top: 13px;">角色:</td>
							<td id="juese">
								<select name="ROLE_ID" id="role_id1" data-placeholder="请选择角色" style="width:98%;height:25px">
									<option value=""></option>
									<c:forEach items="${roleList}" var="role">
										<option value="${role.ROLE_ID }"
											<c:if test="${role.ROLE_ID == pd.ROLE_ID }">selected</c:if>>${role.ROLE_NAME }</option>
									</c:forEach>
								</select>
							</td>
						</tr>
					</c:if>
					<c:if test="${fx == 'head'}">
						<input name="ROLE_ID" id="role_id" value="${pd.ROLE_ID }"
							type="hidden" />
					</c:if>
					<tr>
						<td style="width:79px;text-align: right;padding-top: 13px;">用户名:</td>
						<td><input type="text" name="USERNAME" id="loginname"
							value="${pd.USERNAME }" maxlength="32" placeholder="这里输入用户名"
							title="用户名" style="width:98%;" /></td>
					</tr>
					<tr>
						<td style="width:79px;text-align: right;padding-top: 13px;">编号:</td>
						<td><input type="text" name="NUM" id="NUM" value="${pd.NUM }"
							maxlength="32" placeholder="这里输入编号" title="编号"
							onblur="hasN('${pd.USERNAME }')" style="width:98%;" /></td>
					</tr>
					<tr>
						<td style="width:79px;text-align: right;padding-top: 13px;">密码:</td>
						<td><input type="password" name="PASSWORD" id="password"
							maxlength="32" placeholder="输入密码" title="密码" style="width:98%;" /></td>
					</tr>
					<tr>
						<td style="width:79px;text-align: right;padding-top: 13px;">确认密码:</td>
						<td><input type="password" name="chkpwd" id="chkpwd"
							maxlength="32" placeholder="确认密码" title="确认密码" style="width:98%;" /></td>
					</tr>
					<tr>
						<td style="width:79px;text-align: right;padding-top: 13px;">姓名:</td>
						<td><input type="text" name="NAME" id="name"
							value="${pd.NAME }" maxlength="32" placeholder="这里输入姓名"
							title="姓名" style="width:98%;" /></td>
					</tr>
					<tr>
						<td style="width:79px;text-align: right;padding-top: 13px;">手机号:</td>
						<td><input type="NUMBER" name="PHONE" id="PHONE"
							value="${pd.PHONE }" maxlength="32" placeholder="这里输入手机号"
							title="手机号" style="width:98%;" /></td>
					</tr>
					<tr>
						<td style="width:79px;text-align: right;padding-top: 13px;">邮箱:</td>
						<td><input type="email" name="EMAIL" id="EMAIL"
							value="${pd.EMAIL }" maxlength="32" placeholder="这里输入邮箱"
							title="邮箱" onblur="hasE('${pd.USERNAME }')" style="width:98%;" /></td>
					</tr>
					<tr>
						<td style="width:79px;text-align: right;padding-top: 13px;">备注:</td>
						<td><input type="text" name="BZ" id="BZ" value="${pd.BZ }"
							placeholder="这里输入备注" maxlength="64" title="备注" style="width:98%;" /></td>
					</tr>
					<tr>
						<td style="text-align: center;" colspan="10"><a
							class="btn btn-mini btn-primary" onclick="save();">保存</a> <a
							class="btn btn-mini btn-danger" data-btn-type="cancel"
							data-dismiss="modal">取消</a></td>
					</tr>
				</table>
			</div>
			
		</form>
	</div>

	<script type="text/javascript">
		//$(top.hangge());
		//保存
	$(document).ready(function(){
		
		if($("#user_id").val()!=""){
			$("#loginname").attr("readonly","readonly");
			$("#loginname").css("color","gray");
		}
	});
	//保存
	function save(){
		//alert($("#role_id1").val());
		if($("#role_id1").val()==""){
			$("#juese").tips({
				side:3,
	            msg:'选择角色',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#role_id1").focus();
			return false;
		}
		if($("#loginname").val()=="" || $("#loginname").val()=="此用户名已存在!"){
			$("#loginname").tips({
				side:3,
	            msg:'输入用户名',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#loginname").focus();
			$("#loginname").val('');
			$("#loginname").css("background-color","white");
			return false;
		}else{
			$("#loginname").val(jQuery.trim($('#loginname').val()));
		}
		
		if($("#NUM").val()==""){
			$("#NUM").tips({
				side:3,
	            msg:'输入编号',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#NUM").focus();
			return false;
		}else{
			$("#NUM").val($.trim($("#NUM").val()));
		}
		if($("#user_id").val()=="" && $("#password").val()==""){
			$("#password").tips({
				side:3,
	            msg:'输入密码',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#password").focus();
			return false;
		}
		if($("#password").val()!=$("#chkpwd").val()){
			
			$("#chkpwd").tips({
				side:3,
	            msg:'两次密码不相同',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#chkpwd").focus();
			return false;
		}
		if($("#name").val()==""){
			$("#name").tips({
				side:3,
	            msg:'输入姓名',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#name").focus();
			return false;
		}
		var myreg = /^(((13[0-9]{1})|159)+\d{8})$/;
		if($("#PHONE").val()==""){
			
			$("#PHONE").tips({
				side:3,
	            msg:'输入手机号',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#PHONE").focus();
			return false;
		}else if($("#PHONE").val().length != 11 && !myreg.test($("#PHONE").val())){
			$("#PHONE").tips({
				side:3,
	            msg:'手机号格式不正确',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#PHONE").focus();
			return false;
		}
		if($("#EMAIL").val()==""){
			
			$("#EMAIL").tips({
				side:3,
	            msg:'输入邮箱',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#EMAIL").focus();
			return false;
		}else if(!ismail($("#EMAIL").val())){
			$("#EMAIL").tips({
				side:3,
	            msg:'邮箱格式不正确',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#EMAIL").focus();
			return false;
		}
		if($("#user_id").val()==""){
			hasU();
		}else{
			$("#userForm_add").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
	}
	function ismail(mail){
		return(new RegExp(/^(?:[a-zA-Z0-9]+[_\-\+\.]?)*[a-zA-Z0-9]+@(?:([a-zA-Z0-9]+[_\-]?)*[a-zA-Z0-9]+\.)+([a-zA-Z]{2,})+$/).test(mail));
		}
	
	//判断用户名是否存在
	function hasU(){
		var USERNAME = $.trim($("#loginname").val());
		$.ajax({
			type: "POST",
			url: '<%=basePath%>user/hasU.do',
	    	data: {USERNAME:USERNAME,tm:new Date().getTime()},
			dataType:'json',
			cache: false,
			success: function(data){
				 if("success" == data.result){
					$("#userForm_add").submit();
					//$("#zhongxin").hide();
					//$("#zhongxin2").show();
				 }else{
					$("#loginname").css("background-color","#D16E6C");
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
	    	data: {NUM:NUM,USERNAME:USERNAME,tm:new Date().getTime()},
			dataType:'json',
			cache: false,
			success: function(data){
				 if("success" != data.result){
					 $("#NUM").tips({
							side:3,
				            msg:'编号 '+NUM+' 已存在',
				            bg:'#AE81FF',
				            time:3
				        });
					 $("#NUM").val('');
				 }
			}
		});
	}
	$(function() {
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
	});
		</script>
</body>
</html>
