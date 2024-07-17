package com.digicode.controller;

import com.digicode.model.EmployeeModel;
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
import java.time.LocalDateTime;
import java.util.Date;

@WebServlet("/CreateTaskServlet")
public class CreateTaskServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private SessionFactory sessionFactory;

    @Override
    public void init() throws ServletException {
        // Initialize Hibernate session factory
        sessionFactory = new Configuration().configure("hibernate.cfg.xml").buildSessionFactory();
    }

    @Override
    public void destroy() {
        // Clean up Hibernate session factory
        if (sessionFactory != null) {
            sessionFactory.close();
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Process form data
        String groupName = request.getParameter("groupName");
        String subgroupName = request.getParameter("subgroupName");
        String ticketName = request.getParameter("ticketName");
        String ticketDescription = request.getParameter("ticketDescription");
        String dueDateStr = request.getParameter("dueDate");
        String severity = request.getParameter("severity");
        String assignedToId = request.getParameter("assignedTo");

        // Parse due date
        LocalDateTime dueDate = LocalDateTime.parse(dueDateStr + "T00:00:00"); // Adjust if needed

        // Prepare task object
        TicketsModel task = new TicketsModel();
        task.setTicketName(ticketName);
        task.setTicketDescription(ticketDescription);
        task.setCreatedAt(new Date());
        task.setUpdatedAt(new Date());
        task.setCreatedBy("Super_Admin");
        task.setUpdatedBy("Super_Admin");
        task.setManager("Super_Admin");
        task.setSeverity(severity);
        task.setStatus("pending");
        
        // Set status, remark, and subgroup to defaults as needed

        // Retrieve assigned employee
        // Implement fetching employee from database based on assignedToId
        // Example:
        // EmployeeService employeeService = new EmployeeService();
        // EmployeeModel assignedTo = employeeService.getEmployeeById(assignedToId);
        // task.setEmployee(assignedTo);

        // Retrieve subgroup
        // Implement fetching subgroup from database based on subgroupName
        // Example:
        // SubgroupService subgroupService = new SubgroupService();
        // Subgroup subgroup = subgroupService.getSubgroupByGroupNameAndSubgroupName(groupName, subgroupName);
        // task.setSubgroup(subgroup);

        // Persist task using Hibernate
        Session session = sessionFactory.openSession();
        Transaction transaction = null;
        try {
            transaction = session.beginTransaction();
            session.save(task);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        } finally {
            session.close();
        }

        // Respond to client
        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write("Task assigned successfully!");
    }
}
