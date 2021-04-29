package shopOperation;

import DAO.DBoperation;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "Add", value = "/Add")
public class Add extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String item = request.getParameter("item");
        System.out.println(item);
        System.out.println(request.getSession().getAttribute("userno"));
        DBoperation dbo = new DBoperation();
        try{
            dbo.addBook(item, (String) request.getSession().getAttribute("userno"));
            System.out.println("添加成功!");
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            response.sendRedirect("/shoppingCart/main.jsp?currentPage="+request.getParameter("currentPage"));
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
