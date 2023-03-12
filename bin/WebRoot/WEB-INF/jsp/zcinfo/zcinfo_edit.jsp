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
		<h5 class="modal-title">微信用户注册绑定</h5>
	</div>
	
	<div class="modal-body">
					
					<form action="zcinfo/${msg }.do" name="Form_add" id="Form_add" method="post">
						<input type="hidden" name="WXUSER_ID" id="WXUSER_ID" value="${pd.WXUSER_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:110px;text-align: right;padding-top: 13px;">用户类型:</td>
								<td><input type="text" name="USERYTYPE" id="USERYTYPE" value="${pd.USERYTYPE}" maxlength="5" placeholder="这里输入用户类型" title="用户类型" style="width:35%;"/></td>
							</tr>
							<tr>
								<td style="width:110px;text-align: right;padding-top: 13px;">姓名/企业名称:</td>
								<td><input type="text" name="NAME" id="NAME" value="${pd.NAME}" maxlength="200" placeholder="这里输入姓名/企业名称" title="姓名/企业名称" style="width:35%;"/></td>
							</tr>
							<tr>
								<td style="width:110px;text-align: right;padding-top: 13px;">性别:</td>
								<td><input type="text" name="SEX" id="SEX" value="${pd.SEX}" maxlength="10" placeholder="这里输入性别" title="性别" style="width:35%;"/></td>
							</tr>
							<tr>
								<td style="width:110px;text-align: right;padding-top: 13px;">年龄:</td>
								<td><input type="text" name="AGE" id="AGE" value="${pd.AGE}" maxlength="10" placeholder="这里输入年龄" title="年龄" style="width:35%;"/></td>
							</tr>
							<tr>
								<td style="width:110px;text-align: right;padding-top: 13px;">所在市:</td>
								<td><input type="text" name="CITY" id="CITY" value="${pd.CITY}" maxlength="300" placeholder="这里输入所在市" title="所在市" style="width:35%;"/></td>
							</tr>
							<tr>
								<td style="width:110px;text-align: right;padding-top: 13px;">所在区:</td>
								<td><input type="text" name="AREA" id="AREA" value="${pd.AREA}" maxlength="100" placeholder="这里输入所在区" title="所在区" style="width:35%;"/></td>
							</tr>
							<tr>
								<td style="width:110px;text-align: right;padding-top: 13px;">地址:</td>
								<td><input type="text" name="ADDRESS" id="ADDRESS" value="${pd.ADDRESS}" maxlength="500" placeholder="这里输入地址" title="地址" style="width:35%;"/></td>
							</tr>
							<tr>
								<td style="width:110px;text-align: right;padding-top: 13px;">联系电话:</td>
								<td><input type="text" name="TEL" id="TEL" value="${pd.TEL}" maxlength="50" placeholder="这里输入联系电话" title="联系电话" style="width:35%;"/></td>
							</tr>
							<tr>
								<td style="width:110px;text-align: right;padding-top: 13px;">高校毕业:</td>
								<td><input type="text" name="JOB" id="JOB" value="${pd.JOB}" maxlength="10" placeholder="这里输入高校毕业" title="高校毕业" style="width:35%;"/></td>
							</tr>
							<tr>
								<td style="width:110px;text-align: right;padding-top: 13px;">注册时间:</td>
								<td><input class="span10 date-picker" name="FOUDDATE" id="FOUDDATE" value="${pd.FOUDDATE}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="注册时间" title="注册时间" style="width:35%;"/></td>
							</tr>
							<tr>
								<td style="width:110px;text-align: right;padding-top: 13px;">注册资本:</td>
								<td><input type="text" name="CAPTAIL" id="CAPTAIL" value="${pd.CAPTAIL}" maxlength="20" placeholder="这里输入注册资本" title="注册资本" style="width:35%;"/></td>
							</tr>
							<tr>
								<td style="width:110px;text-align: right;padding-top: 13px;">复员专业退役军人:</td>
								<td><input type="text" name="ZYJR" id="ZYJR" value="${pd.ZYJR}" maxlength="10" placeholder="这里输入复员专业退役军人" title="复员专业退役军人" style="width:35%;"/></td>
							</tr>
							<tr>
								<td style="width:110px;text-align: right;padding-top: 13px;">注册时间:</td>
								<td><input class="span10 date-picker" name="ZCTIME" id="ZCTIME" value="${pd.ZCTIME}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="注册时间" title="注册时间" style="width:35%;"/></td>
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


		<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	
		<script type="text/javascript">
		//$(top.hangge());
		//保存
		function save(){
			if($("#USERYTYPE").val()==""){
				$("#USERYTYPE").tips({
					side:3,
		            msg:'请输入用户类型',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#USERYTYPE").focus();
			return false;
			}
			if($("#NAME").val()==""){
				$("#NAME").tips({
					side:3,
		            msg:'请输入姓名/企业名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#NAME").focus();
			return false;
			}
			if($("#SEX").val()==""){
				$("#SEX").tips({
					side:3,
		            msg:'请输入性别',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#SEX").focus();
			return false;
			}
			if($("#AGE").val()==""){
				$("#AGE").tips({
					side:3,
		            msg:'请输入年龄',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#AGE").focus();
			return false;
			}
			if($("#CITY").val()==""){
				$("#CITY").tips({
					side:3,
		            msg:'请输入所在市',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#CITY").focus();
			return false;
			}
			if($("#AREA").val()==""){
				$("#AREA").tips({
					side:3,
		            msg:'请输入所在区',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#AREA").focus();
			return false;
			}
			if($("#ADDRESS").val()==""){
				$("#ADDRESS").tips({
					side:3,
		            msg:'请输入地址',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ADDRESS").focus();
			return false;
			}
			if($("#TEL").val()==""){
				$("#TEL").tips({
					side:3,
		            msg:'请输入联系电话',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#TEL").focus();
			return false;
			}
			if($("#JOB").val()==""){
				$("#JOB").tips({
					side:3,
		            msg:'请输入高校毕业',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#JOB").focus();
			return false;
			}
			if($("#FOUDDATE").val()==""){
				$("#FOUDDATE").tips({
					side:3,
		            msg:'请输入注册时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FOUDDATE").focus();
			return false;
			}
			if($("#CAPTAIL").val()==""){
				$("#CAPTAIL").tips({
					side:3,
		            msg:'请输入注册资本',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#CAPTAIL").focus();
			return false;
			}
			if($("#ZYJR").val()==""){
				$("#ZYJR").tips({
					side:3,
		            msg:'请输入复员专业退役军人',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ZYJR").focus();
			return false;
			}
			if($("#ZCTIME").val()==""){
				$("#ZCTIME").tips({
					side:3,
		            msg:'请输入注册时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ZCTIME").focus();
			return false;
			}
			$("#zhongxin").hide();
			$("#zhongxin2").show();
			$.ajax({
            //几个参数需要注意一下
            
            	 type: "POST",//方法类型
                dataType: "html",//预期服务器返回的数据类型
             	 url: "zcinfo/${msg }.do" ,//url
                data: $('#Form_add').serialize(),
                success: function (result) {
                  //  console.log(result.);//打印服务端返回的数据(调试用)
                    if (result.indexOf("success")>=0) {
                    	location.href="<%=path%>/zcinfo/list.do";
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