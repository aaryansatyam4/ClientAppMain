package com.digicode.controller;

import com.digicode.dao.LoginServiceImpl;
import com.digicode.model.EmployeeModel;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/changePassword")
public class ChangePasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get parameters
        String userId = request.getParameter("userId");
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Validate input
        if (userId == null || currentPassword == null || newPassword == null || confirmPassword == null) {
            response.getWriter().println("All fields are required.");
            return;
        }

        // Check if new password and confirm password match
        if (!newPassword.equals(confirmPassword)) {
            response.getWriter().println("New password and confirm password do not match.");
            return;
        }

        // Fetch existing user
        LoginServiceImpl loginService = new LoginServiceImpl();
        EmployeeModel user = loginService.getUserById(userId);

        // Check if current password matches the one stored in the database
        if (user != null && user.getPassword().equals(currentPassword)) {
            // Update password
            user.setPassword(newPassword); // Consider hashing the password
            boolean updated = loginService.updateUser(user);

            if (updated) {
                response.sendRedirect("profile.jsp");
            } else {
                response.getWriter().println("Failed to update password.");
            }
        } else {
            response.getWriter().println("Current password is incorrect.");
        }
    }
}
