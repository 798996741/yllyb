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
		<%@ include file="../../system/index/top.jsp"%>
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
		
		input{
			width:110px;
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
	<h5 class="modal-title">运行参数</h5>
</div>
<div class="modal-body">
	<form action="run/saverun.do" name="Form" id="Form" method="post">
		<div id="zhongxin">
			
		<table id="table_report"   class="table3" style="margin-top:5px;width:100%">
			<input type="hidden" name="ID" id="ID" value="${pd.ID}">
			<input type="hidden" name="action" id="action" value="${action}">
		
			<tr>
				<td style="text-align: right;min-width:100px">参数编码:</td>
				<td style="text-align: left;">
					<input type="text" name="RUN_CODE" style="width:160px"  id="RUN_CODE" value="${pd.RUN_CODE}">	
					*
				</td>
				<td style="text-align: right;min-width:100px">参数名称:</td>
				<td style="text-align: left;">
					<input type="text" name="RUN_CONT" style="width:160px"  id="RUN_CONT" value="${pd.RUN_CONT}">	
					*
				</td>
			</tr>
			<tr>	
				<td style="text-align: right;">单位值:</td>
				<td style="text-align: left;" colspan="3">
					<input type="text" name="RUN_VALUE" style="width:160px"  id="RUN_VALUE" value="${pd.RUN_VALUE}">	
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
<!-- /.main-RUN_CONTainer -->

<style type="text/css">
	li {list-style-type:none;}
	</style>
	<ul class="navigationTabs">
           <li><a></a></li>
           <li></li>
       </ul>
	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	
	
		<script type="text/javascript">
		
		//日期框
		$(function() {
		
			
			
		});
		//保存
		function save(){
			//alert($("#role_id1").val());
			if($("#RUN_CODE").val()==""){
				$("#RUN_CODE").tips({
					side:3,
		            msg:'参数编码',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#RUN_CODE").focus();
				return false;
			}
			
			if($("#RUN_CONT").val()==""){
				$("#RUN_CONT").tips({
					side:3,
		            msg:'参数名称',
		            bg:'#AE81FF',
		            time:3
		        });
				$("#RUN_CONT").focus();
				return false;
			}
			if($("#RUN_VALUE").val()==""){
				$("#RUN_VALUE").tips({
					side:3,
		            msg:'单位值',
		            bg:'#AE81FF',
		            time:3
		        });
				$("#RUN_VALUE").focus();
				return false;
			}
			
			if($("#RUN_CODE").val()!=""){
				hasU();
			}else{
				$("#Form").submit();
				$("#zhongxin").hide();
				$("#zhongxin2").show();
			}	
		}
	
		function hasU(){
			var RUN_CODE = $("#RUN_CODE").val();
			var ID = $("#ID").val();

			
			$.ajax({
				type: "POST",
				url: '<%=basePath%>run/hasRun_code.do',
		    	data: {ID:ID,RUN_CODE:RUN_CODE,tm:new Date().getTime()},
				dataType:'html',
				cache: false,
				success: function(data){
					//alert(data);
					 if("success" == data){
						$("#Form").submit();
						
					 }else{
						$("#RUN_CODE").tips({
							side:3,
				            msg:'此编码已存在',
				            bg:'#AE81FF',
				            time:3
				        });
						$("#RUN_CODE").focus();
						//setTimeout("$('#RUN_CODE').val('此编码已存在!')",500);
					 }
				}
			});
		}
		
		</script>
</body>
</html>