package com.digicode.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.PathParam;
import org.json.JSONArray;
import org.json.JSONObject;

import com.digicode.dao.TicketServiceImpl;
import com.digicode.model.TicketsModel;

@Path("/t")
public class TicketsController {
	@Context
	private HttpServletRequest request;
	
	 @GET
	    @Path("/created")
	    @Produces(MediaType.APPLICATION_JSON)
	    public String getAllTicketsCreatedByUser() {
			String userId = getUserIdFromCookies(request);

			JSONObject responseJSON = null;
			JSONObject ticketJSON = null;
			JSONArray ticketsArray = new JSONArray();
			TicketServiceImpl ticketService = new TicketServiceImpl();
			
			 

			try {

				responseJSON = ticketService.getAllTicketsCreatedByUser(userId);

				 
					System.out.println("responseJSON :" + responseJSON.toString());
//					responseJSON.put("status", "success");
//					responseJSON.put("message", "Tickets found");
//					responseJSON.put("pageName", "");
	//
//					responseJSON.put("tickets", ticketJSON);
//				} else {
//					System.out.println("Ticket details not found!");
//					responseJSON.put("user", userId);
//					responseJSON.put("status", "success");
//					responseJSON.put("message", "No tickets found for the user");
//					responseJSON.put("pageName", ""); 
//				}

			} catch (Exception e) {
				System.out.println("Error : ");
				responseJSON.put("status", "failure");
				responseJSON.put("message", "Error retrieving ticket");
				responseJSON.put("pageName", "login");
				responseJSON.put("tickets", JSONObject.NULL);
				e.printStackTrace();
			}

			// Return JSON response
			return responseJSON.toString();
	    }

	

	@GET
	@Path("/c")
	@Produces(MediaType.APPLICATION_JSON)
	public String getAllTicketsForUser() {
		String userId = getUserIdFromCookies(request);

		JSONObject responseJSON = null;
		JSONObject ticketJSON = null;
		JSONArray ticketsArray = new JSONArray();
		TicketServiceImpl ticketService = new TicketServiceImpl();
		
		 

		try {

			responseJSON = ticketService.getAllTicketsForUser(userId);

			 
				System.out.println("responseJSON :" + responseJSON.toString());
//				responseJSON.put("status", "success");
//				responseJSON.put("message", "Tickets found");
//				responseJSON.put("pageName", "");
//
//				responseJSON.put("tickets", ticketJSON);
//			} else {
//				System.out.println("Ticket details not found!");
//				responseJSON.put("user", userId);
//				responseJSON.put("status", "success");
//				responseJSON.put("message", "No tickets found for the user");
//				responseJSON.put("pageName", ""); 
//			}

		} catch (Exception e) {
			System.out.println("Error : ");
			responseJSON.put("status", "failure");
			responseJSON.put("message", "Error retrieving ticket");
			responseJSON.put("pageName", "login");
			responseJSON.put("tickets", JSONObject.NULL);
			e.printStackTrace();
		}

		// Return JSON response
		return responseJSON.toString();
	}
	
	 @GET
	    @Path("/c/{ticketId}")
	    @Produces(MediaType.APPLICATION_JSON)
	    public String getTicketById(@PathParam("ticketId") int ticketId) {
	        JSONObject responseJSON = null;
	        TicketServiceImpl ticketService = new TicketServiceImpl();

	        try {
	            responseJSON = ticketService.getTicketById(ticketId);
	            System.out.println("responseJSON :" + responseJSON.toString());
	        } catch (Exception e) {
	            System.out.println("Error : ");
	            responseJSON.put("status", "failure");
	            responseJSON.put("message", "Error retrieving ticket");
	            responseJSON.put("pageName", "login");
	            responseJSON.put("ticket", JSONObject.NULL);
	            e.printStackTrace();
	        }

	        // Return JSON response
	        return responseJSON.toString();
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
