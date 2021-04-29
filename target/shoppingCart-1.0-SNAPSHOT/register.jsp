<%--
  Created by IntelliJ IDEA.
  User: 83651
  Date: 2021/4/17
  Time: 15:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>匋宝——注册页面</title>
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/font-awesome-4.7.0/css/font-awesome.css">
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery-3.5.1.min.js"></script>
</head>
<body>
    <div class="holder border border-bottom-0" style="width: 500px;position: absolute;top: 50%;left:50%;transform: translateX(-50%) translateY(-50%);background-color: #dfe8ec">
        <form action="/shoppingCart/UserRegister" method="post" style="padding: 10%" id="form">
            <div class="form-group">
                <label for="usr">设置用户名:</label>
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-user-circle-o fa-lg" aria-hidden="true"></i></span>
                    <input type="text" class="form-control" id="usr" placeholder="请设置您的用户名" name="username">
                </div>
            </div>
            <div class="form-group">
                <label for="pwd">设置密码:</label>
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-lock fa-lg"  style="width: 18px" aria-hidden="true"></i></span>
                    <input type="password" id="pwd" name="password" class="form-control" placeholder="请设置您的密码">
                </div>
            </div>
            <div class="form-group">
                <label for="pwd">再次输入密码:</label>
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-lock fa-lg"  style="width: 18px" aria-hidden="true"></i></span>
                    <input type="password" id="pwd2" name="password2" class="form-control" placeholder="请再次输入您的密码">
                </div>
            </div>
            <button onclick="check()" class="btn btn-primary float-left" type="button">注册</button>
        </form>

    </div>
    <script>
        function check(){
            let p1 = document.getElementById("pwd").value;
            let p2 = document.getElementById("pwd2").value;
            console.log(p1);
            console.log(p2);
            if(p1 != p2){
                document.getElementById("pwd").value = "";
                document.getElementById("pwd2").value = "";
                alert("两次输入的密码不一致，请重新输入！");
            }
            else{
                document.getElementById("form").submit();
            }
        }
    </script>
</body>
</html>
