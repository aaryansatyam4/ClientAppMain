package com.digicode.controller;


import com.digicode.model.TicketsModel;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;

@WebServlet("/ticketAction")
public class TicketActionServlet1 extends HttpServlet {

    private static final String COMPLETED_STATUS = "Completed";

    private SessionFactory sessionFactory;

    @Override
    public void init() throws ServletException {
        super.init();
        try {
            sessionFactory = new Configuration().configure().buildSessionFactory();
        } catch (Exception e) {
            throw new ServletException("Failed to initialize Hibernate SessionFactory", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String ticketIdStr = req.getParameter("ticketId");
        String action = req.getParameter("action");
        String transferTo = req.getParameter("transferTo");
        String remarks = req.getParameter("remarks");

        if (ticketIdStr == null || action == null) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Required parameters are missing");
            return;
        }

        try {
            int ticketId = Integer.parseInt(ticketIdStr);
            processTicketAction(req, resp, ticketId, action, transferTo, remarks);
        } catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid ticket ID");
        }
    }

    private void processTicketAction(HttpServletRequest req, HttpServletResponse resp, int ticketId, String action, String transferTo, String remarks) throws IOException {
        Session session = sessionFactory.openSession();
        Transaction transaction = null;
        try {
            transaction = session.beginTransaction();
            TicketsModel ticket = (TicketsModel) session.get(TicketsModel.class, ticketId);

            if (ticket != null) {
                if ("completed".equalsIgnoreCase(action)) {
                    handleCompleteAction(ticket, remarks);
                } else if ("transfer".equalsIgnoreCase(action)) {
                    
                }
                session.update(ticket);
                transaction.commit();
                resp.sendRedirect(req.getContextPath() + "/ed.jsp");
            } else {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Ticket not found");
            }
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error processing ticket action");
        } finally {
            session.close();
        }
    }

    private void handleCompleteAction(TicketsModel ticket, String remarks) {
        ticket.setStatus(COMPLETED_STATUS);
        ticket.setRemark(remarks);
        Date currentDate = new Date();
        ticket.setCompletedAt(currentDate);
    }

   

    @Override
    public void destroy() {
        super.destroy();
        if (sessionFactory != null) {
            sessionFactory.close();
        }
    }

  
}
