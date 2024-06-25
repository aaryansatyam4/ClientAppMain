package com.digicode.controller;

import com.digicode.dao.LoginServiceImpl;
import com.digicode.model.EmployeeModel;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/checkUserPosition")
public class CheckUserPositionServlet extends HttpServlet {
    private LoginServiceImpl loginService = new LoginServiceImpl();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        boolean isAuthenticated = loginService.chkcredentials(username, password);
        
        if (isAuthenticated) {
            EmployeeModel user = loginService.getUserById(username);
            
            if (user != null && "employee".equalsIgnoreCase(user.getPosition())) {
                response.getWriter().write("employee_dashboard.jsp");
            } else {
                response.getWriter().write("index.jsp");
            }
        } else {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
        }
    }
}