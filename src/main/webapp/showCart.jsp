<%@ page import="DAO.DBoperation" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="VO.ShopInfo" %><%--
  Created by IntelliJ IDEA.
  User: 83651
  Date: 2021/4/23
  Time: 14:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <title>匋宝——购物车管理</title>
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/font-awesome-4.7.0/css/font-awesome.css">
    <script src="${pageContext.request.contextPath}/js/jquery-3.5.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>

</head>
<style>
    .holder{
        margin: 0 200px;
        top: 0;
        background-color: #ffffff;
        height: 100%;
        /*max-width: 1900px;*/
        /*min-width: 600px;*/
        position: relative;
        /*z-index: 10;*/
    }
    .logo {
        display: flex;
        width: 100px;
        left: 50px;
        top: 50px;
        position: absolute;
    }
    .logo>img{
        flex: auto;
        border-radius: 35px;
    }
    .showitems{
        transform: translateY(100px);
        margin: 0 50px;
    }
    .btn-circle{
        width: 70px;
        height: 70px;
        padding: 10px 16px;
        font-size: 24px;
        line-height: 1.33;
        border-radius: 35px;
    }
    .button-vertical{
        position: fixed;
        right: 0;
        top: 50%;
        transform: translateY(-50%);
        transition: all 0.5s ease-in-out;
        z-index: 99;
    }
    .button-vertical>div{
        margin: 50px;
    }
    .deal{
        font-size: 20px;
        width: 100px;
        top: 35px;
        float: right;
        position: relative;
        transform: translateX(-100%);
    }
    .dealblock{
        top: 50%;
        left: 50%;
        transform: translateX(-50%) translateY(-50%);
        position: absolute;
    }
    .setvalue{
        top: 50%;
        left: 50%;
        transform: translateX(-50%) translateY(-50%);
        position: absolute;
    }
    .clearAll{
        font-size: 20px;
        width: 150px;
        top: 35px;
        float: right;
        position: relative;
        transform: translateX(-110%);
    }
</style>
<body style="background-color: #dcdedc;position: relative">
    <%
        DBoperation dop = new DBoperation();
        HashMap<String, ShopInfo> shopinfo;
        try{
            shopinfo = dop.getShopInfo((String) session.getAttribute("userno"));
            session.setAttribute("shopinfo", shopinfo);
        } catch (Exception e) {
            e.printStackTrace();
        }

    %>
    <div class="logo">
        <img src="${pageContext.request.contextPath}/img/test_logo.png" width="100px" height="100px">
    </div>
    <div class="button-vertical d-flex flex-column mb-3">
        <div class="p-2"><a href="/shoppingCart/UserLogout"><button class="btn btn-danger btn-primary btn-circle" data-toggle="tooltip" data-placement="left" title="注销"><i class="fa fa-power-off" aria-hidden="true"></i></button></a></div>
        <div class="p-2"><a href="/shoppingCart/main.jsp"><button type="button" class="btn btn-primary btn-circle" data-toggle="tooltip" data-placement="left" title="继续购物"><i class="fa fa-reply" aria-hidden="true"></i></button></a></div>
    </div>
    <div class="holder">
        <button type="button" class="btn btn-success deal" data-toggle="modal" data-target="#myModal">结算</button>
        <button type="button" class="btn btn-danger clearAll" id="clearall"><i class="fa fa-trash" aria-hidden="true"></i> 清空购物车</button>
        <div class="modal fade dealblock" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" id="myModalLabel">商品结算</h4>
                    </div>
                    <div class="modal-body">
                        <h3>一共<%=dop.getTotalPay((String) request.getSession().getAttribute("userno"))%>元</h3>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button type="button" class="btn btn-primary">支付</button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal -->
        </div>
        <div class="modal fade setvalue" id="modal1" tabindex="-1" role="dialog" aria-labelledby="model1h" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" id="modal1h">商品数量修改</h4>
                    </div>
                    <div class="modal-body">
                        <div><div id="setname" style="float: left"></div><input type="text" size="4" id="setnum"></div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                        <button type="button" class="btn btn-primary" id="save">保存</button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal -->
        </div>
        <div class="showItems">
            <table class="table">
                <caption>已选购的图书</caption>
                <thead>
                <tr>
                    <th>书名</th>
                    <th>数量</th>
                    <th>单价</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${shopinfo}" var="each">
                    <tr class="active">
                        <td>${each.key}</td>
                        <td>${each.value.buynum}</td>
                        <td>¥${each.value.price}</td>
                        <td>
                            <button class="btn btn-danger delete" onclick="deleteItem(event)" id="${each.key}">删除</button>
                            <button data-whatever="${each.key}" class="btn btn-danger delete" data-toggle="modal" data-target="#modal1">修改</button>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
    <script>
        function deleteItem(e){
            let node = e.target;
            let key = node.id;
            window.location.href = "/shoppingCart/Delete?bookname="+key;
        }
        $('#clearall').click(function (){
            window.location.href = "/shoppingCart/DeleteAll";
        });
        $('#modal1').on('show.bs.modal', function (event) {
            var bu = $(event.relatedTarget);
            var val = bu.data('whatever');
            console.log(val);
            document.getElementById("setname").innerHTML = val;
            $('#setname').val(val);
        });
        $('#save').click(function (){
            if($('#setnum').val() == ""){
                alert("请输入数量！");
            }
            else if($('#setnum').val() < 0){
                alert("数量不能为负！");
            }
            else{
                $.ajax({
                    type : "post",
                    url : "/shoppingCart/SetNum",
                    // data : {bookname:$('#setname').val(), bnum:$('#setnum').val()},
                    data : "bookname="+$('#setname').val()+"&bnum="+$('#setnum').val(),
                    dataType: "Text",
                    success: function (data){
                        if(data == "1"){
                            alert("修改成功!");
                            // $('.modal1').modal("hide");
                            setTimeout(function (){
                                location.reload();
                            }, 500);
                        }
                        else{
                            alert("库存不足！");
                        }
                    }
                });
            }

        });
        $(document).ready(function(){
            $('[data-toggle="tooltip"]').tooltip();
        });
    </script>
</body>
</html>
