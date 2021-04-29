package shopOperation;

import DAO.DBoperation;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "DeleteAll", value = "/DeleteAll")
public class DeleteAll extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            DBoperation dp = new DBoperation();
            dp.deleteAll((String) request.getSession().getAttribute("userno"));
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            System.out.println("全部删除成功");
            response.sendRedirect("/shoppingCart/showCart.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
