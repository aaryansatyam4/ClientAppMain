package com.digicode.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

import com.digicode.model.EmployeeModel;
import com.digicode.model.TicketsModel;

public class LoginServiceImpl {
Configuration configuration = new Configuration().configure();
SessionFactory sessionFactory = configuration.buildSessionFactory();
Session session = null;
Transaction transaction = null;
String user_role=null;

public boolean chkcredentials(String user, String password) {
    boolean res = false;
    try {
        session = sessionFactory.openSession();
        transaction = session.beginTransaction();
        
        // Querying the EmployeeModel to check credentials
        Query query = session.createQuery("from EmployeeModel where userId=:username and password=:password");
        query.setParameter("username", user);
        query.setParameter("password", password);
        
        EmployeeModel empModel = (EmployeeModel) query.uniqueResult(); // Ensure type casting to EmployeeModel

        if (empModel != null) {
            res = true;
            System.out.println("User authenticated: " + empModel.getUserId());
            user_role= empModel.getPosition();
            
        } else {
            System.out.println("Invalid credentials for email: " + user);
        }
        transaction.commit(); // Commit the transaction
    } catch (HibernateException e) {
        if (transaction != null) {
            transaction.rollback(); 
        }
        System.out.println("Error in authentication: " + e.getMessage());
    } finally {
        if (session != null) {
            session.close(); // Close the session
        }
    }
    return res;
}

public EmployeeModel getUserById(String userId) {
    Session session = null;
    EmployeeModel user = null;
    try {
        session = sessionFactory.openSession();
        Transaction transaction = session.beginTransaction();
        Object result = session.get(EmployeeModel.class, userId);
        transaction.commit();

        if (result != null && result instanceof EmployeeModel) {
            user = (EmployeeModel) result;
        }
    } catch (HibernateException e) {
        if (session != null && session.getTransaction() != null) {
            session.getTransaction().rollback();
        }
        e.printStackTrace();
    } finally {
        if (session != null) session.close();
    }

    return user;
}

@SuppressWarnings("unchecked")
public List<EmployeeModel> listAllEmplyee() {
    List<EmployeeModel> empList = new ArrayList<EmployeeModel>();
    try {
        session = sessionFactory.openSession();
        transaction = session.beginTransaction();
        Query query = session.createQuery("from EmployeeModel");
        empList = query.list();
    } catch (HibernateException e) {
        System.out.println(e.getMessage());
    } finally {
        if (session != null) {
            session.close(); // Close the session
        }
    }
    return empList;
}

@SuppressWarnings("unchecked")
public List<TicketsModel> listAllTasks() {
    List<TicketsModel> taskList = new ArrayList<TicketsModel>();
    try {
        session = sessionFactory.openSession();
        transaction = session.beginTransaction();
        Query query = session.createQuery("from TaskModel");
        taskList = query.list();
    } catch (HibernateException e) {
        System.out.println(e.getMessage());
    } finally {
        if (session != null) {
            session.close(); // Close the session
        }
    }
    return taskList;
}
public boolean updateUser(EmployeeModel user) {
    Session session = null;
    try {
        session = sessionFactory.openSession();
        Transaction transaction = session.beginTransaction();

        EmployeeModel existingUser = (EmployeeModel) session.get(EmployeeModel.class, user.getUserId());

        if (existingUser != null) {
            updateFields(existingUser, user); // Update only non-null fields

            session.update(existingUser); // Update the entity in the session

            transaction.commit();
            return true;
        } else {
            // Handle case where user doesn't exist
            return false;
        }
    } catch (HibernateException e) {
        if (session != null && session.getTransaction() != null) {
            session.getTransaction().rollback();
        }
        e.printStackTrace();
        return false;
    } finally {
        if (session != null) {
            session.close(); // Close the session in finally block
        }
    }
}

private void updateFields(EmployeeModel existingUser, EmployeeModel newUser) {
    if (newUser.getFirstName() != null && !newUser.getFirstName().isEmpty()) {
        existingUser.setFirstName(newUser.getFirstName());
    }
    if (newUser.getLastName() != null && !newUser.getLastName().isEmpty()) {
        existingUser.setLastName(newUser.getLastName());
    }
    if (newUser.getEmail() != null && !newUser.getEmail().isEmpty()) {
        existingUser.setEmail(newUser.getEmail());
    }
    if (newUser.getContact_no() != null && !newUser.getContact_no().isEmpty()) {
        existingUser.setContact_no(newUser.getContact_no());
    }
    if (newUser.getAddress() != null && !newUser.getAddress().isEmpty()) {
        existingUser.setAddress(newUser.getAddress());
    }
    if (newUser.getCity() != null && !newUser.getCity().isEmpty()) {
        existingUser.setCity(newUser.getCity());
    }
    if (newUser.getState() != null && !newUser.getState().isEmpty()) {
        existingUser.setState(newUser.getState());
    }
    if (newUser.getCountry() != null && !newUser.getCountry().isEmpty()) {
        existingUser.setCountry(newUser.getCountry());
    }
    if (newUser.getPin() != null && !newUser.getPin().isEmpty()) {
        existingUser.setPin(newUser.getPin());
    }
    if (newUser.getPassword() != null && !newUser.getPassword().isEmpty()) {
        existingUser.setPassword(newUser.getPassword());
    }
    // Add more fields as needed
}

public boolean updatePassword(String userId, String newPassword) {
    Session session = null;
    try {
        session = sessionFactory.openSession();
        Transaction transaction = session.beginTransaction();

        EmployeeModel existingUser = (EmployeeModel) session.get(EmployeeModel.class, userId);

        if (existingUser != null) {
            existingUser.setPassword(newPassword); // Update the password

            session.update(existingUser); // Update the entity in the session

            transaction.commit();
            return true;
        } else {
            // Handle case where user doesn't exist
            return false;
        }
    } catch (HibernateException e) {
        if (session != null && session.getTransaction() != null) {
            session.getTransaction().rollback();
        }
        e.printStackTrace();
        return false;
    } finally {
        if (session != null) {
            session.close(); // Close the session in finally block
        }
    }
}
public int countTransfersByUser(String assignee) {
    Session session = null;
    try {
        session = sessionFactory.openSession();
        Long count = (Long) session.createQuery("select count(*) from TicketLogs where createdBy = :assignee")
                                  .setParameter("assignee", assignee)
                                  .uniqueResult();
        return count != null ? count.intValue() : 0;
    } catch (HibernateException e) {
        e.printStackTrace();
        return 0;
    } finally {
        if (session != null) {
            session.close();
        }
    }
}


public String getUserRole() {
    return user_role;
}
	
	


}