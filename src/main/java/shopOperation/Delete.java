package shopOperation;

import DAO.DBoperation;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "Delete", value = "/Delete")
public class Delete extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bookname = request.getParameter("bookname");
        DBoperation dop = new DBoperation();
        try {
            dop.deleteBook(bookname, (String)request.getSession().getAttribute("userno"));
            System.out.println("删除成功！"+bookname);
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            request.getSession().removeAttribute("shopinfo");
            response.sendRedirect("/shoppingCart/showCart.jsp");
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
