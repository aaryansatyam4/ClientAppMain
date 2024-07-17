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
		System.out.println("Hello java team");
		
LoginServiceImpl loginImpl = new LoginServiceImpl();
		
		@SuppressWarnings("unused")
		List<EmployeeModel>  emp= new ArrayList<EmployeeModel>();
		
		emp = loginImpl.listAllEmployee();
		
		return "hello java team";
	}
	
	@POST
	@Path("/check/credentials")
	@Consumes(MediaType.APPLICATION_FORM_URLENCODED)
	public String checkUserExistence(@FormParam("userName") String userName, @FormParam("password") String password,
			@Context HttpServletRequest request, @Context HttpServletResponse response, @Context HttpHeaders headers) {
		System.out.println("checkUsereExistence called");
		
		System.out.println("Username: "+userName);
		System.out.println("Password: "+password);
		
		
		JSONObject responseJSON = new JSONObject();
		 boolean isValidUser = false;
		
		LoginServiceImpl loginService = new LoginServiceImpl();
		
		try {
			isValidUser = loginService.chkcredentials(userName, password);
			System.out.println("isValidUser: "+ isValidUser);
		}catch (Exception e) {
			e.printStackTrace();
			isValidUser = false;
		}
		
	     
		
	    if(isValidUser) {
	    	
	    	Cookie userCookie = new Cookie("user", userName);
            userCookie.setMaxAge(60 * 60 * 24); // 1 day
            userCookie.setPath("/");
            response.addCookie(userCookie);
            
            String userRole = loginService.getUserRole();
            
	    	responseJSON.put("status", "success");
			responseJSON.put("message", "login_successful");
			// responseJSON.put("statusCode", statusCode);
			responseJSON.put("pageName", "index.jsp");
			responseJSON.put("role", userRole);
			
//			TicketCountServlet ticketCountServlet = new TicketCountServlet();
//	        ticketCountServlet.updateTicketCounts();

	    	System.out.println("success") ;   	
	    
	    	
	    }
	    else {
	    	
	    	responseJSON.put("status", "failure");
			responseJSON.put("message", "invalid user");
			// responseJSON.put("statusCode", statusCode);
			responseJSON.put("pageName", "login");
			responseJSON.put("data", null);
	    	
	    }
		
        System.out.println(responseJSON);
		// log.info("Response object: " + responseJSON);
		return responseJSON.toString();

		//return Utility.getResponseObj("failure", "Please enter valid User Name (e.g. userid@domain.in)", "E013",
			//	"Login", null);	
		//return "done";

	}
}
