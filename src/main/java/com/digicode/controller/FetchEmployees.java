package com.digicode.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.digicode.dao.LoginServiceImpl;
import com.digicode.model.EmployeeModel;

@WebServlet("/fetchEmployees")
public class FetchEmployees extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String adminId = request.getParameter("adminId");
        System.out.println(adminId+ "Step 1");

        // Fetch employees for the given admin ID
        LoginServiceImpl loginService = new LoginServiceImpl();
        List<EmployeeModel> empList = loginService.listEmployeesByAdmin(adminId);

        // Prepare JSON response
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        out.print("[");
        boolean first = true;
        for (EmployeeModel emp : empList) {
            if (!first) {
                out.print(",");
            }
            out.print("{");
            out.print("\"userId\":\"" + emp.getUserId() + "\",");
            out.print("\"name\":\"" + emp.getFirstName() + " " + emp.getLastName() + "\",");
            out.print("\"dob\":\"" + new SimpleDateFormat("dd-MM-yyyy").format(emp.getDob()) + "\",");
            out.print("\"position\":\"" + emp.getPosition() + "\",");
            out.print("\"location\":\"" + emp.getCountry() + "\",");
            out.print("\"startDate\":\"" + new SimpleDateFormat("dd-MM-yyyy").format(emp.getJoining_date()) + "\",");
            out.print("\"address\":\"" + emp.getAddress() + " " + emp.getState() + " (" + emp.getCountry() + ")\"");
            out.print("}");
            first = false;
        }
        out.print("]");
        String jsonResponse = out.toString();
        System.out.println("JSON Response: " + jsonResponse); // Add this line to debug

        out.flush();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

}
