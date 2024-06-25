package com.digicode.controller;

import com.digicode.model.TicketLogs;
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

    private SessionFactory sessionFactory;

    @Override
    public void init() throws ServletException {
        super.init();
        // Initialize Hibernate SessionFactory
        sessionFactory = new Configuration().configure().buildSessionFactory();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String ticketIdStr = req.getParameter("ticketId");
        String action = req.getParameter("action");
        String transferTo = req.getParameter("transferTo");
        String remarks = req.getParameter("remarks");

        int ticketId = Integer.parseInt(ticketIdStr);

        Session session = sessionFactory.openSession();
        Transaction transaction = null;
        try {
            transaction = session.beginTransaction();

            // Load the ticket from database
            TicketsModel ticket = (TicketsModel) session.get(TicketsModel.class, ticketId);

            if (ticket != null) {
                if ("completed".equals(action)) {
                    // Mark ticket as completed
                    ticket.setStatus("Completed");
                    ticket.setRemark(remarks); // Optional: Save remarks
                } else if ("transfer".equals(action)) {
                    // Transfer ticket to another user
                    String previousAssignee = ticket.getAssignee(); // get current assignee
                    ticket.setAssignee(transferTo);
                    ticket.setRemark(remarks); // Optional: Save remarks

                    // Log the transfer
                    TicketLogs log = new TicketLogs();
                    log.setLogData("Ticket transferred from " + previousAssignee + " to " + transferTo);
                    log.setLogDate(new Date());
                    log.setCreatedBy(previousAssignee); // Set who transferred
                    log.setAssignee(transferTo); // Set whom it was transferred to
                    log.setTicketId(ticket.getId());
                    session.save(log);

                    // Update transfer count in session attribute
                    int transferredCount = countTransfersByUser(session, previousAssignee);
                    req.getSession().setAttribute("transferredCount", transferredCount);
                }

                // Save the updated ticket
                session.update(ticket);
                transaction.commit();
            }

            // Redirect to employee_dashboard.jsp after processing
            resp.sendRedirect(req.getContextPath() + "/employee_dashboard.jsp");
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        } finally {
            session.close();
        }
    }

    @Override
    public void destroy() {
        super.destroy();
        if (sessionFactory != null) {
            sessionFactory.close();
        }
    }

    // Method to count transfers by a specific user
    private int countTransfersByUser(Session session, String assignee) {
        try {
            Long count = (Long) session.createQuery("select count(*) from TicketLogs where createdBy = :assignee")
                                      .setParameter("assignee", assignee)
                                      .uniqueResult();
            return count != null ? count.intValue() : 0;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
}
