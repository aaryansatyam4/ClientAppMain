package com.digicode.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

import com.digicode.model.TasksGroupModel;
import com.google.gson.Gson;

@WebServlet("/FetchGroupsServlet")
public class FetchGroupsServlet extends HttpServlet {
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

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Session session = null;
        try {
            // Initialize Hibernate session
            session = sessionFactory.openSession();

            // Create query to fetch all groups
            Query query = session.createQuery("FROM TasksGroupModel");
            List<TasksGroupModel> groups = query.list();

            // Convert groups to JSON
            Gson gson = new Gson();
            String json = gson.toJson(groups);

            // Send JSON response
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            PrintWriter out = response.getWriter();
            out.print(json);
            out.flush();

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }
}
