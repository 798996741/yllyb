﻿<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	<meta name="App-Config" content="fullscreen=yes,useHistoryState=yes,transition=yes" />
    <meta content="yes" name="apple-mobile-web-app-capable" />
    <meta content="yes" name="apple-touch-fullscreen" />
    <meta content="telephone=no,email=no" name="format-detection" />
    <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no" />
    <script src="http://g.tbcdn.cn/mtb/lib-flexible/0.3.4/??flexible_css.js,flexible.js"></script>
    <script src="https://cdn.bootcss.com/jquery/1.12.4/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="static/weixin/css/mui.picker.min.css" />
    <link rel="stylesheet" type="text/css" href="static/weixin/css/mui.poppicker.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="static/weixin/css/common.css" />
    
     <style>
        .mui-btn{
			font-size: 14px;
			font-weight: 400;
			line-height: 1.42;
			position: relative;
			display: inline-block;
			margin-bottom: 0;
			padding: 6px 12px;
			cursor: pointer;
			-webkit-transition: all;
			transition: all;
			-webkit-transition-timing-function: linear;
			transition-timing-function: linear;
			-webkit-transition-duration: .2s;
			transition-duration: .2s;
			text-align: center;
			vertical-align: top;
			white-space: nowrap;
			color: #333;
			border: 1px solid #ccc;
			border-radius: 3px;
			border-top-left-radius: 3px;
			border-top-right-radius: 3px;
			border-bottom-right-radius: 3px;
			border-bottom-left-radius: 3px;
			background-color: #fff;
			background-clip: padding-box;
		}
		.mui-btn-blue{
			color: #fff;
			background-color: #75C9EE;
		}
		.mui-h5, h5 {
			font-size: 14px;
			font-weight: 400;
			color: #8f8f94;
		}
   </style>
</head>
<body >
 <div class="bg">
	   <header class="site-header">
	       <div class="site-title"></div>
	   </header>
	   <main class="page-main">
	       <form class="page-form" id="Form_add">
	           <div class="form-title gray__border">
	               <div class="form-title-img">
	                   <img src="static/weixin/images/person-icon.png" />
	               </div>
	               <div class="form-title-word">
	                   	企业用户
	                   	<input type="hidden" id="OPENID" name="OPENID" value="${OPENID}">
	                   	<input type="hidden" id="USERTYPE" name="USERTYPE" value="2">
	               </div>
	           </div>
	           <div class="form-item gray__border">
					<label class="form-label">企业名称</label>
					<div class="form-content">
						<div class="form-input">
							<input type="text" autocomplete="off" name="NAME" id="NAME" autofocus="autofocus" class="form-input__inner">
						</div>
					</div>
				</div>
				<div class="form-item">
					<div class="form-item-half">
						<label class="form-label" style="width: 3.5rem">成立日期</label>
						<div class="form-content form-date">
							<div class="btn date" id="dateResult" data-options='{"type":"date"}'>选择日期</div>
							<div class="down-icon"></div>
							
						</div>
						
					</div>
					<input type="hidden" id="FOUDDATE" name="FOUDDATE" >
					<div class="form-item-half">
						<label class="form-label" style="width: 3.5rem">注册资本</label>
						<div class="form-content form-date">
							<div id='showmoneyPicker'>请选择资本
								<div class="down-icon"></div>
							</div>
						</div>
						<input type="hidden" name="CAPTAIL" id="CAPTAIL" autocomplete="off" class="form-input__inner">
								
					
					</div>
				</div>
				<div class="form-item gray__border">
					<label class="form-label">联系电话</label>
					<div class="form-content">
						<div class="form-input">
							<input type="number" name="TEL" id="TEL" autocomplete="off" class="form-input__inner">
						</div>
					</div>
				</div>
				<div class="form-item gray__border">
					<label class="form-label">所在地区</label>
					<div class="form-content">
						<div id='showCityPicker'>请选择您所在的地区
							<div class="down-icon"></div>
						</div>
						
						<input type="hidden" id="AREA" name="AREA" >
					</div>
				</div>
				<div class="form-item gray__border">
					<label class="form-label">营业地址</label>
					<div class="form-content">
						<div class="form-input">
							<input type="text" name="ADDRESS" id="ADDRESS" autocomplete="off" class="form-input__inner">
						</div>
					</div>
				</div>
				<div class="form-item">
					<label class="form-label" style="width: 8rem">高校毕业生创业</label>
					<div class="form-content">
						<input type="radio" name="JOB" id="JOB" value="1" checked /> 是
						<input type="radio" name="JOB" id="JOB" value="0" />否
					</div>
				</div>
				<div class="form-item">
					<label class="form-label" style="width: 8rem">复员转业退役军人</label>
					<div class="form-content">
						<input type="radio" name="ZYJR" id="ZYJR" value="1" checked /> 是
						<input type="radio" name="ZYJR" id="ZYJR" value="0" />否
					</div>
				</div>
	            
	            <div class="form-item">
	                <div class="form-register"  onclick="save();">
	                   	 注册
	                </div>
	            </div>
	        </form>
	    </main>
	</div>
	
<!-- /.main-container -->
<script src="static/weixin/js/mui.min.js"></script>
<script src="static/weixin/js/mui.picker.min.js"></script>
<script src="static/weixin/js/mui.poppicker.js"></script>
<script src="static/weixin/js/city.data.js"></script>
<script src="static/weixin/js/city.data-3.js"></script>
<script type="text/javascript">
(function ($) {
    $.init();
    var btns = $('.btn');
    var dateResult = document.getElementById('dateResult');
    btns.each(function (i, btn) {
        btn.addEventListener('tap', function () {
            var _self = this;
            if (_self.picker) {
                _self.picker.show(function (rs) {
                    console.log(rs.text);
                    dateResult.innerText = rs.text;
                    _self.picker.dispose();
                    _self.picker = null;
                    document.getElementById("FOUDDATE").value=rs.text;
                });
            } else {
                var optionsJson = this.getAttribute('data-options') || '{}';
                var options = JSON.parse(optionsJson);
                _self.picker = new $.DtPicker(options);
                _self.picker.show(function (rs) {
                    dateResult.innerText = rs.text;
                    _self.picker.dispose();
                    _self.picker = null;
                    document.getElementById("FOUDDATE").value=rs.text;
                });
            }

        }, false);
    });
    
 // 注册资本
	var moneyPicker = new $.PopPicker();
	moneyPicker.setData([{
		value: '1',
		text: '500-1000w'
	}, {
		value: '2',
		text: '1000-2000w'
	}, {
		value: '3',
		text: '2000-3000w'
	}, {
		value: '4',
		text: '3000-4000w'
	}, {
		value: '5',
		text: '4000-5000w'
	}, {
		value: '6',
		text: '5000-6000w'
	}]);
	var showmoneyPickerButton = document.getElementById('showmoneyPicker');
	showmoneyPickerButton.addEventListener('tap', function (event) {
		moneyPicker.show(function (items) {
			console.log(items[0])
			showmoneyPickerButton.innerText = _getParam(items[0], 'text');
			//alert(items[0].value);
			 document.getElementById("CAPTAIL").value=items[0].value;
			//返回 false 可以阻止选择框的关闭
			//return false;
		});
	}, false);
	
    var _getParam = function (obj, param) {
        return obj[param] || '';
    };
    var cityPicker = new $.PopPicker({
        layer: 3
    });
    cityPicker.setData(cityData3);
    var showCityPickerButton = document.getElementById('showCityPicker');
    showCityPickerButton.addEventListener('tap', function (event) {
        cityPicker.show(function (items) {
        	showCityPickerButton.innerText = _getParam(items[0], 'text') + " " + _getParam(
                    items[1], 'text') + " " + _getParam(items[2], 'text');
            //alert(items[1].value);
            document.getElementById("AREA").value=items[2].value;
        });
    }, false);
    
  //获取户籍所在地
	// 获取地区
	var _getParam = function (obj, param) {
	    return obj[param] || '';
	};
	var hjPicker = new $.PopPicker({
	    layer: 3
	});
	hjPicker.setData(cityData3);
	var showhjPickerButton = document.getElementById('showhjPicker');
	showhjPickerButton.addEventListener('tap', function (event) {
	    hjPicker.show(function (items) {
	        console.log(items);
	        showhjPickerButton.innerText = _getParam(items[0], 'text') + " " + _getParam(
	            items[1], 'text') + " " + _getParam(items[2], 'text');
	    });
	}, false);
	
	// 企业规模
	var companyPicker = new $.PopPicker();
	companyPicker.setData([{
		value: '1',
		text: '特大型'
	}, {
		value: '2',
		text: '大型'
	}, {
		value: '3',
		text: '中型'
	}, {
		value: '4',
		text: '小型'
	}, {
		value: '5',
		text: '微型'
	}]);
	var showcompanyPickerButton = document.getElementById('showcompanyPicker');
	showcompanyPickerButton.addEventListener('tap', function (event) {
		companyPicker.show(function (items) {
			console.log(items[0])
			showcompanyPickerButton.innerText = _getParam(items[0], 'text');
			//返回 false 可以阻止选择框的关闭
			//return false;
		});
	}, false);
    
})(mui);
</script>
<script type="text/javascript">
		//$(top.hangge());
		//保存
		function save(){
			//alert(cityPicker.getSelectedItems());
			var FOUDDATE=document.getElementById('dateResult').innerHTML;
			//alert(FOUDDATE);
			if($("#NAME").val()==""){
				alert("姓名不能为空");
				$("#NAME").focus();
				return false;
			}
			
			if($("#AREA").val()==""){
				alert("请选择地区");
				$("#AREA").focus();
				return false;
			}
			
			if($("#TEL").val()==""){
				alert("请输入联系电话");
				$("#TEL").focus();
				return false;
			}
			
			
			$.ajax({
            //几个参数需要注意一下
            
            	type: "POST",//方法类型
                dataType: "html",//预期服务器返回的数据类型
             	url: "appweixin/saveZcinfo" ,//url
                data: $('#Form_add').serialize(),
                success: function (result) {
                  //  console.log(result.);//打印服务端返回的数据(调试用)
                    if (result.indexOf("success")>=0) {
                    	alert("注册成功");
WeixinJSBridge.call('closeWindow');

                    }else{
                    	alert("注册失败，已注册");
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