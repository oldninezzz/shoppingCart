package shopOperation;

import DAO.DBoperation;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "SetNum", value = "/SetNum")
public class SetNum extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bookname = request.getParameter("bookname");
        String bnum = request.getParameter("bnum");

        try {
            DBoperation dp = new DBoperation();

            if(dp.getBookStock(bookname) < Integer.parseInt(bnum)){
                response.getWriter().write("2");
            }
            else{
                dp.setBookNum((String) request.getSession().getAttribute("userno"), bookname, Integer.parseInt(bnum));
                response.getWriter().write("1");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
