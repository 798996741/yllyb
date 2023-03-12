<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
<!-- jsp文件头和头部 -->

</head>
<body class="no-skin">
<!-- /section:basics/navbar.layout -->
<div class="main-container" id="main-container">
	<!-- /section:basics/sidebar -->
	<div class="main-content">
		<div class="main-content-inner">
			<div class="page-content">
				<div class="row">
					<div class="col-xs-12">
						<form action="role/${msg}.do" name="form1" id="form1_add"  method="post">
						<input type="hidden" name="ROLE_ID" id="id" value="${pd.ROLE_ID}"/>
						<input name="PARENT_ID" id="parent_id" value="${pd.parent_id }" type="hidden">
							<div id="zhongxin" style="padding-top:13px;">
							<table class="center" style="width:100%;">
								<tr style="text-align: center;">
									<td><input type="text" name="ROLE_NAME" id="roleName" placeholder="这里输入名称" value="${pd.ROLE_NAME}"  title="名称" style="width:99%;"/></td>
								</tr>
								<tr>
									<td style="text-align: center;padding-top:5px;">
										<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
										<a class="btn btn-mini btn-danger"  data-btn-type="cancel" data-dismiss="modal">取消</a>
									</td>
								</tr>
							</table>
							</div>
						</form>
					
					<div id="zhongxin2" class="center" style="display:none"><img src="static/images/jzx.gif" style="width: 50px;" /><br/><h4 class="lighter block green"></h4></div>

					</div>
					<!-- /.col -->
				</div>
				<!-- /.row -->
			</div>
			<!-- /.page-content -->
		</div>
	</div>
	<!-- /.main-content -->
</div>
<!-- /.main-container -->


	<script type="text/javascript">
	//top.hangge();
	//保存
	function save(){
		if($("#roleName").val()==""){
			$("#roleName").tips({
				side:3,
	            msg:'请输入',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#roleName").focus();
			return false;
		}
		
		$.ajax({
        	//几个参数需要注意一下
            type: "POST",//方法类型
            dataType: "html",//预期服务器返回的数据类型
            url: "role/${msg}.do" ,//url
            data: $('#form1_add').serialize(),
            success: function (result) {
              //  console.log(result.);//打印服务端返回的数据(调试用)
                if (result.indexOf("success")>=0) {
                	document.location.reload();
                }},
                error : function() {
                    alert("异常！");
                }
            });
		//$("#form1_add").submit();
		
	}
	
	
	</script>
</body>
</html>

