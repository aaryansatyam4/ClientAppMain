package com.digicode.controller;

import com.digicode.model.EmployeeModel;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/fetchUsers1")
public class FetchUsersServlet extends HttpServlet {

    private SessionFactory sessionFactory;

    @Override
    public void init() throws ServletException {
        super.init();
        // Initialize Hibernate SessionFactory
        sessionFactory = new Configuration().configure().buildSessionFactory();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Session session = sessionFactory.openSession();
        try {
            // Fetch employees from database
            List<EmployeeModel> employees = session.createQuery("FROM EmployeeModel").list();

            // Convert employees to JSON format
            resp.setContentType("application/json");
            PrintWriter out = resp.getWriter();
            out.println("["); // Start JSON array
            for (int i = 0; i < employees.size(); i++) {
                EmployeeModel employee = employees.get(i);
                out.println("{\"userId\":\"" + employee.getUserId() + "\",\"userName\":\"" + employee.getFirstName() + " " + employee.getLastName() + "\"}");
                if (i < employees.size() - 1) {
                    out.println(",");
                }
            }
            out.println("]"); // End JSON array

        } catch (Exception e) {
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
}
