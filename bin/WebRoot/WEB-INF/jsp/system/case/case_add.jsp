<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.util.Calendar" %>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	Calendar cal = Calendar.getInstance();
	int year = cal.get(Calendar.YEAR);
	int month = cal.get(Calendar.MONTH );

%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<base href="<%=basePath%>">
		<!-- jsp文件头和头部 -->
		<script src="static/ace/js/table.js"></script>
		<script src="static/ace/js/editor/kindeditor.js"></script>
		<style >
		 .table3{  
     border-width: 1px;  
    border-style: solid;  
    border-color: #CCCCCC;  
    }  
    .table3 td{  
	    border-width: 1px;  
	    border-style: solid;  
	    border-color: #CCCCCC;
	    height:45px;
	    padding-left:5px;
	    padding-right:5px; 
    }
    .table3 th{  
	   height:40px;
    }   
    .EditCell_TextBox {  
    width: 90%;  
    border:1px solid #0099CC;  
    }  
    .EditCell_DropDownList {  
    width: 90%;  
    }  
		
		.table3 input{
		height:30px;
		width:160px;
		line-height:30px;
	}
	.table3 select{
		height:30px;
		width:160px;
		line-height:30px;
	}
	
	 
	 </style>
	 <!-- 日期框 -->
<link rel="stylesheet" href="static/ace/css/datepicker.css" />
<script>


</script>	
</head>
<body class="no-skin">
<!-- /section:basics/navbar.layout -->
<div class="modal-header">
	<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><li class="fa fa-remove"></li></button>
	<h5 class="modal-title">实例管理</h5>
</div>

<div class="modal-body">
	<form action="case/${msg }.do" name="Form_add" id="Form_add" method="post">
		<div id="zhongxin">
			
		<table id="table_report"   class="table3" style="margin-top:5px;width:100%">
			<input type="hidden" name="ID" id="ID" value="${pd.ID}">
			<input type="hidden" name="action" id="action" value="${action}">
			<tr>
				<td style="text-align: right;min-width:100px">实例编码:</td>
				<td style="text-align: left;">
					<input type="text" name="CASE_CODE" style="width:160px"  id="CASE_CODE" value="${pd.CASE_CODE}">	
					数字或字母*
				</td>
				<td style="text-align: right;min-width:100px">实例名称:</td>
				<td style="text-align: left;">
					<input type="text" name="CASE_NAME" style="width:160px"  id="CASE_NAME" value="${pd.CASE_NAME}">	
					*
				</td>
			</tr>
			<tr>
				<td style="text-align: right;">所属用户:</td>
				<td style="text-align: left;">
					<select id="USERNAME" name="USERNAME" >
						<c:forEach items="${listuser}" var="user" varStatus="vs">
							<option value="${user.USERNAME }" <c:if test="${pd.USERNAME==user.USERNAME}">selected</c:if>>${user.NAME }</option>
						</c:forEach>
						
					</select>
				</td>
				<td style="text-align: right;min-width:100px">状态:</td>
				<td style="text-align: left;">
					<select id="STATE" name="STATE" >
						
						<option value="1" <c:if test="${pd.STATE=='1'}">selected</c:if>>启动</option>
						<option value="0" <c:if test="${pd.STATE=='0'}">selected</c:if>>停止</option>
					</select>
				</td>
			</tr>
			<tr>	
				<td style="text-align: right;">描述:</td>
				<td style="text-align: left;" colspan="3" >
					<input type="text" name="CONT" style="width:160px"  id="CONT" value="${pd.CONT}">	
					*
				</td>
				
			</tr>
			
			<tr>
				<td style="text-align: center;" colspan="4">
					<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
					<a class="btn btn-mini btn-danger"  data-btn-type="cancel" data-dismiss="modal">取消</a>
				</td>
			</tr>
		</table>
		</div>
		
		<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
		
	</form>
</div>
<!-- /.main-container -->

<style type="text/css">
	li {list-style-type:none;}
	</style>
	<ul class="navigationTabs">
           <li><a></a></li>
           <li></li>
       </ul>
	
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	
	
		<script type="text/javascript">
		
		//日期框
		$(function() {
		
			
			
		});
		//保存
		function save(){
			//alert($("#role_id1").val());
			if($("#CASE_CODE").val()==""){
				$("#CASE_CODE").tips({
					side:3,
		            msg:'实例编码',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#CASE_CODE").focus();
				return false;
			}else{
				if(/.*[\u4e00-\u9fa5]+.*$/.test($("#CASE_CODE").val())) 
				{ 
					$("#CASE_CODE").tips({
						side:3,
			            msg:'输入实例编码需要字母或者数字',
			            bg:'#AE81FF',
			            time:2
			        });
					$("#CASE_CODE").focus();
					return false;
				} 
				
			}
			
			if($("#CASE_NAME").val()==""){
				$("#CASE_NAME").tips({
					side:3,
		            msg:'实例名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#CASE_NAME").focus();
				return false;
			}
			
			if($("#CONT").val()==""){
				$("#CONT").tips({
					side:3,
		            msg:'输入描述',
		            bg:'#AE81FF',
		            time:3
		        });
				$("#CONT").focus();
				return false;
			}
			
			//$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
			
			$.ajax({
	            //几个参数需要注意一下
                type: "POST",//方法类型
                dataType: "html",//预期服务器返回的数据类型
                url: "case/${msg}.do" ,//url
                data: $('#Form_add').serialize(),
                success: function (result) {
                  //  console.log(result.);//打印服务端返回的数据(调试用)
                    if (result.indexOf("success")>=0) {
                    	location.href="<%=path%>/case/listCases.do";
                    }
                   
                },
                error : function() {
                    alert("异常！");
                }
            });
		}
	
		</script>
</body>
</html>