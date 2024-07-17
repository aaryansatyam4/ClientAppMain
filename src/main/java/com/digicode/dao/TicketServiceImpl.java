package com.digicode.dao;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import org.json.JSONArray;
import org.json.JSONObject;

import com.digicode.model.TicketsModel;
import com.google.gson.Gson;

import java.util.ArrayList;
import java.util.List;

public class TicketServiceImpl {
	

    Configuration configuration = new Configuration().configure();
    @SuppressWarnings("deprecation")
	SessionFactory sessionFactory = configuration.buildSessionFactory();
    Session session = null;
    Transaction transaction = null;

    // Get all tickets
    @SuppressWarnings("unchecked")
    public String getAllTickets() {
        List<TicketsModel> tickets = null;
        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();
            tickets = session.createQuery("FROM TicketsModel").list();
            transaction.commit();
        } catch (HibernateException e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
        } finally {
            if (session != null) session.close();
        }
        Gson gson = new Gson();
        return gson.toJson(tickets);
    }

 // Get all tickets assigned to a specific user using cookies
    @SuppressWarnings("unchecked")
    public JSONObject getAllTicketsForUser(String userId) {
    	
    	System.out.println("userId : " + userId);
       
        Session session = null; 
       
        List<TicketsModel> tickets = new ArrayList<TicketsModel>();
    
        JSONObject responseJSON = new JSONObject();
        JSONArray ticketsArray = new JSONArray();

        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();
            
            tickets = session.createQuery("FROM TicketsModel WHERE employee_id = :userId ")
                             .setParameter("userId", userId)
                             .list();
            
            if(!tickets.isEmpty()) {
            	System.out.println("Ticket Details Found!");
            	for (TicketsModel ticket : tickets) {
            		
            		System.out.println("Ticket Details Found!" + ticket.getTicketName());
            	    JSONObject ticketJSON = new JSONObject();
					ticketJSON.put("ticketId", ticket.getId());
					ticketJSON.put("title", ticket.getTicketName());
					ticketJSON.put("description", ticket.getTicketDescription());
					ticketJSON.put("status", ticket.getStatus());
					ticketJSON.put("severity", ticket.getSeverity());
					ticketJSON.put("assignee", ticket.getEmployeeId().getUserId());
					ticketJSON.put("createdBy", ticket.getCreatedBy());
					ticketJSON.put("createdAt", ticket.getCreatedAt()); 
					ticketJSON.put("DueDate", ticket.getDueDate()); 
					ticketJSON.put("updatedAt", ticket.getUpdatedAt()); 
					ticketJSON.put("Remark", ticket.getRemark()); 
					ticketJSON.put("CompletedAt", ticket.getCompletedAt()); 
					ticketJSON.put("Manager", ticket.getManager()); 

					 ticketsArray.put(ticketJSON);
				}
            	
            	System.out.println("ticketsList :" + ticketsArray.toString());
				responseJSON.put("status", "success");
				responseJSON.put("message", "Tickets found");
				responseJSON.put("pageName", "");

				responseJSON.put("tickets", ticketsArray.toString());
            	
            }else {
            	System.out.println("Ticket Details not Found! 1"); 
				responseJSON.put("user", userId);
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
    
    @SuppressWarnings("unchecked")
    public JSONObject getAllTicketsCreatedByUser(String userId) {
     	
    	System.out.println("userId : " + userId);
       
        Session session = null; 
       
        List<TicketsModel> tickets = new ArrayList<TicketsModel>();
    
        JSONObject responseJSON = new JSONObject();
        JSONArray ticketsArray = new JSONArray();

        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();
            
            tickets = session.createQuery("FROM TicketsModel WHERE createdBy = :userId ")
                             .setParameter("userId", userId)
                             .list();
            
            if(!tickets.isEmpty()) {
            	System.out.println("Ticket Details Found!");
            	for (TicketsModel ticket : tickets) {
            		
            		System.out.println("Ticket Details Found!" + ticket.getTicketName());
            	    JSONObject ticketJSON = new JSONObject();
					ticketJSON.put("ticketId", ticket.getId());
					ticketJSON.put("title", ticket.getTicketName());
					ticketJSON.put("description", ticket.getTicketDescription());
					ticketJSON.put("status", ticket.getStatus());
					ticketJSON.put("severity", ticket.getSeverity());
					ticketJSON.put("assignee", ticket.getEmployeeId().getUserId());
					ticketJSON.put("createdBy", ticket.getCreatedBy());
					ticketJSON.put("createdAt", ticket.getCreatedAt()); 
					ticketJSON.put("DueDate", ticket.getDueDate()); 
					ticketJSON.put("updatedAt", ticket.getUpdatedAt()); 
					ticketJSON.put("Remark", ticket.getRemark()); 
					ticketJSON.put("CompletedAt", ticket.getCompletedAt()); 
					ticketJSON.put("Manager", ticket.getManager()); 

					 ticketsArray.put(ticketJSON);
				}
            	
            	System.out.println("ticketsList :" + ticketsArray.toString());
				responseJSON.put("status", "success");
				responseJSON.put("message", "Tickets found");
				responseJSON.put("pageName", "");

				responseJSON.put("tickets", ticketsArray.toString());
            	
            }else {
            	System.out.println("Ticket Details not Found! 1"); 
				responseJSON.put("user", userId);
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



    // Global search by various fields
    @SuppressWarnings("unchecked")
    public String searchTickets(String searchText) {
        List<TicketsModel> tickets = null;
        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();
            tickets = session.createQuery("FROM TicketsModel WHERE " +
                            "id = :searchText OR " +
                            "ticketName LIKE :searchTextPattern OR " +
                            "ticketDescription LIKE :searchTextPattern OR " +
                            "createdBy LIKE :searchTextPattern OR " +
                            "updatedBy LIKE :searchTextPattern OR " +
                            "assignee LIKE :searchTextPattern OR " +
                            "severity LIKE :searchTextPattern OR " +
                            "remark LIKE :searchTextPattern OR " +
                            "status LIKE :searchTextPattern OR " +
                            "manager LIKE :searchTextPattern")
                    .setParameter("searchText", parseIntOrZero(searchText))
                    .setParameter("searchTextPattern", "%" + searchText + "%")
                    .list();
            transaction.commit();
        } catch (HibernateException e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
        } finally {
            if (session != null) session.close();
        }
        Gson gson = new Gson();
        return gson.toJson(tickets);
    }

    private int parseIntOrZero(String text) {
        try {
            return Integer.parseInt(text);
        } catch (NumberFormatException e) {
            return 0;
        }
    }

    // Get ticket by id
    public JSONObject getTicketById(int ticketId) {
        Session session = null;
        JSONObject responseJSON = new JSONObject();

        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();

            TicketsModel ticket = (TicketsModel) session.get(TicketsModel.class, ticketId);

            if (ticket != null) {
                JSONObject ticketJSON = new JSONObject();
                ticketJSON.put("ticketId", ticket.getId());
                ticketJSON.put("title", ticket.getTicketName());
                ticketJSON.put("description", ticket.getTicketDescription());
                ticketJSON.put("status", ticket.getStatus());
                ticketJSON.put("severity", ticket.getSeverity());
                ticketJSON.put("assignee", ticket.getEmployeeId());
                ticketJSON.put("createdBy", ticket.getCreatedBy());
                ticketJSON.put("createdAt", ticket.getCreatedAt());
                ticketJSON.put("DueDate", ticket.getDueDate());
                ticketJSON.put("updatedAt", ticket.getUpdatedAt());
                ticketJSON.put("Remark", ticket.getRemark());
                ticketJSON.put("CompletedAt", ticket.getCompletedAt());
                ticketJSON.put("Manager", ticket.getManager());

                responseJSON.put("status", "success");
                responseJSON.put("message", "Ticket details found");
                responseJSON.put("pageName", "");
                responseJSON.put("ticket", ticketJSON);

                // Print ticket details for debugging
                System.out.println("Ticket Details:");
                System.out.println("Ticket ID: " + ticket.getId());
                System.out.println("Title: " + ticket.getTicketName());
                System.out.println("Description: " + ticket.getTicketDescription());
                System.out.println("Status: " + ticket.getStatus());
                System.out.println("Severity: " + ticket.getSeverity());
                System.out.println("Assignee: " + ticket.getEmployeeId());
                System.out.println("Created By: " + ticket.getCreatedBy());
                System.out.println("Created At: " + ticket.getCreatedAt());
                System.out.println("Due Date: " + ticket.getDueDate());
                System.out.println("Updated At: " + ticket.getUpdatedAt());
                System.out.println("Remark: " + ticket.getRemark());
                System.out.println("Completed At: " + ticket.getCompletedAt());
                System.out.println("Manager: " + ticket.getManager());

            } else {
                responseJSON.put("status", "failure");
                responseJSON.put("message", "Ticket not found for ID: " + ticketId);
                responseJSON.put("pageName", "");
            }

            transaction.commit();
            return responseJSON;

        } catch (HibernateException e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
            responseJSON.put("status", "failure");
            responseJSON.put("message", "Error retrieving ticket");
            responseJSON.put("pageName", "");
            return responseJSON;

        } finally {
            if (session != null) session.close();
        }
    }

    

    // Add a new ticket
    public String addTicket(TicketsModel ticket) {
        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();
            session.save(ticket);
            transaction.commit();
        } catch (HibernateException e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
            return "Failed to add ticket";
        } finally {
            if (session != null) session.close();
        }
        return "Ticket added successfully";
    }

    // Update an existing ticket
    public String updateTicket(TicketsModel ticket) {
        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();
            session.update(ticket);
            transaction.commit();
        } catch (HibernateException e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
            return "Failed to update ticket";
        } finally {
            if (session != null) session.close();
        }
        return "Ticket updated successfully";
    }

    // Delete a ticket by id
    public String deleteTicket(int id) {
        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();
            TicketsModel ticket = (TicketsModel) session.get(TicketsModel.class, id);
            if (ticket != null) {
                session.delete(ticket);
                transaction.commit();
                return "Ticket deleted successfully";
            } else {
                return "Ticket not found";
            }
        } catch (HibernateException e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
            return "Failed to delete ticket";
        } finally {
            if (session != null) session.close();
        }
    }
}
