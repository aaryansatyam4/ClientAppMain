package com.digicode.controller;

import javax.ws.rs.GET;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.Consumes;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.Response;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.PathParam;
import java.util.List;
import org.json.JSONObject;
import org.json.JSONArray;
import com.digicode.dao.LoginServiceImpl;
import com.digicode.dao.EmployeeServiceImpl;
import com.digicode.model.EmployeeModel;

@Path("/e")
public class EmployeeController {

    @Context
    private HttpServletRequest request;

   
    @GET
    @Path("/d")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getEmployeeDetails() {
        String userId = getUserIdFromCookies(request);

        JSONObject responseJSON = new JSONObject();
        JSONObject dataJSON = new JSONObject();
        LoginServiceImpl loginService = new LoginServiceImpl();
        EmployeeModel user = null;

        try {
            user = loginService.getUserById(userId);

            if (user != null) {
                responseJSON.put("status", "success");
                responseJSON.put("message", "User found");
                responseJSON.put("pageName", "");

                dataJSON.put("name", "user");
                dataJSON.put("value", user.getUserId());
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

                responseJSON.put("data", dataJSON);
            } else {
                responseJSON.put("status", "success");
                responseJSON.put("message", "User not found");
                responseJSON.put("pageName", "");
                responseJSON.put("data", JSONObject.NULL);
            }

        } catch (Exception e) {
            responseJSON.put("status", "failure");
            responseJSON.put("message", "Error retrieving user details");
            responseJSON.put("pageName", "login");
            responseJSON.put("data", JSONObject.NULL);
            e.printStackTrace();
        }

        // Return JSON response with appropriate status
        return Response.ok(responseJSON.toString(), MediaType.APPLICATION_JSON).build();
    }
    
    @GET
    @Path("/ea")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getEmployeesUnderEmployer() {
        String userId = getUserIdFromCookies(request);

        JSONObject responseJSON = new JSONObject();
        JSONArray employeesArray = new JSONArray();
        EmployeeServiceImpl empserv = new EmployeeServiceImpl();
        List<EmployeeModel> employees;

        try {
            employees = empserv.getEmployeesUnderEmployer(userId);

            for (EmployeeModel employee : employees) {
                JSONObject dataJSON = new JSONObject();
                dataJSON.put("name", "user");
                dataJSON.put("value", employee.getUserId());
                dataJSON.put("firstName", employee.getFirstName());
                dataJSON.put("lastName", employee.getLastName());
                dataJSON.put("email", employee.getEmail());
                dataJSON.put("contact_no", employee.getContact_no());
                dataJSON.put("position", employee.getPosition());
                dataJSON.put("gender", employee.getGender());
                dataJSON.put("address", employee.getAddress());
                dataJSON.put("country", employee.getCountry());
                dataJSON.put("pin", employee.getPin());
                dataJSON.put("department", employee.getDepartment());
                dataJSON.put("city", employee.getCity());
                dataJSON.put("state", employee.getState());
                dataJSON.put("salary", employee.getSalary());
                dataJSON.put("password", employee.getPassword());
                dataJSON.put("dob", employee.getDob() != null ? employee.getDob().toString() : null);
                dataJSON.put("joining_date", employee.getJoining_date() != null ? employee.getJoining_date().toString() : null);
                dataJSON.put("resign_date", employee.getResign_date() != null ? employee.getResign_date().toString() : null);
                dataJSON.put("employer", employee.getEmployer());

                employeesArray.put(dataJSON);
            }

            responseJSON.put("status", "success");
            responseJSON.put("message", "Employees retrieved under employer");
            responseJSON.put("employees", employeesArray);
        } catch (Exception e) {
            responseJSON.put("status", "failure");
            responseJSON.put("message", "Error retrieving employees under employer");
            e.printStackTrace();
        }

        // Return JSON response with appropriate status
        return Response.ok(responseJSON.toString(), MediaType.APPLICATION_JSON).build();
    }

    
    @GET
    @Path("/ce")
    @Produces(MediaType.APPLICATION_JSON)
    public Response countEmployeesUnderEmployer() {
        String user = getUserIdFromCookies(request);

        JSONObject responseJSON = new JSONObject();
        EmployeeServiceImpl empserv = new EmployeeServiceImpl();

        try {
            int employeeCount = empserv.countEmployeesUnderEmployer(user);

            responseJSON.put("status", "success");
            responseJSON.put("message", "Employee count retrieved");
            responseJSON.put("employeeCount", employeeCount);
        } catch (Exception e) {
            responseJSON.put("status", "failure");
            responseJSON.put("message", "Error retrieving employee count");
            e.printStackTrace();
        }

        // Return JSON response with appropriate status
        return Response.ok(responseJSON.toString(), MediaType.APPLICATION_JSON).build();
    }

    @PUT
    @Path("/update")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response updateEmployee(EmployeeModel employee) {
        String userId = employee.getUserId();

        // Fetch existing user
        LoginServiceImpl loginService = new LoginServiceImpl();
        EmployeeModel existingUser = loginService.getUserById(userId);

        if (existingUser != null) {
            // Update fields only if provided
            if (employee.getFirstName() != null && !employee.getFirstName().isEmpty()) {
                existingUser.setFirstName(employee.getFirstName());
            }
            if (employee.getLastName() != null && !employee.getLastName().isEmpty()) {
                existingUser.setLastName(employee.getLastName());
            }
            if (employee.getEmail() != null && !employee.getEmail().isEmpty()) {
                existingUser.setEmail(employee.getEmail());
            }
            if (employee.getContact_no() != null && !employee.getContact_no().isEmpty()) {
                existingUser.setContact_no(employee.getContact_no());
            }
            if (employee.getAddress() != null && !employee.getAddress().isEmpty()) {
                existingUser.setAddress(employee.getAddress());
            }
            if (employee.getCity() != null && !employee.getCity().isEmpty()) {
                existingUser.setCity(employee.getCity());
            }
            if (employee.getState() != null && !employee.getState().isEmpty()) {
                existingUser.setState(employee.getState());
            }
            if (employee.getCountry() != null && !employee.getCountry().isEmpty()) {
                existingUser.setCountry(employee.getCountry());
            }
            if (employee.getPin() != null && !employee.getPin().isEmpty()) {
                existingUser.setPin(employee.getPin());
            }

            boolean updated = loginService.updateUser(existingUser);

            if (updated) {
                return Response.ok("Employee updated successfully").build();
            } else {
                return Response.status(Response.Status.INTERNAL_SERVER_ERROR).entity("Failed to update employee").build();
            }
        } else {
            return Response.status(Response.Status.NOT_FOUND).entity("User not found").build();
        }
    }


    private String getUserIdFromCookies(HttpServletRequest request) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("user".equals(cookie.getName())) {
                    return cookie.getValue();
                }
            }
        }
        return null;
    }
}
