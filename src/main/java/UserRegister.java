import DAO.DBoperation;
import VO.Userinfo;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "UserRegister", value = "/UserRegister")
public class UserRegister extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        try {
            DBoperation dp = new DBoperation();
            Userinfo user = new Userinfo();
            user.setUsername(username);
            user.setPassword(password);
            dp.insertUserinfo(user);
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            response.sendRedirect("/shoppingCart/login.jsp");
        }
    }
}
