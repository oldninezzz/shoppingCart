<%--
  Created by IntelliJ IDEA.
  User: 83651
  Date: 2021/4/17
  Time: 0:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>匋宝——登录页面</title>
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/font-awesome-4.7.0/css/font-awesome.css">
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery-3.5.1.min.js"></script>
</head>
<body style="background-color: #969996">
    <div class="holder border border-bottom-0" style="width: 500px;position: absolute;top: 50%;left:50%;transform: translateX(-50%) translateY(-50%);background-color: #dfe8ec">
        <div>

        </div>
        <form action="/shoppingCart/ValidateCode" method="post" style="padding: 10%">
            <div class="form-group">
                <label for="usr">用户名:</label>
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-user-circle-o fa-lg" aria-hidden="true"></i></span>
                    <input type="text" class="form-control" id="usr" placeholder="请输入您的账号" name="username">
                </div>
            </div>
            <div class="form-group">
                <label for="pwd">密码:</label>
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-lock fa-lg"  style="width: 18px" aria-hidden="true"></i></span>
                    <input type="text" id="pwd" name="password" class="form-control" placeholder="请输入您的密码">
                </div>
            </div>
            <label for="code">验证码:</label>
            <div class="form-group">
                <input type="text" class="form-control" style="float: left;width: 35%" id="code" name="code">
                <img id="codeImg" style="margin-left: 10px;border-radius: 4px" src="/shoppingCart/GenerateCode">
                <a href="javascript:change()">换一张</a><br>
            </div>

            <button type="button" class="btn btn-primary float-left" onclick="submit()">登录</button>
            <a href="/shoppingCart/register.jsp" class="float-right">没有账号？立即注册</a>
        </form>
    </div>
    <script>
        function change(){
            var t = new Date();
            document.getElementById("codeImg").src = "/shoppingCart/GenerateCode?seed="+t.getTime();
        }
        function submit() {
            var code = document.getElementById("code").value;
            if(qrcode == null || '' == qrcode){
                alert("请输入验证码");
                return;
            }
            var xmlhttp;
            if (window.XMLHttpRequest)
            {
                //  IE7+, Firefox, Chrome, Opera, Safari 浏览器执行代码
                xmlhttp=new XMLHttpRequest();
            }
            else
            {
                // IE6, IE5 浏览器执行代码
                xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
            }
            xmlhttp.onreadystatechange=function()
            {
                if (xmlhttp.readyState==4 && xmlhttp.status==200)
                {
                    var rtn = '<%=session.getAttribute("rtn")%>';
                    if("success" != rtn){
                        alert("验证码输入错误！");
                        document.getElementById("code").value = "";
                    }
                    <%session.setAttribute("rtn","");%>
                }
            }
            // get请求，路径contextPath/judgeQrcode?qrcode=qrcode，不异步提交
            xmlhttp.open("GET","/shoppingCart/ValidateCode",false);
            xmlhttp.send();
        }
    </script>
</body>
</html>
