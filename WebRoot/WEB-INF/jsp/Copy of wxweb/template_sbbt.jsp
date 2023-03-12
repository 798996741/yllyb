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
    $('.detail-question').click(function () {
        $('.detail-question').removeClass('active');
        $(this).toggleClass('active');

        if ($(this).next().css("display") == "block") {
            $(this).next().hide();
            $('.question-cont').hide();
        } else {
            $('.question-cont').hide();
            $(this).next().show();
        }
    })
});

  </script>
</head>
<body>
	<div class="detail-bg">
        <header class="detail-header"></header>
        <main class="page-main">
            <div class="detail-cont">
                <div class="detail-block">
                    <div class="detail-title color-blue gray__border">
                        ● 就业困难人员社会保险补贴常见问题
                    </div>
                    <ul>
                        <li>
                            <div class="detail-question color-gray gray__border">
                                <div class="detail-question-title">1、就业困难人员补贴标准是多少？</div>
                                <div class="arrow-icon"></div>
                            </div>
                            <div class="question-cont">
                                <p>以下为2018年补贴标准供您参考：</p>
                                <p>个人补贴：城镇职工基本养老保险没人每月260元，基本医疗保险费每人每月182.23元。全年一次性发放，合计5306.76元。</p>
                                <p>单位补贴：给予用人单位基本养老险费、基本医疗保险费和失业保险费补贴，每人每月995.51元，分季度发放，合计11946.12/年。</p>
                            </div>
                        </li>
                        <li>
                            <div class="detail-question color-gray gray__border">
                                <div class="detail-question-title">2、就业困难人员灵活就业社会保险补贴资金如何拨付？</div>
                                <div class="arrow-icon"></div>
                            </div>
                            <div class="question-cont">
                                <p>每季，经本人申请、社区受理、街道初审、区、县（市）劳动保障部门审核，市及区、县（市）财政部门复核后，由财政部门将补贴资金拨付到指定的银行，通过银行将补贴发放给个人。</p>
                                <p>就业困难人员灵活就业社会保险补贴采用先缴后补、按季拨付的办法。</p>
                            </div>
                        </li>
                        <li>
                            <div class="detail-question color-gray gray__border">
                                <div class="detail-question-title">3、就业困难人员灵活就业社会保险补贴标准是如何规定的？</div>
                                <div class="arrow-icon"></div>
                            </div>
                            <div class="question-cont">
                                <p>就业困难人员灵活就业基本养老保险和基本医疗保险缴费基数为全市统一规定的缴费基数，其社会保险补贴标准为：</p>
                                <p>“4050”以上的人员，基本养老保险补贴其缴费基数的12%；基本医疗保险缴费比例低于6%的，全额补贴，缴费比例达到或超过6%的，补贴其缴费基数的6%。</p>
                                <p>“4050”以下的人员，基本养老保险补贴其缴费基数的8%，基本医疗保险补贴其缴费基数的3%。</p>
                            </div>
                        </li>
                        <li>
                            <div class="detail-question color-gray gray__border">
                                <div class="detail-question-title">4、就业困难人员灵活就业社会保险补贴的期限是如何规定的？</div>
                                <div class="arrow-icon"></div>
                            </div>
                            <div class="question-cont">
                                <p>持《登记证》的就业困难人员，从发证并认定的次月起享受补贴，补贴期限最长不超过3年。对从审批具备享受资格之日距法定退休年龄不足5年的就业困难人员灵活就业社会保险补贴可延长至法定退休年龄（审批具备享受资格之日以最终审核部门批准时间为准）。</p>
                                <p>对2009年1月1日至2010年12月31日期间享受社会保险补贴政策期满，仍未能实现稳定就业的灵活就业人员，一次性延长社会保险补贴期限，最长不超过1年。</p>
                            </div>
                        </li>
                        <li>
                            <div class="detail-question color-gray gray__border">
                                <div class="detail-question-title">5、持《再就业优惠证》的灵活就业人员可否继续享受灵活就业社会保险补贴？</div>
                                <div class="arrow-icon"></div>
                            </div>
                            <div class="question-cont">
                                <p>2008年12月31日前领取《再就业优惠证》且享受灵活就业社会保险补贴政策未满3年的，按规定换发全国统一的《就业失业登记证》后，继续享受政策至期满。持《再就业优惠证》享受灵活就业社会保险补贴政策期满的，不能再享受社会保险补贴。</p>
                            </div>
                        </li>
                        <li>
                            <div class="detail-question color-gray gray__border">
                                <div class="detail-question-title">6、领取失业保险金期间的失业人员，可否申领灵活就业社会保险补贴？</div>
                                <div class="arrow-icon"></div>
                            </div>
                            <div class="question-cont">
                                <p>领取失业保险金期间的失业人员仍处于失业状态的，不得同时申领灵活就业社会保险补贴。</p>
                            </div>
                        </li>
                    </ul>
                    <!-- <div class="question-more">
                        更多问题 ＞＞
                    </div> -->
                </div>
            </div>
        </main>
        <footer class="site-footer"></footer>
    </div>
</body>
</html>