<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="com.fh.util.Jurisdiction" %>
<%
	Jurisdiction jurisdiction=new Jurisdiction();
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
<link rel="stylesheet" href="static/ace/css/chosen.css" />
<!-- jsp文件头和头部 -->
<%@ include file="../../system/include/incJs_mx.jsp"%>

<style>
	.on{
		color:red;
	}
	 
    
     button{
         cursor: pointer;
     }
    
     .gold{
         color: red;
     }
    

</style>
<script src="static/ace/echarts/build/dist/echarts-all.js"></script>

</head>
<body class="no-skin">
<div class="content-wrapper" style="width:100%;margin-left:0px;">
    <section class="content-header">
      <h1>
        	统计管理
        <small>数据统计</small>
      </h1>
      <ol class="breadcrumb">
        <li>
			<a href="javascript:;" onclick="home()">
				<i class="fa fa-dashboard"></i> 主页
			</a>
		</li>
		<li class="active">数据统计</li>
      </ol>
    </section>
<section class="content">
	 <div class="row">
        <div class="col-xs-12">
          <div class="box">
          	
          	<div class="title" style="height:30px;text-align:center">
          		<input type="hidden" id="choiceid" value="1">
               	<button id="btn1" class="gold" onclick="choice_xx('id1')">发生器</button>
               	<button id="btn2" onclick="choice_xx('id2')">预警</button>
               	<button id="btn3" onclick="choice_xx('id3')">趋势曲线</button>
           </div>
          	<div class="content_nr" id="dd"  style="margin-top:50px">
          		<div style="display:block" id="id1">
          		
          		</div>
               	<div style="display:none" id="id2">
               		<table id="example2" class="table table-bordered table-hover">
	                	<thead>
							<tr>
								
								<th class="center" style="width:30px;">序号</th>
								<th class="center">实例名称</th>
								<th class="center">设备</th>
								<th class="center">数据项目</th>
								<th class="center">值</th>
								<th class="center">预警信息</th>
								<th class="center">预警时间</th>
							</tr>
						</thead>
												
						<tbody>
	                		
	                	</tbody>
	               
	              	</table>
               	
               	</div>
               	<div id="id3" style="height:500px;display:none">
		          	<div class="box-header" style="margin-top:40px">
		          		<input type="hidden" id="time" value="30">
			          	<a class="btn btn-mini btn-success" onclick="add(1);">01分钟</a>
			          	<a class="btn btn-mini btn-success" onclick="add(5);">05分钟</a>
			          	<a class="btn btn-mini btn-success" onclick="add(15);">15分钟</a>
			          	<a class="btn btn-mini btn-success" onclick="add(30);" class="on">30分钟</a>
			          	<a class="btn btn-mini btn-success" onclick="add(60);">1小时</a>
			          	<a class="btn btn-mini btn-success" onclick="add(360);">6小时</a>
			          	<a class="btn btn-mini btn-success" onclick="add(720);">12小时</a>
		            </div>
		            <!-- /.box-header -->
		            <div class="box-body"  style="margin-top:50px" id="dd">
	          		
						<div id="main" style="width: 100%;height:500px;"></div>
						
					</div>
				</div>
			
				</div>
			</div>	
		</div>	
	</div>
 </section>
 </div>
 <!-- 日期框 -->
<script type="text/javascript">

$(function() {
	$('#example2').DataTable({
		  'paging'      : true,
		  'lengthChange': false,
		  'searching'   : false,
		  'ordering'    : true,
		  'info'        : true,
		  'autoWidth'   : true
		})
	
});
function choice_xx(id){
	if(id=="id1"){
		$("#choiceid").val("1");
		document.getElementById("id1").style.display="block";
		document.getElementById("id2").style.display="none";
		document.getElementById("id3").style.display="none";
		document.getElementById('btn1').style.color='red';
		document.getElementById('btn2').style.color='#000';
		document.getElementById('btn3').style.color='#000';
		
	}
	if(id=="id2"){
		$("#choiceid").val("2");
		document.getElementById("id1").style.display="none";
		document.getElementById("id2").style.display="block";
		document.getElementById("id3").style.display="none";
		document.getElementById('btn1').style.color='#000';
		document.getElementById('btn2').style.color='red';
		document.getElementById('btn3').style.color='#000';
	}
	if(id=="id3"){
		$("#choiceid").val("3");
		document.getElementById("id1").style.display="none";
		document.getElementById("id2").style.display="none";
		document.getElementById("id3").style.display="block";
		document.getElementById('btn1').style.color='#000';
		document.getElementById('btn2').style.color='#000';
		document.getElementById('btn3').style.color='red';
	}
}

        // 基于准备好的dom，初始化echarts实例
function add(time){
   	$("#time").val(time);   
   	$('.btn').on('click',function() {
    	$(this).addClass('on').siblings().removeClass('on');
	});
}	
var X = [];
var Y = [];
var L = [];
var Z = [];
function bar(){
	document.getElementById('main').innerHTML="";
	var myChart = echarts.init(document.getElementById('main'));
	var option = {
	    // 标题
	    title: {
	        text: '指标数据',
	        subtext: '数据来源：'
	    },
	    tooltip: {
	        trigger: 'axis'
	    },
	    //图例名
	    legend: {
	        data:L
	    },
	    grid: {
	        left: '3%',   //图表距边框的距离
	        right: '4%',
	        bottom: '3%',
	        containLabel: true
	    },	    
	    tooltip : {//鼠标悬浮弹窗提示	       
	    	trigger: 'axis',	    	  
	    	show:true,	          
	    	showDelay: 0,	          
	    	hideDelay: 0,	         
	    	transitionDuration:0, 	         	         
	           
	    	padding: 10,
	    	margin:0,
	    	width:100,
	    	textStyle:{
	    		align:'left',
	    		width:100
	    	}
	    },
	    //x轴信息样式
	    xAxis: {
	        type: 'category',
	        boundaryGap: false,
	        data: X,
	        //坐标轴颜色
	        axisLine:{
	            lineStyle:{
	                color:'red'
	            }
	        },
	        //x轴文字旋转
	        axisLabel:{
	            rotate:30,
	            interval:0
	        },
	    },
	
	    yAxis : [
	        {
	            type : 'value',
	            axisLabel : {
	                formatter: '{value}'
	            }
	        }
	    ],
	    series: [
	        //虚线
	        {
	            name:'度数',
	            type:'line',
	            symbolSize:4,   //拐点圆的大小
	            color:['red'],  //折线条的颜色
	            data:Y,
	            smooth:false,   //关键点，为true是不支持虚线的，实线就用true
	            itemStyle:{
	                normal:{
	                    lineStyle:{
	                        width:2,
	                        type:'dotted'  //'dotted'虚线 'solid'实线
	                    }
	                }
	            }
	        },
	        {
	            name:'压强',
	            type:'line',
	            symbolSize:4,   //拐点圆的大小
	            color:['red'],  //折线条的颜色
	            data:Z,
	            smooth:false,   //关键点，为true是不支持虚线的，实线就用true
	            itemStyle:{
	                normal:{
	                    lineStyle:{
	                        width:2,
	                        type:'dotted'  //'dotted'虚线 'solid'实线
	                    }
	                }
	            }
	        }
	    ]
	};
	// 使用刚指定的配置项和数据显示图表。
	myChart.setOption(option);
}	

 
setInterval(function () {
	 X = [];
	 Y = [];
	 L = [];
	 Z = [];
		var choiceid=$("#choiceid").val();
	 $.ajax({
    	type: 'get',
        url: "<%=path%>/tj/getdata.do?r="+Math.random(),
        dataType: 'json',
        data: { 
        	time:$("#time").val() ,
        	choiceid:$("#choiceid").val()
		},
        cache: false,
        success: function (obj) {
        	//{name: "1", value: Array(2)}
        	console.log(obj.result);
        	if(choiceid=="1"){
        		$("#id1").html(obj.result);
        	}
        	if(choiceid=="2"){
        		var str="";
				var zobj=JSON.parse(obj.result);
	        	
	        	$.each(zobj, function(i,fdata){
	        		str=str+"<tr>";
	        		str=str+"<td class='center' style=\"width: 30px;\">"+i+"</td>";
	        		str=str+"<td class='center'>"+fdata.CASE_NAME+"</td>";
	        		str=str+"<td class='center'>"+fdata.ENDPOINT_NAME+"("+fdata.ENDPOINT+")</td>";
	        		str=str+"<td class='center'>"+fdata.FIELDNAME+"("+fdata.FIELD+")</td>";
	        		str=str+"<td class='center'>"+fdata.NUM+"</td>";
	        		str=str+"<td class='center'>"+fdata.REMARK+"</td>";
	        		str=str+"<td class='center'>"+fdata.CREATEDATE+"</td>";
	        		str=str+"</tr>";
	        		
	        	});
	        	$("#example2 tbody").html("");
	        	$("#example2 tbody").append(str);
	        	
        	}
        	
        	
        	if(choiceid=="3"){
	        	var zobj=JSON.parse(obj.result);
	        	
	        	$.each(zobj, function(i,fdata){
	        		console.log(fdata.name);
	        		if(fdata.name=="温度"){
		        		L.push(fdata.name);
		        		if(fdata.datalist.length>=1){
		        			var childobj=fdata.datalist;
		            		$.each(childobj, function(i,childdata){
		            			Y.push(childdata.value);
		            			X.push(childdata.name);
		            		});
		        		}
	        		}else{
	        			L.push(fdata.name);
		        		if(fdata.datalist.length>=1){
		        			var childobj=fdata.datalist;
		            		$.each(childobj, function(i,childdata){
		            			Z.push(childdata.value);
		            		});
		        		}
	        		}
        		});
        	}
			//ajax加载成功后跳转bar函数加载charts图，介绍下这里为什么要给pieChart造一个函数bar，因为上面的ajax异步传输消息时很容易出现数据没加载完就运行下一步，所以这里使用添加bar()方法的方式解决这种问题。//没有遇到类似问题的可以尝试下去除这个方法直接加载的方式看看结果。alert一下。 

			//ajax遇到这种问题还有一种解决方式就是把异步改成同步async：false 但是那样ajax传输就丢失了它的意义。
			if(choiceid=="3"){
				bar();	
			}
			

        	//alert(data);
        },
        error: function (jqXHR, textStatus, errorThrown) {
        	alert(jqXHR.responseText);
            return false;
        }
    });
    
 
}, 3000);
 

</script>

</body>

</html>
