package com.digicode.controller;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import org.json.JSONObject;

import com.digicode.dao.TaskGroupServiceImpl;


@Path("/TaskGroup")
public class TaskGroupController {
    
	@GET
	@Path("/allGroup")
	@Produces(MediaType.APPLICATION_JSON)
	public String getAllTicketsForUser() {
		

		JSONObject responseJSON = null;
		
		TaskGroupServiceImpl ticketService = new TaskGroupServiceImpl();
		
		 

		try {

			responseJSON = ticketService.getAllTaskGroups();

			 
				System.out.println("responseJSON :" + responseJSON.toString());


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
	
}
