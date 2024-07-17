package com.digicode.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.digicode.dao.LoginServiceImpl;
import com.digicode.model.EmployeeModel;
import com.google.gson.Gson;

@WebServlet("/fetchAdmins")
public class FetchAdminsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        LoginServiceImpl loginService = new LoginServiceImpl();
        List<EmployeeModel> employees = loginService.listAllEmployee(); // Adjust method name as per your service

        // Filter employees to find admins
        List<EmployeeModel> admins = employees.stream()
                .filter(employee -> "admin".equalsIgnoreCase(employee.getPosition()))
                .collect(Collectors.toList());

        String json = new Gson().toJson(admins);
        out.print(json);
        out.flush();
    }
}
