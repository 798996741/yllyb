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
	#table_report tr{
		text-align:center;
		margin:0px;
		margin:0px;
		height:30px;
	}	
	#table_report td{
		text-align:center;
		margin:0px;
		margin:0px;
		height:30px;
	}		
	#table_report input{
		width:100%;
		border:0px;
		box-sizing:border-box;
    	-moz-box-sizing:border-box;
    	-webkit-box-sizing:border-box;
    	height:100%;
    	margin:0px;
    	padding:0px;
	}	
	 #table_report select{
		width:100%;
		border:0px;
		box-sizing:border-box;
    	-moz-box-sizing:border-box;
    	-webkit-box-sizing:border-box;
    	height:100%;
    	margin:0px;
    	padding:0px;
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
    var fieldname="",addr="",max="",min="",remark="";
    //var liNum=$("tr[id^='_tr_']").size();  //获取以_tr_开头测tr个数
    for (var i=1;i<=fieldnum;i++){
    	//var tempRow=rowNum-1;; //用于新增tr、td、属性下标 
    	trstr="";
    	 if(i=='1'){
    		trstr="<tr class=\'in-opt\' style=\"background:rgb(49,189,233)\"><td>地址</td><td>数据名称</td><td>上限阀值</td><td>下限阀值</td><td>备注</td></tr>";
    	 }
    	 
    	
    	if(i==1){field='${pd.FIELD1}';fieldname='${pd.FIELDNAME1}';addr='${pd.ADDR1}';max='${pd.MAX1}';min='${pd.MIN1}';remark='${pd.REMARK1}';}
    	if(i==2){field='${pd.FIELD2}';fieldname='${pd.FIELDNAME2}';addr='${pd.ADDR2}';max='${pd.MAX2}';min='${pd.MIN2}';remark='${pd.REMARK2}';}
    	if(i==3){field='${pd.FIELD3}';fieldname='${pd.FIELDNAME3}';addr='${pd.ADDR3}';max='${pd.MAX3}';min='${pd.MIN3}';remark='${pd.REMARK3}';}
    	if(i==4){field='${pd.FIELD4}';fieldname='${pd.FIELDNAME4}';addr='${pd.ADDR4}';max='${pd.MAX4}';min='${pd.MIN4}';remark='${pd.REMARK4}';}
    	if(i==5){field='${pd.FIELD5}';fieldname='${pd.FIELDNAME5}';addr='${pd.ADDR5}';max='${pd.MAX5}';min='${pd.MIN5}';remark='${pd.REMARK5}';}
    	if(i==6){field='${pd.FIELD6}';fieldname='${pd.FIELDNAME6}';addr='${pd.ADDR6}';max='${pd.MAX6}';min='${pd.MIN6}';remark='${pd.REMARK6}';}
    	if(i==7){field='${pd.FIELD7}';fieldname='${pd.FIELDNAME7}';addr='${pd.ADDR7}';max='${pd.MAX7}';min='${pd.MIN7}';remark='${pd.REMARK7}';}
    	if(i==8){field='${pd.FIELD8}';fieldname='${pd.FIELDNAME8}';addr='${pd.ADDR8}';max='${pd.MAX8}';min='${pd.MIN8}';remark='${pd.REMARK8}';}
    	if(i==9){field='${pd.FIELD9}';fieldname='${pd.FIELDNAME9}';addr='${pd.ADDR9}';max='${pd.MAX9}';min='${pd.MIN9}';remark='${pd.REMARK9}';}
    	if(i==10){field='${pd.FIELD10}';fieldname='${pd.FIELDNAME10}';addr='${pd.ADDR10}';max='${pd.MAX10}';min='${pd.MIN10}';remark='${pd.REMARK10}';}
    	if(i==11){field='${pd.FIELD11}';fieldname='${pd.FIELDNAME11}';addr='${pd.ADDR11}';max='${pd.MAX11}';min='${pd.MIN11}';remark='${pd.REMARK11}';}
    	if(i==12){field='${pd.FIELD12}';fieldname='${pd.FIELDNAME12}';addr='${pd.ADDR12}';max='${pd.MAX12}';min='${pd.MIN12}';remark='${pd.REMARK12}';}
    	if(i==13){field='${pd.FIELD13}';fieldname='${pd.FIELDNAME13}';addr='${pd.ADDR13}';max='${pd.MAX13}';min='${pd.MIN13}';remark='${pd.REMARK13}';}
    	if(i==14){field='${pd.FIELD14}';fieldname='${pd.FIELDNAME14}';addr='${pd.ADDR14}';max='${pd.MAX14}';min='${pd.MIN14}';remark='${pd.REMARK14}';}
    	if(i==15){field='${pd.FIELD15}';fieldname='${pd.FIELDNAME15}';addr='${pd.ADDR15}';max='${pd.MAX15}';min='${pd.MIN15}';remark='${pd.REMARK15}';}
    	if(i==16){field='${pd.FIELD16}';fieldname='${pd.FIELDNAME16}';addr='${pd.ADDR16}';max='${pd.MAX16}';min='${pd.MIN16}';remark='${pd.REMARK16}';}
    	if(i==17){field='${pd.FIELD17}';fieldname='${pd.FIELDNAME17}';addr='${pd.ADDR17}';max='${pd.MAX17}';min='${pd.MIN17}';remark='${pd.REMARK17}';}
    	if(i==18){field='${pd.FIELD18}';fieldname='${pd.FIELDNAME18}';addr='${pd.ADDR18}';max='${pd.MAX18}';min='${pd.MIN18}';remark='${pd.REMARK18}';}
    	if(i==19){field='${pd.FIELD19}';fieldname='${pd.FIELDNAME19}';addr='${pd.ADDR19}';max='${pd.MAX19}';min='${pd.MIN19}';remark='${pd.REMARK19}';}
    	if(i==20){field='${pd.FIELD20}';fieldname='${pd.FIELDNAME20}';addr='${pd.ADDR20}';max='${pd.MAX20}';min='${pd.MIN20}';remark='${pd.REMARK20}';}
    	if(i==21){field='${pd.FIELD21}';fieldname='${pd.FIELDNAME21}';addr='${pd.ADDR21}';max='${pd.MAX21}';min='${pd.MIN21}';remark='${pd.REMARK21}';}
    	if(i==22){field='${pd.FIELD22}';fieldname='${pd.FIELDNAME22}';addr='${pd.ADDR22}';max='${pd.MAX22}';min='${pd.MIN22}';remark='${pd.REMARK22}';}
    	if(i==23){field='${pd.FIELD23}';fieldname='${pd.FIELDNAME23}';addr='${pd.ADDR23}';max='${pd.MAX23}';min='${pd.MIN23}';remark='${pd.REMARK23}';}
    	if(i==24){field='${pd.FIELD24}';fieldname='${pd.FIELDNAME24}';addr='${pd.ADDR24}';max='${pd.MAX24}';min='${pd.MIN24}';remark='${pd.REMARK24}';}
    	if(i==25){field='${pd.FIELD25}';fieldname='${pd.FIELDNAME25}';addr='${pd.ADDR25}';max='${pd.MAX25}';min='${pd.MIN25}';remark='${pd.REMARK25}';}
    	if(i==26){field='${pd.FIELD26}';fieldname='${pd.FIELDNAME26}';addr='${pd.ADDR26}';max='${pd.MAX26}';min='${pd.MIN26}';remark='${pd.REMARK26}';}
    	if(i==27){field='${pd.FIELD27}';fieldname='${pd.FIELDNAME27}';addr='${pd.ADDR27}';max='${pd.MAX27}';min='${pd.MIN27}';remark='${pd.REMARK27}';}
    	if(i==28){field='${pd.FIELD28}';fieldname='${pd.FIELDNAME28}';addr='${pd.ADDR28}';max='${pd.MAX28}';min='${pd.MIN28}';remark='${pd.REMARK28}';}
    	if(i==29){field='${pd.FIELD29}';fieldname='${pd.FIELDNAME29}';addr='${pd.ADDR29}';max='${pd.MAX29}';min='${pd.MIN29}';remark='${pd.REMARK29}';}
    	if(i==30){field='${pd.FIELD30}';fieldname='${pd.FIELDNAME30}';addr='${pd.ADDR30}';max='${pd.MAX30}';min='${pd.MIN30}';remark='${pd.REMARK30}';}
    	if(i==31){field='${pd.FIELD31}';fieldname='${pd.FIELDNAME31}';addr='${pd.ADDR31}';max='${pd.MAX31}';min='${pd.MIN31}';remark='${pd.REMARK31}';}
    	if(i==32){field='${pd.FIELD32}';fieldname='${pd.FIELDNAME32}';addr='${pd.ADDR32}';max='${pd.MAX32}';min='${pd.MIN32}';remark='${pd.REMARK32}';}
    	
    	//alert(field);
    	trstr=trstr+"<tr id=\'_tr_"+fieldnum+"\' class=\'in-opt\' >";
    	var tdName = "<td class='in-ctt' style=\"width:20%\"><input name=\'ADDR"+i+"\' id=\'ADDR"+i+"\' value=\'"+addr+"\' /></td>";
        tdName =tdName+ "<td style=\"width:15%\">";
        tdName =tdName+ "<select id=\"FIELD"+i+"\" name=\"FIELD"+i+"\">";
        <c:forEach items="${dictList_zd}" var="dicBean" varStatus="vs">
        	var NAME_EN='${dicBean.NAME_EN }';
        	var NAME='${dicBean.NAME}';
        	if(field==NAME_EN){
        		tdName =tdName+ "<option value=\""+NAME_EN+"\" selected>"+NAME+"</option>";	
        	}else{
        		tdName =tdName+ "<option value=\""+NAME_EN+"\">"+NAME+"</option>";	
        	}
        	
        </c:forEach>
        tdName =tdName+ "</select>";
        tdName =tdName+ "</td>"; //创建第一个td
        tdName =tdName+ "<td class='in-ctt' style=\"width:20%\"><input name=\'MAX"+i+"\' id=\'MAX"+i+"\' value=\'"+max+"\' /></td>";
        tdName =tdName+ "<td class='in-ctt' style=\"width:20%\"><input name=\'MIN"+i+"\' id=\'MIN"+i+"\' value=\'"+min+"\' /></td>";
        tdName =tdName+ "<td class='in-ctt' style=\"width:25%\"><input name=\'REMARK"+i+"\' id=\'REMARK"+i+"\' value=\'"+remark+"\' /></td>";
       // tdstr=tdstr+tdName;
        trstr=trstr+tdName+"</tr>";
        
       //alert(trstr);
    	tb1.append(trstr);
       	
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
	<h5 class="modal-title">数据模板配置</h5>
</div>

<div class="modal-body">
	<form action="field/${msg}.do" name="Form_add" id="Form_add" method="post">
		<div id="zhongxin">
		<input type="hidden" name="ID" id="ID" value="${pd.ID}">
		<input type="hidden" name="UID" id="UID" value="${UID}">
		<input type="hidden" name="action" id="action" value="${action}">
		<input type="hidden" name="fieldstr" id="fieldstr">
		<input type="hidden" name="remarkstr" id="remarkstr">
		<input type="hidden" name="maxstr" id="maxstr">
		<input type="hidden" name="minstr" id="minstr">
		<input type="hidden" name="addrstr" id="addrstr">	
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
		    
		    var field="",remark="",addr="",max="",min="";
		    var fieldstr="";
		    var remarkstr="";
		    var addrstr="";
		    var maxstr="";
		    var minstr="";
		    
		    for (var i=1;i<=fieldnum;i++){
		    	field=$("#FIELD"+i).val();
		    	remark=$("#REMARK"+i).val();
		    	addr=$("#ADDR"+i).val();
		    	max=$("#MAX"+i).val();
		    	min=$("#MIN"+i).val();
		    	//alert(field);
		    	if(field==""){
		    		alert("字段"+i+"名称不能为空！");
		    		$("#FIELD"+i).focus();
		    		return false;
		    	}
		    	fieldstr=fieldstr+field+",";
		    	if(remark==""){
		    		remark="OOOOOOOOOO";
		    	}
		    	if(addr==""){
		    		addr="OOOOOOOOOO";
		    	}
		    	if(max==""){
		    		max="OOOOOOOOOO";
		    	}
		    	if(min==""){
		    		min="OOOOOOOOOO";
		    	}
		    	remarkstr=remarkstr+remark+",";
		    	addrstr=addrstr+addr+",";
		    	maxstr=maxstr+max+",";
		    	minstr=minstr+min+",";
		    	$("#fieldstr").val(fieldstr);
		    	$("#remarkstr").val(remarkstr);
		    	$("#addrstr").val(addrstr);
		    	$("#maxstr").val(maxstr);
		    	$("#minstr").val(minstr);
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