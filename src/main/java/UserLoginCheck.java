import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.OutputStream;

import DAO.*;
import VO.Userinfo;

@WebServlet(name = "UserLoginCheck", value = "/UserLoginCheck")
public class UserLoginCheck extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        OutputStream os=response.getOutputStream();

//        System.out.println(password);
        try {
            DBoperation dbo = new DBoperation();
            String rpwd = dbo.isExisted(username);
            if(!rpwd.equals("")){
                if(rpwd.equals(password)){
                    HttpSession session = request.getSession();
                    session.setAttribute("userno", username);
                    response.sendRedirect("/shoppingCart/main.jsp");
                }
                else{
                    os.write("1".getBytes());//ajax
                }
            }
            else{
//                System.out.println(username);
                os.write("2".getBytes());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}
