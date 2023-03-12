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
function search(action){
	location.href="appweixin/template?action=rddj";
}
  </script>
</head>
<body>
	<div class="detail-bg">
		<header class="detail-header"></header>
		<main>
			<div class="detail-cont">
				<div class="detail-block">
					<div class="detail-title color-green gray__border">
						● 就业困难人员认定登记如何办理
						<div class="common-question">
							<img src="static/weixin/images/question_btn.png" />
						</div>
					</div>
					<div class="detail-org color-blue gray__border bold">
						申报机构
						<div class="arrow-icon"></div>
					</div>
					<div class="detail-org-cont">
						符合就业困难人员条件对象的，可向户口所在地的社区（村）劳动保障工作平台申请登记。
					</div>
				</div>
				<div class="detail-block">
					<div class="detail-org color-blue bold">申请材料</div>
					<div class="detail-material">
						<ul class="detail-left">
							<li class="order-bg order-bg-one">
								<p>《福州市就业困难人员认定申请表》</p>
							</li>
							<li class="order-bg order-bg-two">
								<p>户口簿及身份证</p>
							</li>
							<li class="order-bg order-bg-three">
								<p>《就业创业证》或《就业失业登记证》</p>
							</li>
							<li class="order-bg order-bg-four">
								<p>《福州市失业登记表》</p>
							</li>
							<div class="order-more">
								点击查看更多 ＞＞
							</div>
						</ul>
						<div class="detail-right">
							<ul class="detail-material__wrapper">
								<li class="detail-material__item">
									<div class="detail-material__title color-blue gray__border">
										《福州市就业困难人员认定申请表》材料详情
									</div>
									<div class="detail-material__content">
										<div class="material-content__item color-blue gray__border">
											| 材料模板
											<a href="appweixin/template?action=rdsqb" class="detail-material__look"></a>
										</div>
										<div class="material-content__item color-blue gray__border">
											| 材料来源
											<div class="detail-material__todo"></div>
										</div>
										<div class="detail-material__detail">
											<p>您可在住所所属社区单位领取纸质表单，参考模板填写即可。若有疑问，可继续提问小宝机器人，他会辅助您填写。</p>
										</div>
										<div class="material-content__item color-blue gray__border">
											| 材料要求
										</div>
										<div class="detail-material__detail">
											<p>要求：纸质原件</p>
											<p>份数：1份</p>
										</div>
									</div>
								</li>
								<li class="detail-material__item">
									<div class="detail-material__title color-blue gray__border">
										《户口簿及身份证》材料详情
									</div>
									<div class="detail-material__content">
										<div class="material-content__item color-blue gray__border">
											| 材料模板
											<div class="detail-material__look"></div>
										</div>
										<div class="material-content__item color-blue gray__border">
											| 材料来源
											<div class="detail-material__todo"></div>
										</div>
										<div class="detail-material__detail">
											<p>请前往户口所在地的公安局领取</p>
										</div>
										<div class="material-content__item color-blue gray__border">
											| 材料要求
										</div>
										<div class="detail-material__detail">
											<p>要求：原件、复印件</p>
											<p>份数：各1份</p>
										</div>
									</div>
								</li>
								<li class="detail-material__item">
									<div class="detail-material__title color-blue gray__border">
										《就业创业证》或《就业失业登记证》材料详情
									</div>
									<div class="detail-material__content">
										<div class="material-content__item color-blue gray__border">
											| 材料模板
											<a href="appweixin/template?action=rddj" class="detail-material__look"></a>
										</div>
										<div class="material-content__item color-blue gray__border">
											| 材料来源
											<a href="appweixin/template?action=sydjz" class="detail-material__todo"></a>
										</div>
										<div class="detail-material__detail">
											<p>请您点击上方“如何办”小宝会告知办理流程，备齐材料后前往所在区的人社局即可办理领取《就业失业登记证》。</p>
										</div>
										<div class="material-content__item color-blue gray__border">
											| 材料要求
										</div>
										<div class="detail-material__detail">
											<p>要求：原件及复印件</p>
											<p>份数：复印件2份</p>
										</div>
									</div>
								</li>
								<li class="detail-material__item">
									<div class="detail-material__title color-blue gray__border">
										《福州市失业登记表》材料详情
									</div>
									<div class="detail-material__content">
										<div class="material-content__item color-blue gray__border">
											| 材料模板
											<a href="appweixin/template?action=sydjb" class="detail-material__look"></a>
										</div>
										<div class="material-content__item color-blue gray__border">
											| 材料来源
											<div class="detail-material__todo"></div>
										</div>
										<div class="detail-material__detail">
											<p>您可在住所所属社区或街道单位领取纸质表单，参考模板填写即可。若有疑问，可继续提问小宝机器人，他会辅助您填写。</p>
										</div>
										<div class="material-content__item color-blue gray__border">
											| 材料要求
										</div>
										<div class="detail-material__detail">
											<p>要求：纸质原件</p>
											<p>份数：1份</p>
										</div>
									</div>
								</li>
							</ul>
						</div>
					</div>
				</div>
				<div class="detail-block">
					<div class="detail-more color-blue gray__border">
						属于以下情况的还需报送材料
					</div>
					<div class="detail-other-material color-gray">
						<p>1.属享受最低生活保障人员还应提供《低保证》；属残疾人还应提供《残疾人证》；</p>
						<p>2.属享受最低生活保障人员还应提供《低保证》；</p>
						<p>3.属城市规划区内的农村新征地农民，提供户籍所在地乡镇政府（街道办事处）出具的被征地证明；</p>
						<p>4.属农村转移就业困难人员中实行计划生育的独生子女户、二女绝育户中，男年满40周岁、女年满30周岁以上者，还应提供户籍所地乡镇政府（街道办事处）计生部门出具的证明；</p>
						<p>5.属登记失业的农村进城务工人员还应提供《失业保险个人缴费凭证》原件及复印件2份。</p>
					</div>
				</div>
			</div>
		</main>
		<footer class="site-footer"></footer>
	</div>
</body>
</html>