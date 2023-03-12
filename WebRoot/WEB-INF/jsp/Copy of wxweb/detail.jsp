<%@ page language="java" contentType="text/html ; charset=UTF-8" pageEncoding="UTF-8" %>
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
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8"/>
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
			$('.detail-material_nav ul li').click(function () {
				$('.detail-material__wrapper ul li').hide();
				$('.detail-material__wrapper ul li').eq($(this).index()).show();
			});
			$('.detail-material_nav ul li').eq(0).trigger("click");
			
		});
  </script>
</head>
<body>
	<div class="detail-bg">
		<header class="detail-header"></header>
		<main>
			<div class="detail-cont">
				<div class="detail-block">
					<div class="detail-title color-green gray__border">
						● ${zskBean.zstitle}
						<a href="appweixin/template?action=sbbt" class="common-question">
							<img src="static/weixin/images/question_btn.png" />
						</a>
					</div>
					<div class="detail-org color-blue gray__border bold">
						申报机构
						<div class="arrow-icon"></div>
					</div>
					<div class="detail-org-cont">
						符合条件的就业困难人员按规定按时足额缴纳灵活就业社会保险费后，向户口所在地社区（村）劳动保障工作站申请对当年已缴纳的灵活就业社会保险费给予补贴。就业困难人员户口不在社会保险接续地的，直接向接续社会保险关系的同级劳动就业服务机构申报。
					</div>
				</div>
				<div class="detail-block">
					<div class="detail-org color-blue bold">申请材料</div>
					<div class="detail-material">
						<div class="detail-material_nav">
							<ul>
								<li class="order-bg order-bg-one">
									<p>《灵活就业的就业困难人员享受社会保险补贴申报表》</p>
								</li>
								<li class="order-bg order-bg-two">
									<p>《就业失业登记证》或《就业创业证》</p>
								</li>
								<li class="order-bg order-bg-three">
									<p>本人社保卡或银行卡卡面复印件</p>
								</li>
								<li class="order-bg order-bg-four">
									<p>证明本人已缴纳当年灵活就业养老保险、医疗保险的缴费凭证</p>
								</li>
								
							</ul>
						</div>
						<div class="detail-material__wrapper">
							<ul>
								<li class="detail-material__item">
									<div class="detail-material__title color-blue gray__border">
										灵活就业的就业困难人员享受社会保险补贴申报表材料详情
									</div>
									<div class="detail-material__content">
										<div class="material-content__item color-blue gray__border">
											| 材料模板
											<a href="appweixin/template?action=rdsqb" class="detail-material__look">
												<img src="static/weixin/images/look.png">
											</a>
										</div>
										<div class="material-content__item color-blue gray__border">
											| 材料来源
											<a href="appweixin/detail?action=djz" class="detail-material__todo">
												<img src="static/weixin/images/todo.png">
											</a>
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
										《就业失业登记证》或《就业创业证》材料详情
									</div>
									<div class="detail-material__content">
										<div class="material-content__item color-blue gray__border">
											| 材料模板
											<a href="appweixin/template?action=sydjz" class="detail-material__look">
												<img src="static/weixin/images/look.png">
											</a>
										</div>
										<div class="material-content__item color-blue gray__border">
											| 材料来源
											<a href="appweixin/detail?action=djz" class="detail-material__todo">
												<img src="static/weixin/images/todo.png">
											</a>
										</div>
										<div class="detail-material__detail">
											<p>请您点击上方“如何办”小宝会告知办理流程，备齐材料后前往所在区的人社局即可办理领取《就业失业登记证》。</p>
										</div>
										<div class="material-content__item color-blue gray__border">
											| 材料要求
										</div>
										<div class="detail-material__detail">
											<p>要求：纸质原件及复印件</p>
											<p>份数：各1份</p>
										</div>
									</div>
								</li>
								<li class="detail-material__item">
									<div class="detail-material__title color-blue gray__border">
										本人社保卡或银行卡卡面复印件
									</div>
									<div class="detail-material__content">
										<div class="material-content__item color-blue gray__border">
											| 材料模板
											<!--<a class="detail-material__look">
												<img src="src="static/weixin/images/look.png">
											</a>-->
										</div>
										<div class="material-content__item color-blue gray__border">
											| 材料来源
											<!--<a class="detail-material__todo">
												<img src="images/todo.png">
											</a>-->
										</div>
										<div class="detail-material__detail">
											<p>请前往社保中心或海峡银行办理社保卡或银行卡</p>
										</div>
										<div class="material-content__item color-blue gray__border">
											| 材料要求
										</div>
										<div class="detail-material__detail">
											<p>要求：本人社保卡或银行卡卡面复印件</p>
											<p>份数：各1份</p>
										</div>
									</div>
								</li>
								<li class="detail-material__item">
									<div class="detail-material__title color-blue gray__border">
										证明本人已缴纳当年灵活就业养老保险、医疗保险的缴费凭证
									</div>
									<div class="detail-material__content">
										<div class="material-content__item color-blue gray__border">
											| 材料模板
											<a href="appweixin/template?action=sydjz" class="detail-material__look">
												<img src="src="static/weixin/images/look.png">
											</a>
										</div>
										<div class="material-content__item color-blue gray__border">
											| 材料来源
											<!--<a class="detail-material__todo">
												<img src="images/todo.png">
											</a>-->
										</div>
										<div class="detail-material__detail">
											<p>请前往缴费机构（税务局、社保机构、银行）打印缴费凭据</p>
										</div>
										<div class="material-content__item color-blue gray__border">
											| 材料要求
										</div>
										<div class="detail-material__detail">
											<p>要求：复印件</p>
											<p>份数：各1份</p>
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
						<p>1.《毕业生就业报到证》已注明就业单位，但毕业生非因本人原因未就业的，需另提供解除就业协议证明和市、县（市）区公共就业和人才服务机构开具的档案寄存证明；</p>
						<p>2.未登记就业者需提供《就业失业登记证》（或《就业创业证》原件、复印件；</p>
						<p>温馨提示：不知如何办理《就业失业登记证》或《就业创业证》，可返回咨询界面向小宝提问。小宝将会告知您具体办理流程与所需材料。</p>
					</div>
				</div>
			</div>
		</main>
		<footer class="site-footer"></footer>
	</div>
</body>
</html>