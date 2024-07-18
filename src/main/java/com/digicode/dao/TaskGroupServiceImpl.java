package com.digicode.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import org.json.JSONArray;
import org.json.JSONObject;

import com.digicode.model.TasksGroupModel;
import com.digicode.model.TicketsModel;
import com.google.gson.Gson;

public class TaskGroupServiceImpl {
    private Configuration configuration = new Configuration().configure();
    private SessionFactory sessionFactory = configuration.buildSessionFactory();

    // Get all task groups
    @SuppressWarnings("unchecked")
    public JSONObject getAllTaskGroups() {
    	System.out.println("Founded");
        
        Session session = null; 
       
        List<TasksGroupModel> tickets = new ArrayList<TasksGroupModel>();
    
        JSONObject responseJSON = new JSONObject();
        JSONArray ticketsArray = new JSONArray();



        try {
            session = sessionFactory.openSession();
            Transaction transaction = session.beginTransaction();
            
            tickets = session.createQuery("FROM TasksGroupModel")
                             
                             .list();
            
            if(!tickets.isEmpty()) {
            	System.out.println("Ticket Details Found!");
            	for (TasksGroupModel ticket : tickets) {
            		
            		System.out.println("Ticket Details Found!" + ticket.getGroupName());
            	    JSONObject ticketJSON = new JSONObject();
					ticketJSON.put("ticketId", ticket.getId());
					ticketJSON.put("title", ticket.getGroupName());
					ticketJSON.put("description", ticket.getLevel());
					ticketJSON.put("status", ticket.getStatus());
					

					 ticketsArray.put(ticketJSON);
				}
            	
            	System.out.println("ticketsList :" + ticketsArray.toString());
				responseJSON.put("status", "success");
				responseJSON.put("message", "Tickets found");
				responseJSON.put("pageName", "");

				responseJSON.put("tickets", ticketsArray.toString());
            	
            }else {
            	System.out.println("Ticket Details not Found! 1"); 
				
				responseJSON.put("status", "success");
				responseJSON.put("message", "No tickets found for the user");
				responseJSON.put("pageName", ""); 
            }
            
            return responseJSON;
            
        } catch (HibernateException e) {
        	 e.printStackTrace();
             responseJSON.put("status", "failure");
             responseJSON.put("message", "Error retrieving tickets");
             responseJSON.put("pageName", "");
        } finally {
            if (session != null) session.close();
        }
        
        return responseJSON;
    }
    }
    
    
    
  