package com.digicode.dao;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import com.digicode.model.TicketLogs;
import com.google.gson.Gson;
import org.hibernate.criterion.Restrictions;

import java.util.List;

@SuppressWarnings("deprecation")
public class TicketLogServiceImpl {

    private Configuration configuration = new Configuration().configure();
    private SessionFactory sessionFactory = configuration.buildSessionFactory();
    private Session session = null;
    private Transaction transaction = null;

    // Get all ticket logs
    @SuppressWarnings("unchecked")
    public String getAllTicketLogs() {
        List<TicketLogs> ticketLogs = null;
        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();
            ticketLogs = session.createQuery("FROM TicketLogs").list();
            transaction.commit();
        } catch (HibernateException e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
        } finally {
            if (session != null) session.close();
        }
        Gson gson = new Gson();
        return gson.toJson(ticketLogs);
    }



    // Search ticket logs globally by any attribute
    @SuppressWarnings("unchecked")
	public String searchTicketLogs(String searchCriteria) {
        List<TicketLogs> ticketLogs = null;
        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();

            Criteria criteria = session.createCriteria(TicketLogs.class);
            criteria.add(Restrictions.or(
                    Restrictions.ilike("logData", "%" + searchCriteria + "%"),
                    Restrictions.ilike("createdBy", "%" + searchCriteria + "%"),
                    Restrictions.ilike("assignee", "%" + searchCriteria + "%"),
                    Restrictions.ilike("id", "%" + searchCriteria + "%")
                    // Add more restrictions as needed
            ));

            ticketLogs = criteria.list();

            transaction.commit();
        } catch (HibernateException e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
        } finally {
            if (session != null) session.close();
        }
        Gson gson = new Gson();
        return gson.toJson(ticketLogs);
    }

    // Add a new ticket log
    public String addTicketLog(TicketLogs ticketLog) {
        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();
            session.save(ticketLog);
            transaction.commit();
        } catch (HibernateException e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
            return "Failed to add ticket log";
        } finally {
            if (session != null) session.close();
        }
        return "Ticket log added successfully";
    }

    // Update an existing ticket log
    public String updateTicketLog(TicketLogs ticketLog) {
        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();
            session.update(ticketLog);
            transaction.commit();
        } catch (HibernateException e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
            return "Failed to update ticket log";
        } finally {
            if (session != null) session.close();
        }
        return "Ticket log updated successfully";
    }

    // Delete a ticket log by ID
    public String deleteTicketLog(int id) {
        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();
            TicketLogs ticketLog = (TicketLogs) session.get(TicketLogs.class, id);
            if (ticketLog != null) {
                session.delete(ticketLog);
                transaction.commit();
                return "Ticket log deleted successfully";
            } else {
                return "Ticket log not found";
            }
        } catch (HibernateException e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
            return "Failed to delete ticket log";
        } finally {
            if (session != null) session.close();
        }
    }
}
