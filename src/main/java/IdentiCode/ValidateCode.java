package IdentiCode;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;

@WebServlet(name = "ValidateCode", value = "/ValidateCode")
public class ValidateCode extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String code = request.getParameter("code");
        String randStr = (String) request.getSession().getAttribute("randStr");
//        System.out.println(code);
        if(code.equalsIgnoreCase(randStr)){
//            System.out.println(code);
            OutputStream os=response.getOutputStream();
            os.write("1".getBytes());
        }

    }
}
