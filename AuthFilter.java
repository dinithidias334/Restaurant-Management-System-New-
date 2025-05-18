package com.resturent.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(urlPatterns = {
        "/dashbord.jsp",
        "/employee.jsp",
        "/employee_register.jsp",
        "/employee_result.jsp",
        "/employee_search.jsp",
        "/item.jsp",
        "/kitchen.jsp",
        "/login.jsp",
        "/menu.jsp",
        "/search_result.jsp",
        "/success.jsp",
        "/view.jsp",
        "/addToCart.jsp",
        "/cart.jsp",

})
public class AuthFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        String path = req.getRequestURI();
        HttpSession session = req.getSession(false);



        boolean isLoginPage = path.endsWith("login.jsp") || path.endsWith("Login");
        boolean loggedIn = (session != null && session.getAttribute("userEmail") != null);
        boolean isStaticResource = path.endsWith(".js") || path.endsWith(".css") || path.endsWith(".png") || path.endsWith(".jpg");
        if (loggedIn || isLoginPage || isStaticResource) {
            chain.doFilter(request, response);
        } else {
            res.sendRedirect("login.jsp");
        }
    }

}
