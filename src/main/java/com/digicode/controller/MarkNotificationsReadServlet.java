package com.digicode.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.digicode.dao.LoginServiceImpl;

@WebServlet("/MarkNotificationsReadServlet")
public class MarkNotificationsReadServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        System.out.println("USERNAME received in servlet: " + username); // Debugging statement

        LoginServiceImpl loginService = new LoginServiceImpl();
        
        if (username != null && !username.trim().isEmpty()) {
            loginService.markAllTicketsAsRead(username);
            System.out.println("Tickets marked as read for username: " + username); // Debugging statement
            response.getWriter().write("success");
        } else {
            System.out.println("Username is null or empty"); // Debugging statement
            response.getWriter().write("failure");
        }
    }
}
