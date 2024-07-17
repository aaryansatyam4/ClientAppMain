//package com.digicode.controller;
//
//import java.io.IOException;
//import java.util.HashSet;
//import java.util.Set;
//
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
//import com.digicode.model.TaskSubgroupModel;
//import com.digicode.model.TasksGroupModel;
//import com.digicode.model.TicketsModel;
//
//@WebServlet("/CreateGroupServlet")
//public class CreateGroupServlet extends HttpServlet {
//    private static final long serialVersionUID = 1L;
//
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        // Retrieve form data
//        String groupName = request.getParameter("groupName");
//        String subgroupName = request.getParameter("subgroupName");
//        String ticketsInput = request.getParameter("tickets");
//        String[] tickets = ticketsInput.split("\\r?\\n"); // Split by newline
//        
//        
//        TasksGroupModel grp= new TasksGroupModel();
//        grp.setGroupName(groupName);
//        
//        TaskSubgroupModel sub= new TaskSubgroupModel();
//        sub.setSubgroupName(subgroupName);
//        sub.setParentGroup(grp);
//        
//        grp.addSubgroup(sub);
//        
//         Set<TicketsModel> ticks = new HashSet<>();
//         for (String ticketLine : tickets) {
//        	    if (ticketLine != null && !ticketLine.trim().isEmpty()) {
//        	        TicketsModel ticket = new TicketsModel();
//        	        ticket.setTicketName(ticketLine.trim());
//        	        ticket.setTaskSubgroup(sub);
//        	        ticks.add(ticket);
//        	    }
//        }
//        sub.setTickets(ticks);
//        
//        
//        //Testing
//        System.out.println("Group: " + groupName);
//        System.out.println("SubGroup: " + subgroupName);
//        for (String ticket : tickets) {
//            
//            System.out.println("Ticket: " + ticket);
//        }
//
//        
//    }
//}
package com.digicode.controller;

import java.io.IOException;
import java.util.HashSet;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

import com.digicode.model.TaskSubgroupModel;
import com.digicode.model.TasksGroupModel;
import com.digicode.model.TicketsModel;

@WebServlet("/CreateGroupServlet")
public class CreateGroupServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private SessionFactory sessionFactory;

    @Override
    public void init() throws ServletException {
        // Initialize Hibernate SessionFactory
        sessionFactory = new Configuration().configure().buildSessionFactory();
    }

    @Override
    public void destroy() {
        // Close Hibernate SessionFactory
        if (sessionFactory != null) {
            sessionFactory.close();
        }
    }
    String subgrp= "New";
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Session session = null;
        Transaction transaction = null;
        
        try {
            // Retrieve form data
            String groupName = request.getParameter("groupName");
            String subgroupName = request.getParameter("subgroupName");
            String ticketsInput = request.getParameter("tickets");
            String[] tickets = ticketsInput.split("[,\\s\\r?\\n]+"); // Split by newline
            
            // Testing
            System.out.println("Group: " + groupName);
            System.out.println("SubGroup: " + subgroupName);
            for (String ticket : tickets) {
                System.out.println("Ticket: " + ticket);
            }

            // Initialize Hibernate session and transaction
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();

            // Check if group exists
            TasksGroupModel group = fetchOrCreateGroup(session, groupName);

            // Check if subgroup exists under the retrieved group or independently
            TaskSubgroupModel subgroup = fetchOrCreateSubgroup(session, group, subgroupName);
            
            Set<String> existingTickets= new HashSet<>();
            for(TicketsModel ticket : subgroup.getTickets()) {
            	existingTickets.add(ticket.getTicketName().toLowerCase());
            }
            // Create and add tickets to the subgroup
            Set<TicketsModel> ticks = new HashSet<>();
            for (String ticketLine : tickets) {
                if (ticketLine != null && !ticketLine.trim().isEmpty() && !existingTickets.contains(ticketLine.toLowerCase())) {
                    TicketsModel ticket = new TicketsModel();
                    ticket.setTicketName(ticketLine.trim());
                    ticket.setTaskSubgroup(subgroup);
                    if(subgrp.equals("New")) {
                    	ticks.add(ticket);
                    }else {
                    	subgroup.addTicket(ticket);
                    }
                }else if (existingTickets.contains(ticketLine.toLowerCase())) {
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    response.getWriter().write("Ticket '" + ticketLine + "' already exists in the subgroup.");
                    
                }
            }
            
            if(subgrp.equals("New")) {
            	subgroup.setTickets(ticks);
            }
            

            // Save or update subgroup and tickets
            session.saveOrUpdate(subgroup);
            
            
            // Commit the transaction
            transaction.commit();
            System.out.println("YO!");
           

        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }

    private TasksGroupModel fetchOrCreateGroup(Session session, String groupName) {
        TasksGroupModel group = (TasksGroupModel) session.createQuery("FROM TasksGroupModel WHERE groupName = :groupName")
                .setParameter("groupName", groupName)
                .uniqueResult();

        if (group == null) {
            group = new TasksGroupModel();
            group.setGroupName(groupName);
            session.save(group);
        }

        return group;
    }

    private TaskSubgroupModel fetchOrCreateSubgroup(Session session, TasksGroupModel group, String subgroupName) {
        TaskSubgroupModel subgroup = (TaskSubgroupModel) session.createQuery(
                "FROM TaskSubgroupModel WHERE subgroupName = :subgroupName AND parentGroup = :group")
                .setParameter("subgroupName", subgroupName)
                .setParameter("group", group)
                .uniqueResult();
        
        if (subgroup == null) {
            subgroup = new TaskSubgroupModel();
            subgroup.setSubgroupName(subgroupName);
            subgroup.setParentGroup(group);
            session.save(subgroup);
        } else {
        	subgrp= "Existing";
        }

        return subgroup;
    }

}
