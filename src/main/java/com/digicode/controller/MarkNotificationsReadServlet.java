package com.digicode.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.digicode.dao.LoginServiceImpl;

public class MarkNotificationsReadServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        LoginServiceImpl loginService = new LoginServiceImpl();
        
        if (username != null) {
            loginService.markAllTicketsAsRead(username);
            response.getWriter().write("success");
        } else {
            response.getWriter().write("failure");
        }
    }
}