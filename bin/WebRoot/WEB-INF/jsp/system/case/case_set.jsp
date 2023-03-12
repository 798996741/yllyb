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
		
		
	
	 
	 </style>
	 <!-- 日期框 -->
<link rel="stylesheet" href="static/ace/css/datepicker.css" />
<script>
//新增团队信息的
function insertRows(){ 
    //获取表格对象
    var type=$("#TYPE").val();
    var num=$("#NUM").val();
    if(num==""){
    	alert("请添加字段的个数");
    	return false;
    }
    var fieldnum="";
    if(type=="1"){
    	fieldnum=num;
    }
    if(type=="2"){
    	fieldnum=num*16;
    }
    var tb1 = $("#table_report");                // 找table的ID
    var rowNum= $("#table_report tr").size();  //获取表格的行数
    tb1.empty("");
    var tdstr="";
    var trstr="";
    //var liNum=$("tr[id^='_tr_']").size();  //获取以_tr_开头测tr个数
    for (var i=1;i<=fieldnum;i++){
    	//var tempRow=rowNum-1;; //用于新增tr、td、属性下标 
    	 if(i%2=='1'){
    		 trstr="<tr id=\'_tr_"+fieldnum+"\' class=\'in-opt\'>";
    	 }
        var $tdName = "<td class='in-ctt' style=\"width:25%\">字段"+i+"名称</td><td style=\"width:25%\"><input name=\'FIELD"+i+"\' id=\'FIELD"+i+"\' value=\'\' style=\"width:160px\"/></td>"; //创建第一个td
        tdstr=tdstr+$tdName;
        
       	if(i==fieldnum){
       		trstr=trstr+tdstr+"</tr>";
        	tb1.append(trstr);
        	tdstr="";
        	trstr="";
       	}else{
	        if(i%2=='0'){
	        	trstr=trstr+tdstr+"</tr>";
	        	tb1.append(trstr);
	        	tdstr="";
	        	trstr="";
	        }
        }
        //在表格的最后追加新增的tr
       
    }
    
} 

</script>	
</head>
<body class="no-skin">
<!-- /section:basics/navbar.layout -->
<div class="modal-header">
	<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><li class="fa fa-remove"></li></button>
	<h5 class="modal-title">接收配置</h5>
</div>

<div class="modal-body">
	<form action="case/saveset.do" name="Form" id="Form" method="post">
		<div id="zhongxin">
		<input type="hidden" name="CASEID" id="CASEID" value="${pd.ID}">
		<input type="hidden" name="action" id="action" value="${action}">
			
		<table   class="table3" style="margin-top:5px;width:100%">
			
			<tr>
				<td style="text-align: right;width:25%" >起始地址:</td>
				<td style="text-align: left;width:25%">
					<input type="text" name="STARTADDR" style="width:160px"  id="STARTADDR" value="${pd.STARTADDR}">	
					字母*
				</td>
				<td style="text-align: right;width:25%">类型:</td>
				<td style="text-align: left;width:25%">
					<select id="TYPE" name="TYPE" style="width:110px" onchange="insertRows()">
						<c:forEach items="${dictList}" var="dict" varStatus="vs">
							<option value="${dict.BIANMA }" <c:if test="${pd.TYPE==dict.BIANMA}">selected</c:if>>${dict.NAME }</option>
						</c:forEach>
					</select>*
				</td>
			</tr>
			<tr>	
				<td style="text-align: right;">字段个数:</td>
				<td style="text-align: left;" colspan="3" >
					<input type="text" name="NUM" onblur="insertRows()" style="width:160px"  id="NUM" value="${pd.NUM}">	
					*
				</td>
				
			</tr>
		</table>
		<table id="table_report" class="table3"  style="width:100%">
			
			
		</table>
		<table style="width:100%;margin-top:10px;">
			
			<tr>
				<td style="text-align: center;" >
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
			if($("#STARTADDR").val()==""){
				$("#STARTADDR").tips({
					side:3,
		            msg:'起始地址',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#STARTADDR").focus();
				return false;
			}
			
			if($("#NUM").val()==""){
				$("#NUM").tips({
					side:3,
		            msg:'字段个数',
		            bg:'#AE81FF',
		            time:3
		        });
				$("#NUM").focus();
				return false;
			}
			
			var type=$("#TYPE").val();
		    var num=$("#NUM").val();
		    if(num==""){
		    	alert("请添加字段的个数");
		    	return false;
		    }
		    
		    if(type=="1"){
		    	fieldnum=num;
		    }
		    if(type=="2"){
		    	fieldnum=num*16;
		    }
		    var field="";
		    
		    for (var i=1;i<=fieldnum;i++){
		    	field=$("#FIELD"+i).val();
		    	if(field==""){
		    		$("#FIELD"+i).tips({
						side:3,
			            msg:"字段"+i+"名称不能为空！",
			            bg:'#AE81FF',
			            time:3
			        });
					$("#FIELD"+i).focus();
		    		//alert("字段"+i+"名称不能为空！");
		    		return false;
		    	}
		    }
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
	
		</script>
</body>
</html>