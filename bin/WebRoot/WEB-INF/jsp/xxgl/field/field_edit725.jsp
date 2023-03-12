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
	.table3 td{
		font-size:14px;
	}	
			
	
	 
	 </style>
	 <!-- 日期框 -->
<link rel="stylesheet" href="static/ace/css/datepicker.css" />
<script>
//新增团队信息的
function insertRows(){ 
    //获取表格对象
    //alert("1");
    var type=$("#TYPE").val();
    var num=$("#NUM").val();
    if(num==""){
    	alert("请输入的个数");
    	return false;
    }
    var fieldnum="";
    if(type=="1"){
    	fieldnum=num;
    	if(fieldnum>32){alert("个数不能超过32个！");return false;}
    }
    if(type=="2"){
    	fieldnum=num*16;
    	if(fieldnum>32){alert("个数不能超过2个！");$("#TYPE").focus();return false;}
    }
   
    var tb1 = $("#table_report");                // 找table的ID
    var rowNum= $("#table_report tr").size();  //获取表格的行数
    tb1.empty("");
    var tdstr="";
    var trstr="";
    var field="";
    var fieldname="";
    //var liNum=$("tr[id^='_tr_']").size();  //获取以_tr_开头测tr个数
    for (var i=1;i<=fieldnum;i++){
    	//var tempRow=rowNum-1;; //用于新增tr、td、属性下标 
    	 if(i%2=='1'){
    		 trstr="<tr id=\'_tr_"+fieldnum+"\' class=\'in-opt\'>";
    	 }
    	
    	if(i==1){field='${pd.FIELD1}';fieldname='${pd.FIELDNAME1}';}
    	if(i==2){field='${pd.FIELD2}';fieldname='${pd.FIELDNAME2}';}
    	if(i==3){field='${pd.FIELD3}';fieldname='${pd.FIELDNAME3}';}
    	if(i==4){field='${pd.FIELD4}';fieldname='${pd.FIELDNAME4}';}
    	if(i==5){field='${pd.FIELD5}';fieldname='${pd.FIELDNAME5}';}
    	if(i==6){field='${pd.FIELD6}';fieldname='${pd.FIELDNAME6}';}
    	if(i==7){field='${pd.FIELD7}';fieldname='${pd.FIELDNAME7}';}
    	if(i==8){field='${pd.FIELD8}';fieldname='${pd.FIELDNAME8}';}
    	if(i==9){field='${pd.FIELD9}';fieldname='${pd.FIELDNAME9}';}
    	if(i==10){field='${pd.FIELD10}';fieldname='${pd.FIELDNAME10}';}
    	if(i==11){field='${pd.FIELD11}';fieldname='${pd.FIELDNAME11}';}
    	if(i==12){field='${pd.FIELD12}';fieldname='${pd.FIELDNAME12}';}
    	if(i==13){field='${pd.FIELD13}';fieldname='${pd.FIELDNAME13}';}
    	if(i==14){field='${pd.FIELD14}';fieldname='${pd.FIELDNAME14}';}
    	if(i==15){field='${pd.FIELD15}';fieldname='${pd.FIELDNAME15}';}
    	if(i==16){field='${pd.FIELD16}';fieldname='${pd.FIELDNAME16}';}
    	if(i==17){field='${pd.FIELD17}';fieldname='${pd.FIELDNAME17}';}
    	if(i==18){field='${pd.FIELD18}';fieldname='${pd.FIELDNAME18}';}
    	if(i==19){field='${pd.FIELD19}';fieldname='${pd.FIELDNAME19}';}
    	if(i==20){field='${pd.FIELD20}';fieldname='${pd.FIELDNAME20}';}
    	if(i==21){field='${pd.FIELD21}';fieldname='${pd.FIELDNAME21}';}
    	if(i==22){field='${pd.FIELD22}';fieldname='${pd.FIELDNAME22}';}
    	if(i==23){field='${pd.FIELD23}';fieldname='${pd.FIELDNAME23}';}
    	if(i==24){field='${pd.FIELD24}';fieldname='${pd.FIELDNAME24}';}
    	if(i==25){field='${pd.FIELD25}';fieldname='${pd.FIELDNAME25}';}
    	if(i==26){field='${pd.FIELD26}';fieldname='${pd.FIELDNAME26}';}
    	if(i==27){field='${pd.FIELD27}';fieldname='${pd.FIELDNAME27}';}
    	if(i==28){field='${pd.FIELD28}';fieldname='${pd.FIELDNAME28}';}
    	if(i==29){field='${pd.FIELD29}';fieldname='${pd.FIELDNAME29}';}
    	if(i==30){field='${pd.FIELD30}';fieldname='${pd.FIELDNAME30}';}
    	if(i==31){field='${pd.FIELD31}';fieldname='${pd.FIELDNAME31}';}
    	if(i==32){field='${pd.FIELD32}';fieldname='${pd.FIELDNAME32}';}
    	
    	//alert(field);
        var $tdName = "<td class='in-ctt' style=\"width:25%\">字段"+i+"名称</td><td style=\"width:25%\"><input name=\'FIELD"+i+"\' id=\'FIELD"+i+"\' value=\'"+field+"\' type=\"hidden\" style=\"width:160px\" readonly/><input type=\"text\" name=\'FIELDNAME"+i+"\' id=\'FIELDNAME"+i+"\' value=\'"+fieldname+"\' style=\"width:160px\" readonly/><input type=\"button\" value=\"..\" style=\"width:30px\" onclick=\"choice_field('"+i+"')\"></td>"; //创建第一个td
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

function choice_field(num){
	var winId = "userWin_dic";
  	modals.openWin({
      	winId: winId,
      	title: '新增',
      	width: '700px',
      	height: '350px',
      	url: '<%=basePath%>/dictionaries/list.do?DICTIONARIES_ID=6b272abc46a34105ac98bb03dd71a549&currentPage=${null == pd.dnowPage || '' == pd.dnowPage?'10':pd.dnowPage}&action=choice&num='+num
      	/*, hideFunc:function(){
         	 modals.info("hide me");
      	},
      	showFunc:function(){
          	modals.info("show me");
      	} */
  	});
		
	
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
	<form action="field/${msg}.do" name="Form_add" id="Form_add" method="post">
		<div id="zhongxin">
		<input type="hidden" name="ID" id="ID" value="${pd.ID}">
		<input type="hidden" name="UID" id="UID" value="${UID}">
		<input type="hidden" name="action" id="action" value="${action}">
			
		<table   class="table3" style="margin-top:5px;width:100%">
			
			<tr>
				<td style="text-align: right;">所属实例:</td>
				<td style="text-align: left;">
					<select id="CASEID" name="CASEID" >
						<c:forEach items="${listcase}" var="caseBean" varStatus="vs">
							<option value="${caseBean.id }" <c:if test="${pd.CASEID==caseBean.id}">selected</c:if>>${caseBean.case_name }</option>
						</c:forEach>
					</select>
				</td>
				<td style="text-align: right;width:25%" >起始地址:</td>
				<td style="text-align: left;width:25%">
					<input type="text" name="STARTADDR" style="width:160px"  id="STARTADDR" value="${pd.STARTADDR}">	
					*
				</td>
				
			</tr>
			<tr>
				<td style="text-align: right;width:25%">类型:</td>
				<td style="text-align: left;width:25%">
					<select id="TYPE" name="TYPE"  onchange="insertRows()">
						<c:forEach items="${dictList}" var="dict" varStatus="vs">
							<option value="${dict.BIANMA }" <c:if test="${pd.TYPE==dict.BIANMA}">selected</c:if>>${dict.NAME }</option>
						</c:forEach>
					</select>*
				</td>	
				<td style="text-align: right;">个数:</td>
				<td style="text-align: left;" >
					<input type="text" name="NUM" onblur="insertRows()" style="width:160px"  id="NUM" value="${pd.NUM}">	
					*
				</td>
				
				
			</tr>
		</table>
		<table id="table_report" class="table3"  style="width:100%;margin-top:3px;">
			
			
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

		<script type="text/javascript">
		
		//日期框
		$(function() {
			var num='${pd.NUM}';
			if(num!=""){
				insertRows(); 	
			}
			 
			
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
		    	if(fieldnum>32){alert("个数不能超过32个！");return false;}
		    }
		    if(type=="2"){
		    	fieldnum=num*16;
		    	if(fieldnum>32){alert("个数不能超过2个！");return false;}
		    }
		    
		    var field="";
		    
		    for (var i=1;i<=fieldnum;i++){
		    	field=$("#FIELD"+i).val();
		    	//alert(field);
		    	if(field==""){
		    		/* $("#FIELD"+i).tips({
						side:3,
			            msg:'空',
			            bg:'#AE81FF',
			            time:3
			        }); */
					
		    		alert("字段"+i+"名称不能为空！");
		    		$("#FIELD"+i).focus();
		    		return false;
		    	}
		    }
			//$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
			$.ajax({
	            //几个参数需要注意一下
                type: "POST",//方法类型
                dataType: "html",//预期服务器返回的数据类型
                url: "field/${msg}.do" ,//url
                data: $('#Form_add').serialize(),
                success: function (result) {
                  //  console.log(result.);//打印服务端返回的数据(调试用)
                    if (result.indexOf("success")>=0) {
                    	location.href="<%=path%>/field/list.do";
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