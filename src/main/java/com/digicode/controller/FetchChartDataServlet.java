package com.digicode.controller;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.digicode.model.TicketsModel;
import com.google.gson.Gson;

@WebServlet("/fetchChartData")
public class FetchChartDataServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
    	Map<String, List<Long>> plantCounts = new HashMap<>();
        plantCounts.put("Plant 1", getMonthlyTicketCounts("A1001"));
        plantCounts.put("Plant 2", getMonthlyTicketCounts("A1002"));
        plantCounts.put("Plant 3", getMonthlyTicketCounts("A1003"));
        printPlantCounts(plantCounts);


        Gson gson = new Gson();
        String json = gson.toJson(plantCounts);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.print(json);
        out.flush();
    }
    private void printPlantCounts(Map<String, List<Long>> plantCounts) {
        for (Map.Entry<String, List<Long>> entry : plantCounts.entrySet()) {
            System.out.println("Plant: " + entry.getKey());
            System.out.println("Counts: " + entry.getValue());
        }
    }

    public List<Long> getMonthlyTicketCounts(String plant_admin_id) {
    	Configuration configuration = new Configuration().configure();
    	SessionFactory sessionFactory = configuration.buildSessionFactory();
        List<Long> monthlyCounts = new ArrayList<>();
        Session session = null;
        Transaction transaction = null;

        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();

            for (int month = 0; month < 12; month++) {
                Query query = session.createQuery(
                    "SELECT COUNT(*) FROM TicketsModel WHERE created_by = 'Super_Admin' AND MONTH(created_at) =:month and employee_id =:admin");
                query.setParameter("admin", plant_admin_id);
                query.setParameter("month", month + 1);
                Long count = (Long) query.uniqueResult();
                System.out.println(count);
                monthlyCounts.add(count != null ? count : 0L);
            }

            transaction.commit();
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

        return monthlyCounts;
    }

    
}
