<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
<meta charset="utf-8" />
<meta name="App-Config" content="fullscreen=yes,useHistoryState=yes,transition=yes" />
<meta content="yes" name="apple-mobile-web-app-capable" />
<meta content="yes" name="apple-touch-fullscreen" />
<meta content="telephone=no,email=no" name="format-detection" />
<meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no" />
<script src="http://g.tbcdn.cn/mtb/lib-flexible/0.3.4/??flexible_css.js,flexible.js"></script>
<script src="static/js/jquery-1.7.2.js"></script>
<link rel="stylesheet" type="text/css" href="static/weixin/css/common.css" />

<script>
$(function () {
	$('.detail-org').click(function () {
				$(this).toggleClass('active').next().toggle();
			});
			$('.detail-left li').click(function () {
				$('.detail-material__wrapper li').hide();
				$('.detail-material__wrapper li').eq($(this).index()).show();
			});
			$('.detail-left li').eq(0).trigger("click");
});

  </script>
</head>
<body>
	<div class="detail-bg">
		<header class="detail-header"></header>
		<main>
			<div class="detail-cont">
				<div class="detail-block">
					<div class="detail-cont-title color-blue gray__border">
						就业困难人员认定对象
					</div>
					<div class="detail-cont-word">
						<p class="bold color-black">失业登记对象包括下列人员：</p>
						<p>（1）年满16周岁，从各类学校毕业、肄业未就业的；</p>
						<p>（2）从各类用人单位就业转失业的；</p>
						<p>（3）个体工商户业主或私营企业主停业、破产停止经营的；</p>
						<p>（4）灵活就业人员中断就业的；</p>
						<p>（5）承包土地被征用并符合规定条件的；</p>
						<p>（6）军人退出现役且未纳入国家统一安置的，随军家属未就业的；</p>
						<p>（7）刑满释放、假释或监外执行未就业的；</p>
						<p>（8）农村进城人员登记失业的；</p>
						<p>（9）毕业年度内高校毕业生离校后未就业的；</p>
						<p>（10）离校1年内高校毕业生未就业的；</p>
						<p>（11）毕业5年内高校毕业生未就业的。</p>
						<p class="bold color-black">就业援助对象包括以下人员：</p>
						<p>（1）国有企业下岗失业人员；</p>
						<p>（2）国有企业关闭破产需要安置人员；</p>
						<p>（3）国有企业所办集体企业下岗职工；</p>
						<p>（4）城镇零就业家庭成员；</p>
						<p>（5）男满50周岁、女满40周岁大龄城镇居民；</p>
						<p>（6）持有第二代残疾人证的城镇居民；</p>
						<p>（7）城市最低生活保障对象；</p>
						<p>（8）失业登记后连续失业一年以上的城镇居民；</p>
						<p>（9）已参加失业保险并失业登记后连续失业一年以上的农村进城务工劳动者；</p>
						<p>（10）城市规划区内的农村新被征地农民；</p>
						<p>（11）农村最低生活保障对象；</p>
						<p>（12）持有第二代残疾人证的农村居民；</p>
						<p>（13）农村实行计划生育的独生子女户、二女户中，男年满40周岁以上、女年满30周岁以上人员；</p>
						<p>（14）享受城镇居民最低生活保障且失业一年以上的城镇登记失业人员。</p>
						<p>（15）农村平均家庭劳动力</p>

					</div>
				</div>
			</div>
		</main>
		<footer class="site-footer"></footer>
	</div>
</body>
</html>