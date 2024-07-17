package com.digicode.controller;

import com.digicode.dao.EmployeeServiceImpl;
import com.digicode.model.EmployeeModel;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;

@WebServlet("/updateProfile")
public class UpdateProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private EmployeeServiceImpl employeeService = new EmployeeServiceImpl();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get the userId from cookies
        String userId = null;
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("user".equals(cookie.getName())) {
                    userId = cookie.getValue();
                    break;
                }
            }
        }

        if (userId == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("User ID not found in cookies");
            return;
        }

        StringBuilder sb = new StringBuilder();
        BufferedReader reader = request.getReader();
        String line;
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }

        String requestBody = sb.toString();
        Gson gson = new Gson();
        EmployeeModel employee = gson.fromJson(requestBody, EmployeeModel.class);

        String result = employeeService.updateEmployee(userId, employee);

        if ("Employee updated successfully".equals(result)) {
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write(result);
        } else {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write(result);
        }
    }
}
