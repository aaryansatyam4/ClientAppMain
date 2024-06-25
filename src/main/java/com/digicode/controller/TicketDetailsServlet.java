package com.digicode.controller;


import com.digicode.model.TicketsModel;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/TicketDetailsServlet1")
public class TicketDetailsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private SessionFactory sessionFactory;

    public void init() throws ServletException {
        sessionFactory = new Configuration().configure().buildSessionFactory();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String ticketId = request.getParameter("id");
        TicketsModel ticket = null;

        if (ticketId != null && !ticketId.isEmpty()) {
            Session session = sessionFactory.openSession();
            Transaction transaction = null;
            try {
                transaction = session.beginTransaction();
                ticket = (TicketsModel) session.get(TicketsModel.class, Integer.parseInt(ticketId));
                transaction.commit();
            } catch (Exception e) {
                if (transaction != null) {
                    transaction.rollback();
                }
                e.printStackTrace();
            } finally {
                session.close();
            }
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        Gson gson = new Gson();
        String jsonResponse = gson.toJson(ticket);
        response.getWriter().write(jsonResponse);
    }

    public void destroy() {
        if (sessionFactory != null) {
            sessionFactory.close();
        }
    }
}