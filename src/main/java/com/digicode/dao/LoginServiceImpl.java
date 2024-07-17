package com.digicode.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

import com.digicode.model.EmployeeModel;
import com.digicode.model.TicketsModel;

public class LoginServiceImpl {
	
	String user_role=null;
	
    Configuration configuration = new Configuration().configure();
    SessionFactory sessionFactory = configuration.buildSessionFactory();
    Session session = null;
    Transaction transaction = null;

    public boolean chkcredentials(String user, String pass) {
        boolean res = false;
        
        
        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();
            Query query = session.createQuery("from EmployeeModel where userId=:username and password=:pass");
            query.setParameter("username", user);
            query.setParameter("pass", pass);
            EmployeeModel usrModelObj = (EmployeeModel) query.uniqueResult();

            if (usrModelObj != null) {
                res = true;
                
                System.out.println("User: " + usrModelObj.getUserId());
                user_role= usrModelObj.getPosition();
                System.out.println("role" + user_role);
                
            } else {
                System.out.println("User: err");
                res = false;
            }
            transaction.commit();
        } catch (HibernateException e) {
            if (transaction != null) transaction.rollback();
            System.out.println(e.getMessage());
            System.out.println("error");
        } finally {
            if (session != null) session.close();
        }
        return res;
    }
    
    public EmployeeModel getUserById(String userId) {
       
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
    public List<EmployeeModel> listAllEmployee() {
        List<EmployeeModel> usrModelObj = new ArrayList<>();
       
        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();
            Query query = session.createQuery("from EmployeeModel");
            usrModelObj = query.list();
            transaction.commit();
        } catch (HibernateException e) {
            if (transaction != null) transaction.rollback();
            System.out.println(e.getMessage());
        } finally {
            if (session != null) session.close();
        }
        return usrModelObj;
    }

    @SuppressWarnings("unchecked")
    public List<TicketsModel> listAllTasks() {
        List<TicketsModel> taskModelObj = new ArrayList<>();
       
        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();
            Query query = session.createQuery("from TicketsModel");
            taskModelObj = query.list();
            transaction.commit();
        } catch (HibernateException e) {
            if (transaction != null) transaction.rollback();
            System.out.println(e.getMessage());
        } finally {
            if (session != null) session.close();
        }
        return taskModelObj;
    }
    
    public String getUserRole() {
        return user_role;
    }

	@SuppressWarnings("unchecked")
	public List<EmployeeModel> listEmployeesByAdmin(String adminId) {
		List<EmployeeModel> usrModelObj = new ArrayList<>();
       
        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();
            Query query = session.createQuery("from EmployeeModel where employer=:admin");
            query.setParameter("admin", adminId);
            usrModelObj = query.list();
            transaction.commit();
        } catch (HibernateException e) {
            if (transaction != null) transaction.rollback();
            System.out.println(e.getMessage());
        } finally {
            if (session != null) session.close();
        }
        return usrModelObj;
	}
	public boolean updateUser(EmployeeModel user) {
	   
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

	@SuppressWarnings("unchecked")
	public List<TicketsModel> getUnreadTicketsByAssignee(String assignee) {
	    List<TicketsModel> unreadTickets = new ArrayList<>();
	    try {
	        session = sessionFactory.openSession();
	        transaction = session.beginTransaction();
	        Query query = session.createQuery("from TicketsModel where assignee = :assignee and checkRead = false");
	        query.setParameter("assignee", assignee);
	        unreadTickets = query.list();
	    } catch (HibernateException e) {
	        if (transaction != null) {
	            transaction.rollback();
	        }
	        e.printStackTrace();
	    } finally {
	        if (session != null) {
	            session.close();
	        }
	    }
	    return unreadTickets;
	}

	public void markAllTicketsAsRead(String assignee) {
	    try {
	        session = sessionFactory.openSession();
	        transaction = session.beginTransaction();
	        
	        Query query = session.createQuery("update TicketsModel set checkRead = true where assignee = :assignee and checkRead = false");
	        System.out.println("USERNAME:"+assignee);
	        query.setParameter("assignee", assignee);
	        int rowsUpdated = query.executeUpdate();
	        
	        transaction.commit();
	        System.out.println(rowsUpdated + " tickets marked as read for assignee: " + assignee);
	    } catch (HibernateException e) {
	        if (transaction != null) {
	            transaction.rollback();
	        }
	        e.printStackTrace();
	    } finally {
	        if (session != null) {
	            session.close();
	        }
	    }
	}

}



