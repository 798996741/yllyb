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
					<div class="detail-title color-green gray__border">
						● 《就业失业登记证》的办理
						<div class="common-question">
							<img src="static/weixin/images/question_btn.png" />
						</div>
					</div>
					<div class="detail-org color-blue gray__border bold">
						申报机构
						<div class="arrow-icon"></div>
					</div>
					<div class="detail-org-cont">
						符合失业登记对象的人员，可前往住址所属区域的人社局办理《就业失业登记证》。
					</div>
				</div>
				<div class="detail-block">
					<div class="detail-org color-blue bold">申请材料</div>
					<div class="detail-material">
						<ul class="detail-left">
							<li class="order-bg order-bg-one">
								<p>《福州市失业登记表》</p>
							</li>
							<li class="order-bg order-bg-two">
								<p>本人福州户籍户口簿（或福州市居住证、或或福州市暂住证）</p>
							</li>
							<li class="order-bg order-bg-three">
								<p>本人二代身份证</p>
							</li>
							<li class="order-bg order-bg-four">
								<p>申请人近期免冠彩照</p>
							</li>
							<div class="order-more">
								点击查看更多 ＞＞
							</div>
						</ul>
						<div class="detail-right">
							<ul class="detail-material__wrapper">
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
											<p>您可在住所所属社区单位领取纸质表单，参考模板填写即可。若有疑问，可继续提问小宝机器人，他会辅助您填写。</p>
										</div>
										<div class="material-content__item color-blue gray__border">
											| 材料要求
										</div>
										<div class="detail-material__detail">
											<p>要求：原件</p>
											<p>份数：2份</p>
										</div>
									</div>
								</li>
								<li class="detail-material__item">
									<div class="detail-material__title color-blue gray__border">
										本人福州户籍户口簿（或福州市居住证、或或福州市暂住证）材料详情
									</div>
									<div class="detail-material__content">
										<div class="material-content__item color-blue gray__border">
											| 材料模板
											<a href="appweixin/template?action=hkp" class="detail-material__look"></a>
										</div>
										<div class="material-content__item color-blue gray__border">
											| 材料来源
											<div class="detail-material__todo"></div>
										</div>
										<div class="detail-material__detail">
											<p>可前往户口所在地公安局领取或补办。</p>
										</div>
										<div class="material-content__item color-blue gray__border">
											| 材料要求
										</div>
										<div class="detail-material__detail">
											<p>要求：复印件</p>
											<p>份数：2份</p>
										</div>
									</div>
								</li>
								<li class="detail-material__item">
									<div class="detail-material__title color-blue gray__border">
										本人二代身份证
									</div>
									<div class="detail-material__content">
										<div class="material-content__item color-blue gray__border">
											| 材料模板
											<a href="appweixin/template?action=sfz" class="detail-material__look"></a>
										</div>
										<div class="material-content__item color-blue gray__border">
											| 材料来源
											<div class="detail-material__todo"></div>
										</div>
										<div class="detail-material__detail">
											<p>可掐网户口所在地的公安局领取或补办。</p>
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
										照片材料详情
									</div>
									<div class="detail-material__content">
										<div class="material-content__item color-blue gray__border">
											| 材料模板
											<!--<div class="detail-material__look"></div>-->
										</div>
										<div class="material-content__item color-blue gray__border">
											| 材料来源
											<div class="detail-material__todo"></div>
										</div>
										<div class="detail-material__detail">
											<p>请前往专业照相馆或证件照相馆拍摄。</p>
										</div>
										<div class="material-content__item color-blue gray__border">
											| 材料要求
										</div>
										<div class="detail-material__detail">
											<p>要求：1寸和2寸彩照</p>
											<p>份数：各2份</p>
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
						<p>1.具备大专及以上学历的，另提供相应的学校毕业证书复印件2份；</p>
						<p>2.属学校毕（肄）业且未有就业经历的，另提供未有就业单位的户口簿原件及复印件2份；</p>
						<p>3.属与用人单位（雇主）终止或解除劳动关系（聘用关系）的，另提供终止或解除劳动关系（聘用关系）证明原件及复印件2份；</p>
						<p>4.属城市规划区内的被征地农民，另提供被征地农民和剩余耕地情况证明原件及复印件2份；</p>
						<p>5.属于残疾人的，另提供残疾人证原件及复印件2份；</p>
						<p>6.属于享受最低生活保障人员的，另提供低保证明原件及复印件2份；
							获取方法：请前往当地民政局开具低保证明。</p>
					</div>
				</div>
			</div>
		</main>
		<footer class="site-footer"></footer>
	</div>
</body>
</html>