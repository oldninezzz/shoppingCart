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
    <script src="${pageContext.request.contextPath}/js/jquery-3.5.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>

</head>
<style>
    .logo{
        display: flex;
        width: 100px;
        left: 50%;
        top: 0;
        transform: translateX(-50%);
        position: relative;

    }
    .logo>img{
        flex: auto;
        border-radius: 35px;
    }
</style>
<body style="background-color: #969996">
    <div class="holder border border-bottom-0" style="width: 500px;position: absolute;top: 50%;left:50%;transform: translateX(-50%) translateY(-50%);background-color: #dfe8ec">
        <form action="/shoppingCart/UserLoginCheck" method="post" style="padding: 10%;position: relative" id="form">
            <div class="logo">
                <img src="${pageContext.request.contextPath}/img/test_logo.png" width="100px" height="100px">
            </div>
            <div class="form-group">
                <label for="usr">用户名:</label>
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-user-circle-o fa-lg" aria-hidden="true"></i></span>
                    <input type="text" class="form-control" id="usr" placeholder="请输入您的账号" name="username">
                </div>
                <span id="isexist" style="color: red"></span>
            </div>
            <div class="form-group">
                <label for="pwd">密码:</label>
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-lock fa-lg"  style="width: 18px" aria-hidden="true"></i></span>
                    <input type="password" id="pwd" name="password" class="form-control" placeholder="请输入您的密码">
                </div>
            </div>
            <label for="code">验证码:</label>
            <div class="form-group">
                <input type="text" class="form-control" style="float: left;width: 35%" id="code" name="code">
                <img id="codeImg" style="margin-left: 10px;border-radius: 4px" src="/shoppingCart/GenerateCode">
                <a href="javascript:change()">换一张</a><br>
            </div>

            <button type="button" class="btn btn-primary float-left" onclick="check()">登录</button>
            <a href="/shoppingCart/register.jsp" class="float-right">没有账号？立即注册</a>
        </form>
    </div>
    <script>
        function change(){
            var t = new Date();
            document.getElementById("codeImg").src = "/shoppingCart/GenerateCode?seed="+t.getTime();
        }
        function codeCheck(){
            if(document.getElementById("code").value==""){
                alert("验证码不能为空");
                return;
            }

            var xmlHttp;
            if(window.XMLHttpRequest) { //如果是ie7以上浏览器，使用new new XMLHttpRequest()创建对象
                xmlHttp = new XMLHttpRequest();
            }
            else { //如果是ie7以下使用new new XMLHttpRequest()创建对象
                xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
            }

            xmlHttp.onreadystatechange = function () {
                if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {

                    if (xmlHttp.responseText == "1") {//从服务端端返回的字符串如果为1，则判定输入验证码正确
                        // document.getElementById("form").submit();
                        pwdCheck();
                    }
                    else {
                        alert("验证码不正确");
                        change();
                        document.getElementById("code").value = "";
                    }
                }
            }

            var v =document.getElementById("code").value;

            xmlHttp.open("GET", "/shoppingCart/ValidateCode?code=" + v, true);
            xmlHttp.send();
        }
        function pwdCheck(){
            var xmlHttp;
            if(window.XMLHttpRequest) { //如果是ie7以上浏览器，使用new new XMLHttpRequest()创建对象
                xmlHttp = new XMLHttpRequest();
            }
            else { //如果是ie7以下使用new new XMLHttpRequest()创建对象
                xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
            }

            xmlHttp.onreadystatechange = function () {
                if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {
                    // document.getElementById("isexist").innerHTML = xmlHttp.responseText;
                    if(xmlHttp.responseText == "1"){
                        document.getElementById("isexist").innerHTML = "用户名或密码错误！";
                        change();
                        document.getElementById("code").value = "";
                    }
                    else if(xmlHttp.responseText == "2"){
                        document.getElementById("isexist").innerHTML = "用户名或密码错误！";
                        // alert("用户不存在");
                        change();
                        document.getElementById("code").value = "";
                    }
                    else{
                        document.getElementById("form").submit();
                    }

                }

            }
            xmlHttp.open("GET", "/shoppingCart/UserLoginCheck?username=" + document.getElementById("usr").value+"&password="+document.getElementById("pwd").value, true);
            xmlHttp.send();
        }
        function check() {
            codeCheck();
        }
        // function isExisted(){
        //
        // }
    </script>
</body>
</html>
