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
	<h5 class="modal-title">设备管理</h5>
</div>

<div class="modal-body">
	<form action="endpoint/saveendpoint.do" name="addForm" id="addForm" method="post">
		<div id="zhongxin">
			
		<table id="table_report"   class="table3" style="margin-top:5px;width:100%">
			<input type="hidden" name="ID" id="ID" value="${pd.ID}">
			<input type="hidden" name="action" id="action" value="${action}">
			<tr>
				<td style="text-align: right;min-width:100px">设备编号:</td>
				<td style="text-align: left;">
					<input type="text" name="ENDPOINT_ID" style="width:160px"  id="ENDPOINT_ID" value="${pd.ENDPOINT_ID}">	
					*
				</td>
				<td style="text-align: right;min-width:100px">设备名称:</td>
				<td style="text-align: left;">
					<input type="text" name="ENDPOINT_NAME" style="width:160px"  id="ENDPOINT_NAME" value="${pd.ENDPOINT_NAME}">	
					*
				</td>
			</tr>
			<tr>
				<td style="text-align: right;min-width:100px">协议:</td>
				<td style="text-align: left;">
					<select id="XYID" name="XYID" >
						<c:forEach items="${dictList}" var="dict" varStatus="vs">
							<option value="${dict.DICTIONARIES_ID }" <c:if test="${pd.XYID==dict.DICTIONARIES_ID}">selected</c:if>>${dict.NAME }</option>
						</c:forEach>
					</select>*
				</td>
				<td style="text-align: right;min-width:100px">用户名:</td>
				<td style="text-align: left;">
					<input type="text" name="YHM" style="width:160px"  id="YHM" value="${pd.YHM}">	
					*
				</td>
			</tr>
			<tr>
				<td style="text-align: right;min-width:100px">密钥:</td>
				<td style="text-align: left;">
					<input type="text" name="YHPWD" style="width:160px"  id="YHPWD" value="${pd.YHPWD}">	
					*
				</td>
				<td style="text-align: right;min-width:100px">主题:</td>
				<td style="text-align: left;">
					<input type="text" name="THEME" style="width:160px"  id="THEME" value="${pd.THEME}">	
					*
				</td>
			</tr>
			<tr>	
				<td style="text-align: right;">备注:</td>
				<td style="text-align: left;" >
					<input type="text" name="REMARK" style="width:160px"  id="REMARK" value="${pd.REMARK}">	
					*
				</td>
				<td style="text-align: right;">所属实例:</td>
				<td style="text-align: left;">
					<select id="CASEID" name="CASEID">
						<c:forEach items="${listcase}" var="caseBean" varStatus="vs">
							<option value="${caseBean.id }" <c:if test="${pd.CASEID==caseBean.id}">selected</c:if>>${caseBean.case_name }</option>
						</c:forEach>
						
					</select>
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
			if($("#ENDPOINT_NAME").val()==""){
				$("#ENDPOINT_NAME").tips({
					side:3,
		            msg:'设备名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ENDPOINT_NAME").focus();
				return false;
			}
			
			if($("#ENDPOINT_ID").val()==""){
				$("#ENDPOINT_ID").tips({
					side:3,
		            msg:'设备编码',
		            bg:'#AE81FF',
		            time:3
		        });
				$("#ENDPOINT_ID").focus();
				return false;
			}
			
			if($("#XYID").val()==""){
				$("#XYID").tips({
					side:3,
		            msg:'协议',
		            bg:'#AE81FF',
		            time:3
		        });
				$("#XYID").focus();
				return false;
			}
			
			
			if($("#YHM").val()==""){
				$("#YHM").tips({
					side:3,
		            msg:'用户名',
		            bg:'#AE81FF',
		            time:3
		        });
				$("#YHM").focus();
				return false;
			}
			
			
			if($("#YHPWD").val()==""){
				$("#YHPWD").tips({
					side:3,
		            msg:'秘钥',
		            bg:'#AE81FF',
		            time:3
		        });
				$("#YHPWD").focus();
				return false;
			}
			if($("#THEME").val()==""){
				$("#THEME").tips({
					side:3,
		            msg:'主题',
		            bg:'#AE81FF',
		            time:3
		        });
				$("#THEME").focus();
				return false;
			}
			if($("#CASEID").val()==""){
				$("#CASEID").tips({
					side:3,
		            msg:'实例',
		            bg:'#AE81FF',
		            time:3
		        });
				$("#CASEID").focus();
				return false;
			}
			if($("#REMARK").val()==""){
				$("#REMARK").tips({
					side:3,
		            msg:'备注',
		            bg:'#AE81FF',
		            time:3
		        });
				$("#REMARK").focus();
				return false;
			}
			
			//$("#addForm").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
			$.ajax({
	            //几个参数需要注意一下
                type: "POST",//方法类型
                dataType: "html",//预期服务器返回的数据类型
                url: "endpoint/${msg}.do" ,//url
                data: $('#addForm').serialize(),
                success: function (result) {
                  //  console.log(result.);//打印服务端返回的数据(调试用)
                    if (result.indexOf("success")>=0) {
                    	location.href="<%=path%>/endpoint/listendpoints.do";
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