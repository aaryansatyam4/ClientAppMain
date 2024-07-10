package com.digicode.controller;

import com.digicode.dao.LoginServiceImpl;
import javax.servlet.http.Cookie;
import com.digicode.model.EmployeeModel;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/updateProfile")
public class UpdateProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String userId = null;
        
        // Retrieve userId from cookies
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("userId".equals(cookie.getName())) {
                    userId = cookie.getValue();
                    break;
                }
            }
        }

        if (userId != null) {
            // Fetch existing user
            LoginServiceImpl loginService = new LoginServiceImpl();
            EmployeeModel existingUser = loginService.getUserById(userId);

            if (existingUser != null) {
                // Update fields only if provided
                String firstName = request.getParameter("firstName");
                if (firstName != null && !firstName.isEmpty()) {
                    existingUser.setFirstName(firstName);
                }
                
                String lastName = request.getParameter("lastName");
                if (lastName != null && !lastName.isEmpty()) {
                    existingUser.setLastName(lastName);
                }
                
                String email = request.getParameter("email");
                if (email != null && !email.isEmpty()) {
                    existingUser.setEmail(email);
                }

                String contactNo = request.getParameter("contact_no");
                if (contactNo != null && !contactNo.isEmpty()) {
                    existingUser.setContact_no(contactNo);
                }
                
                String address = request.getParameter("address");
                if (address != null && !address.isEmpty()) {
                    existingUser.setAddress(address);
                }

                String city = request.getParameter("city");
                if (city != null && !city.isEmpty()) {
                    existingUser.setCity(city);
                }

                String state = request.getParameter("state");
                if (state != null && !state.isEmpty()) {
                    existingUser.setState(state);
                }

                String country = request.getParameter("country");
                if (country != null && !country.isEmpty()) {
                    existingUser.setCountry(country);
                }

                String pin = request.getParameter("pin");
                if (pin != null && !pin.isEmpty()) {
                    existingUser.setPin(pin);
                }

                // Update other fields similarly...

                boolean updated = loginService.updateUser(existingUser);

                if (updated) {
                    response.sendRedirect("profile.jsp");
                } else {
                    response.getWriter().println("Failed to update profile.");
                }
            } else {
                response.getWriter().println("User not found.");
            }
        } else {
            response.getWriter().println("User ID not found in cookies.");
        }
    }
}
