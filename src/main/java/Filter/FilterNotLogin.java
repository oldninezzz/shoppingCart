package Filter;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
//, urlPatterns = {"/main.jsp", "/UserLogout"}
@WebFilter(filterName = "FilterNotLogin", urlPatterns = {"/main.jsp", "/UserLogout", "/showCart.jsp"})
public class FilterNotLogin implements Filter {
    public void init(FilterConfig config) throws ServletException {
    }

    public void destroy() {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse rsp = (HttpServletResponse) response;
        String user = (String)req.getSession().getAttribute("userno");
        if(user==null){
            rsp.sendRedirect("/shoppingCart/login.jsp");
        }
        else{
            chain.doFilter(request, response);
        }

    }
}
