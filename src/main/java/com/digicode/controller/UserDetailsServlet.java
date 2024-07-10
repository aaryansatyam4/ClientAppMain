package com.digicode.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import com.digicode.dao.LoginServiceImpl;
import com.digicode.model.EmployeeModel;

@WebServlet("/Ud")
public class UserDetailsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = null;

        // Retrieve userId from cookies
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("username")) {
                    userId = cookie.getValue();
                    break;
                }
            }
        }

        // Example of getting userId from session
        if (userId == null) {
            HttpSession session = request.getSession();
            userId = (String) session.getAttribute("username");
        }

        // If userId is still null, handle the unauthorized request
        if (userId == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED); 
            return;
        }

        JSONObject responseJSON = new JSONObject();
        JSONObject dataJSON = new JSONObject();
        LoginServiceImpl loginService = new LoginServiceImpl();
        EmployeeModel user = null;

        try {
            user = loginService.getUserById(userId);

            if (user != null) {
              
                responseJSON.put("status", "success");
                responseJSON.put("message", "user found");
                responseJSON.put("pageName", "");

                dataJSON.put("userId", user.getUserId());
                dataJSON.put("firstName", user.getFirstName());
                dataJSON.put("lastName", user.getLastName());
                dataJSON.put("email", user.getEmail());
                dataJSON.put("contact_no", user.getContact_no());
                dataJSON.put("position", user.getPosition());
                dataJSON.put("gender", user.getGender());
                dataJSON.put("address", user.getAddress());
                dataJSON.put("country", user.getCountry());
                dataJSON.put("pin", user.getPin());
                dataJSON.put("department", user.getDepartment());
                dataJSON.put("city", user.getCity());
                dataJSON.put("state", user.getState());
                dataJSON.put("salary", user.getSalary());
                dataJSON.put("password", user.getPassword());
                dataJSON.put("dob", user.getDob() != null ? user.getDob().toString() : null);
                dataJSON.put("joining_date", user.getJoining_date() != null ? user.getJoining_date().toString() : null);
                dataJSON.put("resign_date", user.getResign_date() != null ? user.getResign_date().toString() : null);
                dataJSON.put("employer", user.getEmployer());
                dataJSON.put("profilePicture", user.getProfilePicture()); 

                responseJSON.put("data", dataJSON);
            } else {
            	System.out.println("USER NOT FOUND");
                responseJSON.put("status", "success");
                responseJSON.put("message", "user not found");
                responseJSON.put("pageName", "");
                responseJSON.put("data", JSONObject.NULL);

            }

        } catch (Exception e) {
        	System.out.println("error : ");
			e.printStackTrace();
            responseJSON.put("status", "failure");
            responseJSON.put("message", "error retrieving user details");
            responseJSON.put("pageName", "login");
            responseJSON.put("data", JSONObject.NULL);
         
        }

        // Set content type and write JSON response
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(responseJSON.toString());
    }
}
