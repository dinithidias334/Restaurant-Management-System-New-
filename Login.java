package com.resturent.controller;

import com.resturent.dao.LoginDAO;
import com.resturent.model.Employee;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet(name = "Login", urlPatterns = {"/Login"})
public class Login extends HttpServlet {

    private LoginDAO loginDAO;

    @Override
    public void init() {
        loginDAO = new LoginDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        Employee employee = loginDAO.validateUser(email, password);

        if (employee != null && "active".equalsIgnoreCase(employee.getStatus())) {
            String role = employee.getrole();

            HttpSession session = request.getSession();
            session.setAttribute("userEmail", employee.getEmail());
            session.setAttribute("userName", employee.getName());
            session.setAttribute("userRole", role);



            // Use sendRedirect for proper session handling
            switch (role.toLowerCase()) {
                case "admin":
                    response.sendRedirect("dashbord.jsp");
                    break;
                case "chef":
                    response.sendRedirect("kitchen.jsp");
                    break;
                case "cashier":
                    response.sendRedirect("menu.jsp");
                    break;
                default:
                    session.invalidate();
                    request.setAttribute("error", "Unknown role: " + role);
                    request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } else if (employee != null && !"active".equalsIgnoreCase(employee.getStatus())) {
            request.setAttribute("error", "Account is deactivated.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Invalid email or password.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
