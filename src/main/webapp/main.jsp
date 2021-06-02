<%@ page import="VO.Userinfo" %>
<%@ page import="DAO.DBoperation" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: 83651
  Date: 2021/4/18
  Time: 20:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>匋宝——专属的购物车</title>
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/font-awesome-4.7.0/css/font-awesome.css">
<%--    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">--%>
    <script src="${pageContext.request.contextPath}/js/jquery-3.5.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
</head>
<style>
    .holder{
        margin: 0 200px;
        top: 0;
        background-color: #ffffff;
        /*height: 100%;*/
        min-height: 100%;
        /*max-width: 1900px;*/
        /*min-width: 600px;*/
        position: relative;
        z-index: 10;
    }
    .logo{
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
    .itemnum{
        position: absolute;
        right: 50px;
        bottom: 50px;
        background-color: red;
    }
    .test{
        border-radius: 20px;
        border-width: 2px;
        border-color: white;
        background-color: #bfc6bf;
        margin: 100px 50px;
        height: 200px;
        width: 300px;
        transition: all 0.25s ease-in-out;
        position: relative;
        /*flex-grow: 1;*/
    }
    .test:hover{
        transform: scale(1.2);
    }
    .test>img{
        margin-left: 20px;
    }
    .showarea{
        margin: 0 130px;
    }
    .showitems {
        /*align-content: flex-start;*/
        flex-flow: wrap;
        display: flex;
        justify-content: left;
    }
    .showitems:after{
        display:block;
        content:'';
        width:300px;
        height:0;
    }
    .changePage{
        width: 400px;
        margin: 0 auto;
        bottom: 50px;
        position: absolute;
        left: 50%;
        transform: translateX(-50%);
        display: flex;
    }
    .changePage>a{
        flex-grow: 1;
    }
    .bookname{
        font-size: 20px;
        font-family: "微软雅黑";
        text-align: center;
        text-overflow: ellipsis;
    }
    .description{
        float: right;
        padding-left: 10px;
        height: 120px;
        width: 160px;
        margin: 0;
    }
    .description>h4{
        text-align: center;
    }
    .description>p{
        text-align: center;
        font-size: 10px;
    }
    .add{
        transform: translateX(90%);
        position: relative;
    }
    .sd{
        transform: translateX(50%);
        position: relative;
    }
    .showdetail{
        top: 50%;
        left: 50%;
        transform: translateX(-50%) translateY(-50%);
        position: absolute;
    }

    /*.button-vertical:hover{*/
    /*    transform: translateX(-90%) translateY(-50%);*/
    /*}*/
</style>
<body style="background-color: #dcdedc;position: relative">
    <%
        DBoperation dop = new DBoperation();
        HashMap<String, Object> books = dop.getAllDatas();
        final int perPage = 6;
        final int totalpage = books.size()/perPage + 1;
        session.setAttribute("totalpage", totalpage);
        int booknum = 0;
        try {
            booknum = dop.getCount((String) session.getAttribute("userno"));
        } catch (Exception e) {
            e.printStackTrace();
        }
        int firIndex;
        String currentPage;
        if(request.getParameter("currentPage")==null){
            currentPage = "1";
        }
        else{
            currentPage = request.getParameter("currentPage");
        }
        session.setAttribute("currentPage", currentPage);
        int lastPage = (Integer.parseInt(currentPage)-1)>0?(Integer.parseInt(currentPage)-1):1;//上一页
        int nextPage = Math.min((Integer.parseInt(currentPage) + 1), totalpage);//下一页
        firIndex = (Integer.parseInt(currentPage)-1)*perPage;//第一条数据的索引
        int count = 0;
        HashMap<String,Object> temphash = new HashMap<String,Object>();
//        ArrayList a = new ArrayList();
        for(String key : books.keySet()){
            if(count>=firIndex && count<firIndex+perPage){
                temphash.put(key, books.get(key));
            }
            count++;
        }
        session.setAttribute("bookinfo", temphash);
    %>
    <div class="button-vertical d-flex flex-column mb-3">
        <div class="p-2"><a href="/shoppingCart/UserLogout"><button class="btn btn-danger btn-primary btn-circle" data-toggle="tooltip" data-placement="left" title="注销"><i class="fa fa-power-off" aria-hidden="true"></i></button></a></div>
        <div class="p-2"><a href="/shoppingCart/showCart.jsp"><button type="button" class="btn btn-primary btn-circle" data-toggle="tooltip" data-placement="left" title="查看购物车"><i class="fa fa-shopping-cart" aria-hidden="true"></i></button></a></div>
        <span class="badge pull-right itemnum"><%=booknum%></span>
<%--        <div class="p-2"><a><button type="button" class="btn btn-primary btn-circle"><i class="fa fa-shopping-cart" aria-hidden="true"></i></button></a></div>--%>
    </div>
    <div class="modal fade showdetail" id="modal2" tabindex="-1" role="dialog" aria-labelledby="model2h" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="modal2h"></h4>
                </div>
                <div class="modal-body">
                    <div>test</div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="addCart">加入购物车</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal -->
    </div>
    <div class="logo">
        <img src="${pageContext.request.contextPath}/img/test_logo.png" width="100px" height="100px">
    </div>
    <div class="holder">
        <div class="showarea">
            <div class="showitems" id="showbooks">

            </div>
        </div>
        <div class="changePage" id="changePage">
            <a href="/shoppingCart/main.jsp?currentPage=1"><button class="btn btn-primary" type="button">首页</button></a>
            <a href="/shoppingCart/main.jsp?currentPage=<%=String.valueOf(lastPage)%>" style="width: 68px"><button class="btn btn-primary" type="button">上一页</button></a>
            <c:forEach var="page" begin="1" end="${totalpage}" step="1" varStatus="ss">
                <c:if test="${page!=currentPage}"><a href="/shoppingCart/main.jsp?currentPage=${page}" style="width: 35px"><button class="btn btn-primary" type="button">${page}</button></a></c:if>
                <c:if test="${page==currentPage}"><a href="" style="width: 35px;pointer-events: none;" ><button class="btn btn-primary" type="button" disabled="disabled">${page}</button></a></c:if>
            </c:forEach>
            <a href="/shoppingCart/main.jsp?currentPage=<%=String.valueOf(nextPage)%>" style="width: 68px"><button class="btn btn-primary" type="button">下一页</button></a>
            <a href="/shoppingCart/main.jsp?currentPage=<%=String.valueOf(totalpage)%>" style="width: 68px"><button class="btn btn-primary" type="button">末页</button></a>
        </div>
    </div>
<%--    <%--%>
<%--        Userinfo user =  (Userinfo) session.getAttribute("userno");--%>
<%--        response.getWriter().println(user.getUsername());--%>
<%--    %>--%>
    <script>
        var bookitems = document.getElementById("showbooks");
        let c = 0;
        var para, pnode, att, imgNode;
        <c:forEach var="item" items="${bookinfo}">
            para = document.createElement("div");
            para.innerHTML = "<p class=\"bookname\">${item.value.getBookname()}</p>" + "<img src=\"/shoppingCart/img/${item.value.getBookno()}.jpg\" width=\"100px\" height=\"120px\">"+
                "<div class=\"description\"><h4>价格：¥${item.value.getPrice()}</h4><p>作者：${item.value.getAuthor()}编号：${item.key}<br>库存：${item.value.getStock()}</p></div>"+
                "<button type=\"button\" data-whatever=\"${item.value.getBookname()}\" class=\"btn btn-success sd\" data-toggle=\"modal\" data-target=\"#modal2\">查看详情</button>" +
                "<button type=\"button\" class=\"btn btn-success add\" id=\"${item.value.getBookname()}\" onclick=\"addBook(event)\">加入购物车</button>"
            att = document.createAttribute("class");
            att.value = "test";
            para.setAttributeNode(att);
            bookitems.appendChild(para);
            c++;
        </c:forEach>

        function addBook(e){
            let node = e.target;
            let key = node.id;
            window.location.href = "/shoppingCart/Add?item="+key+"&currentPage="+<%=currentPage%>;
        }
        $(document).ready(function(){
            $('[data-toggle="tooltip"]').tooltip();
        });
        $('#modal2').on('show.bs.modal', function (event) {
            var bu = $(event.relatedTarget);
            var val = bu.data('whatever');
            console.log(val);
            document.getElementById("modal2h").innerHTML = val;
            $('#modal2h').val(val);
        });
        $('#addCart').click(function (){

        });
    </script>
</body>

</html>
