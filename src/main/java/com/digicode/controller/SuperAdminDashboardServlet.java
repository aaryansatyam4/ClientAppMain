package com.digicode.controller;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import javax.servlet.http.Cookie;

import com.digicode.model.TicketsModel;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.util.ArrayList;
import java.util.List;
import com.nimbusds.jose.shaded.json.JSONObject;

@WebServlet("/SuperAdminDashboardServlet")
public class SuperAdminDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private SessionFactory sessionFactory;

    @Override
    public void init() throws ServletException {
        super.init();
        sessionFactory = new Configuration().configure().buildSessionFactory();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = "Guest";
        Long highSeverityCount = 0L;
        Long mediumSeverityCount = 0L;
        Long lowSeverityCount = 0L;
        Long completedCount = 0L;
        Long total = 0L;
        List<TicketsModel> assigned= new ArrayList<>();

        // Retrieve username from cookies (left out for brevity)

        Session hibernateSession = null;
        try {
            hibernateSession = sessionFactory.openSession();
            Transaction transaction = hibernateSession.beginTransaction();
            assigned = (List<TicketsModel>) hibernateSession.createQuery("FROM TicketsModel WHERE created_by= :'super_admin' AND status !='Completed'");
            // Query count of tickets by severity
            highSeverityCount = (Long) hibernateSession.createQuery("SELECT COUNT(*) FROM TicketsModel WHERE severity = 'High' AND status != 'Completed'").uniqueResult();
            mediumSeverityCount = (Long) hibernateSession.createQuery("SELECT COUNT(*) FROM TicketsModel WHERE severity = 'Medium' AND status != 'Completed'").uniqueResult();
            lowSeverityCount = (Long) hibernateSession.createQuery("SELECT COUNT(*) FROM TicketsModel WHERE severity = 'Low' AND status != 'Completed'").uniqueResult();
            completedCount = (Long) hibernateSession.createQuery("SELECT COUNT(*) FROM TicketsModel WHERE status = 'Completed'").uniqueResult();
            total = highSeverityCount + mediumSeverityCount + lowSeverityCount + completedCount;

            transaction.commit();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (hibernateSession != null) {
                try {
                    hibernateSession.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }

        // Prepare JSON response
        JSONObject jsonResponse = new JSONObject();
        jsonResponse.put("highSeverityCount", highSeverityCount);
        jsonResponse.put("mediumSeverityCount", mediumSeverityCount);
        jsonResponse.put("lowSeverityCount", lowSeverityCount);
        jsonResponse.put("completedCount", completedCount);
        jsonResponse.put("total", total);

        // Send JSON response
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsonResponse.toString());
    }

    @Override
    public void destroy() {
        super.destroy();
        if (sessionFactory != null) {
            sessionFactory.close();
        }
    }
}