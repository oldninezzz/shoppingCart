import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;

import DAO.DBoperation;
import VO.Userinfo;


@WebServlet(name = "UserRegisterCheck", value = "/UserRegisterCheck")
public class UserRegisterCheck extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        System.out.println(username);
        OutputStream os=response.getOutputStream();
        try {
            DBoperation dp = new DBoperation();
            String flag = dp.isExisted(username);
            System.out.println("666"+flag);
            if(!flag.equals("not registered")){
                os.write("2".getBytes());
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
//        System.out.println("Success");
    }
}
