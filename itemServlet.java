package com.resturent.controller;

import com.resturent.dao.itemDAO;
import com.resturent.model.items;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/menu")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB
        maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class itemServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String error = null;

        try {
            if ("add".equals(action)) {
                String name = request.getParameter("name");
                double price = Double.parseDouble(request.getParameter("price"));
                String category = request.getParameter("category");
                Part filePart = request.getPart("image");
                String fileName = saveImage(filePart, request);

                itemDAO.additem(name, price, fileName, category);

            } else if ("edit".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                String name = request.getParameter("name");
                double price = Double.parseDouble(request.getParameter("price"));
                String category = request.getParameter("category");
                Part filePart = request.getPart("image");

                if (filePart != null && filePart.getSize() > 0) {
                    String fileName = saveImage(filePart, request);
                    itemDAO.additem(name, price, fileName, category);

                } else {
                    itemDAO.updateItemWithoutImage(id, name, price, category);
                }
            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                itemDAO.deleteitem(id);
            }
        } catch (SQLException e) {
            error = "Database Error: " + e.getMessage();
            e.printStackTrace();
        } catch (NumberFormatException e) {
            error = "Invalid number format: " + e.getMessage();
            e.printStackTrace();
        } catch (Exception e) {
            error = "Unexpected error: " + e.getMessage();
            e.printStackTrace();
        }

        if (error != null) {
            request.setAttribute("error", error);
        }

        // Always reload the list after any action
        try {
            List<items> itemList = itemDAO.getItems();
            request.setAttribute("item", itemList);

        } catch (SQLException e) {
            request.setAttribute("error", "Failed to load items: " + e.getMessage());
            e.printStackTrace();
        }

        // Forward to JSP
        request.getRequestDispatcher("item.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<items> itemList = itemDAO.getItems();
            request.setAttribute("item", itemList);
        } catch (SQLException e) {
            request.setAttribute("error", "Failed to load items: " + e.getMessage());
            e.printStackTrace();
        }
        request.getRequestDispatcher("item.jsp").forward(request, response);
    }

    private String saveImage(Part filePart, HttpServletRequest request) throws IOException {
        String fileName = filePart.getSubmittedFileName();
        if (fileName == null || fileName.isEmpty()) {
            return null;
        }

        // Correct upload path inside webapp
        String uploadPath = request.getServletContext().getRealPath("/uploads");

        java.io.File uploadDir = new java.io.File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs(); // use mkdirs to ensure the full path is created
        }

        // Save image to /webapp/uploads/
        String filePath = uploadPath + java.io.File.separator + fileName;
        filePart.write(filePath);

        // Return relative path that browser can access
        return "uploads/" + fileName;
    }

}