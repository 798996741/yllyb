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
	                   	个人用户
	                   	<input type="hidden" id="OPENID" name="OPENID" value="${OPENID}">
	                   	<input type="hidden" id="USERTYPE" name="USERTYPE" value="1">
	               </div>
	           </div>
	           <div class="form-item">
	               <label class="form-label">性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别</label>
	               <div class="form-content">
	                   <input type="radio" name="SEX" id="SEX1" value="1" checked /> 男
	                   <input type="radio" name="SEX" id="SEX2" value="2" /> 女
	               </div>
	           </div>
	           <div class="form-item">
	               <div class="form-item-half">
	                   <label class="form-label" style="width: 3.5rem">姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名</label>
	                   <div class="form-content">
	                       <div class="form-input">
	                           <input type="text" name="NAME" id="NAME"  autocomplete="off" class="form-input__inner">
	                       </div>
	                   </div>
	               </div>
	               <div class="form-item-half">
	                   <label class="form-label" style="width: 3.5rem">年&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;龄</label>
	                    <div class="form-content">
	                        <div class="form-input">
	                            <input type="number" autocomplete="off" name="AGE" id="AGE" class="form-input__inner">
	                        </div>
	                    </div>
	                </div>
	            </div>
	            <div class="form-item gray__border">
	                <label class="form-label">所在地区</label>
	                <div class="form-content">
	                    <div id='showCityPicker'>请选择您所在的地区</div>
	                    <div class="down-icon"></div>
	                    <input type="hidden" id="AREA" name="AREA" >
	                </div>
	            </div>
	            <div class="form-item gray__border">
	                <label class="form-label">地&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;址</label>
	                <div class="form-content">
	                    <div class="form-input">
	                        <input type="text" autocomplete="off" name="ADDRESS" id="ADDRESS" class="form-input__inner">
	                    </div>
	                </div>
	            </div>
	            <div class="form-item gray__border">
	                <label class="form-label">联系电话</label>
	                <div class="form-content">
	                    <div class="form-input">
	                        <input type="number" autocomplete="off" name="TEL" id="TEL" class="form-input__inner">
	                    </div>
	                </div>
	            </div>
	            <div class="form-item">
					<label class="form-label" style="width: 7rem">高校毕业生就业</label>
					<div class="form-content">
						<input type="radio" name="JOB" id="JOB" value="1" checked /> 就业
						<input type="radio" name="JOB" id="JOB"  value="0" />失业
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
<script>
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
                });
            } else {
                var optionsJson = this.getAttribute('data-options') || '{}';
                var options = JSON.parse(optionsJson);
                _self.picker = new $.DtPicker(options);
                _self.picker.show(function (rs) {
                    dateResult.innerText = rs.text;
                    _self.picker.dispose();
                    _self.picker = null;
                });
            }

        }, false);
    });
    var cityPicker = new $.PopPicker({
        layer: 2
    });
    cityPicker.setData(cityData);
    var showCityPickerButton = document.getElementById('showCityPicker');
    showCityPickerButton.addEventListener('tap', function (event) {
        cityPicker.show(function (items) {
            showCityPickerButton.innerText = items[0].text + " " + items[1].text;
            //alert(items[1].value);
            document.getElementById("AREA").value=items[1].value;
        });
    }, false);
})(mui);
</script>
<script type="text/javascript">
		//$(top.hangge());
		//保存
		function save(){
			//alert(cityPicker.getSelectedItems());
			//alert(document.getElementById('showCityPicker').value);
			
			if($("#NAME").val()==""){
				alert("姓名不能为空");
				$("#NAME").focus();
				return false;
			}
			var SEX=$('input:radio[name="SEX"]:checked').val(); 
			if(SEX==""){
				alert("请选择性别");
				$("#SEX").focus();
				return false;
			}
			if($("#AGE").val()==""){
				alert("请输入年龄");
				$("#AGE").focus();
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
			var JOB=$('input:radio[name="JOB"]:checked').val(); 
			if(JOB==""){
				alert("请选择高校毕业生就业");
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