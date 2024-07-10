package com.digicode.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.Consumes;
import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.core.MediaType;

import com.digicode.dao.LoginServiceImpl;
import com.digicode.model.EmployeeModel;

import net.sf.json.JSONObject;

@Path("login")
public class LoginController {

    @GET
    @Path("/test")
    @Produces(MediaType.APPLICATION_JSON)
    public String test() {
        System.out.println("Hello java");

	String id = "01";
    	
    	System.out.println("getUserDetails Method called!");
    	
    	JSONObject responseJSON = new JSONObject();
    	JSONObject dataJSON = new JSONObject();
    	LoginServiceImpl loginService = new LoginServiceImpl();
    	EmployeeModel user = null;

    	
    	if(id == null || id == "") {
    		System.out.println("UserId is either null or empty!");
    		 responseJSON.put("status", "failure");
             responseJSON.put("message", "invalid user");
             responseJSON.put("pageName", "login");
             responseJSON.put("data", null);
    	}
    	
    	try {
    		
    		user = loginService.getUserById(id);
    		
    		if(user != null) {
    			System.out.println("USER FOUND!");
    			
    			dataJSON.put("id", user.getUserId());
    			dataJSON.put("fName", user.getFirstName());
    			
    			responseJSON.put("status", "success");
                responseJSON.put("message", "user found");
                responseJSON.put("pageName", "");
                responseJSON.put("data", null);
    			
    		}else {
    			System.out.println("USER NOT FOUND");
    			responseJSON.put("status", "success");
                responseJSON.put("message", "user not found");
                responseJSON.put("pageName", "");
                responseJSON.put("data", null);
    			
    		}
    		
    	
    	}catch (Exception e) {
    		System.out.println("error : ");
			e.printStackTrace();
			 responseJSON.put("status", "failure");
             responseJSON.put("message", "invalid user");
             responseJSON.put("pageName", "login");
             responseJSON.put("data", null);
			
		}

        
      return responseJSON.toString();

        //return "hello java1";
    }

    @POST
    @Path("/check/credentials")
    @Consumes(MediaType.APPLICATION_FORM_URLENCODED)
    public String checkUsereExistence(@FormParam("userName") String userName, @FormParam("password") String password,
            @Context HttpServletRequest request, @Context HttpServletResponse response,
            @Context HttpHeaders headers) {
        System.out.println("checkUsereExistence called");
        System.out.println("Username: " + userName);
        System.out.println("Password: " + password);

        JSONObject responseJSON = new JSONObject();

        LoginServiceImpl loginService = new LoginServiceImpl();
        boolean isValidUser = loginService.chkcredentials(userName, password);

        if (isValidUser) {
            // Set a cookie
            Cookie userCookie = new Cookie("username", userName);
            userCookie.setMaxAge(60 * 60); // 1 hour expiration
            userCookie.setPath("/"); // Cookie is accessible from the root path
            response.addCookie(userCookie);
            
           
       
            String userRole = loginService.getUserRole();
        
            
            
            
            
            responseJSON.put("status", "success");
            responseJSON.put("message", "login_successful");
            responseJSON.put("pageName", "index.jsp");
            responseJSON.put("role", userRole);
        } else {
            responseJSON.put("status", "failure");
            responseJSON.put("message", "invalid_user");
            responseJSON.put("pageName", "login");
            responseJSON.put("data", null);
        }

        System.out.println(responseJSON);
        return responseJSON.toString();
    }
    
    @GET
    @Path("/details")
    @Produces(MediaType.APPLICATION_JSON)
  //  @Consumes(MediaType.APPLICATION_FORM_URLENCODED)
    public String getUserDetails( ) {
    	
    	String id = "01";
    	
    	System.out.println("getUserDetails Method called!");
    	
    	JSONObject responseJSON = new JSONObject();
    	JSONObject dataJSON = new JSONObject();
    	LoginServiceImpl loginService = new LoginServiceImpl();
    	EmployeeModel user = null;

    	
    	if(id == null || id == "") {
    		System.out.println("UserId is either null or empty!");
    		 responseJSON.put("status", "failure");
             responseJSON.put("message", "invalid user");
             responseJSON.put("pageName", "login");
             responseJSON.put("data", null);
    	}
    	
    	try {
    		
    		user = loginService.getUserById(id);
    		
    		if(user != null) {
    			System.out.println("USER FOUND!" +user.getFirstName());
    			
    			dataJSON.put("id", user.getUserId());
    			dataJSON.put("fName", user.getFirstName());
    			dataJSON.put("lname", user.getLastName());
    			dataJSON.put("address", user.getAddress());
    			
    			responseJSON.put("status", "success");
                responseJSON.put("message", "user found");
                responseJSON.put("pageName", "");
                responseJSON.put("data", dataJSON);
    			
    		}else {
    			System.out.println("USER NOT FOUND");
    			responseJSON.put("status", "success");
                responseJSON.put("message", "user not found");
                responseJSON.put("pageName", "");
                responseJSON.put("data", null);
    			
    		}
    		
    	
    	}catch (Exception e) {
    		System.out.println("error : ");
			e.printStackTrace();
			 responseJSON.put("status", "failure");
             responseJSON.put("message", "invalid user");
             responseJSON.put("pageName", "login");
             responseJSON.put("data", null);
			
		}

        
        

        return responseJSON.toString();
    }
}


