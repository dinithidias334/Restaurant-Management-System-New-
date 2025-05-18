
package com.resturent.controller;

import com.resturent.dao.EmployeeDAO;
import com.resturent.model.Employee;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;


@WebServlet(name = "EmployeeHandling", urlPatterns = {"/EmployeeHandling"})
public class EmployeeHandling extends HttpServlet {
    private EmployeeDAO employeeDAO;

    @Override
    public void init() {
        employeeDAO = new EmployeeDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        String role = request.getParameter("role");
        String name = request.getParameter("name");
        String number = request.getParameter("number");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String status = request.getParameter("status");

        if ("Register".equals(action)) {
            Employee newEmployee = new Employee(name, email, role, number, password, status);
            employeeDAO.insertEmployee(newEmployee);
            response.sendRedirect("employee_register.jsp?status=success");

        } else if("Search".equals(action)) {
            String searchEmail = request.getParameter("searchEmail");
            Employee emp = employeeDAO.searchByEmail(searchEmail);
            request.setAttribute("employee", emp);
            request.getRequestDispatcher("search_result.jsp").forward(request, response);

        } else if("SearchForView".equals(action)) {
            String searchEmail = request.getParameter("searchEmail");
            Employee emp = employeeDAO.searchByEmail(searchEmail);
            request.setAttribute("employee", emp);
            request.getRequestDispatcher("search_result.jsp").forward(request, response);

        } else if ("UpdateStatus".equals(action)) {
            String selectEmail = request.getParameter("searchEmail");
            String newStatus = request.getParameter("status");

            employeeDAO.updateStatus(selectEmail, newStatus);
            Employee updatedEmp = employeeDAO.searchByEmail(selectEmail);

            request.setAttribute("employee", updatedEmp);
            request.setAttribute("message", "Status updated successfully!");
            request.getRequestDispatcher("search_result.jsp").forward(request, response);
        }
    }
}
