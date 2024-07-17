package com.digicode.dao;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import org.hibernate.criterion.Restrictions;

import com.digicode.model.TaskModel;
import com.google.gson.Gson;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

public class TasksServiceImpl {

    Configuration configuration = new Configuration().configure();
     @SuppressWarnings("deprecation")
	SessionFactory sessionFactory = configuration.buildSessionFactory();
    static Session session = null;
    Transaction transaction = null;
    String response = null;
//all task
    @SuppressWarnings("unchecked")
    public  String getAllTasks() { 
        List<TaskModel> tasks = null;
        Gson gson = new Gson();
        String DataofTick = null;
        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();
            tasks = session.createQuery("FROM TaskModel").list();
          //  transaction.commit();
            
           
            DataofTick = gson.toJson(tasks);
            System.out.println("Data of tick: " + tasks);
        } catch (HibernateException e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
        } finally {
            if (session != null) session.close();
        }
       

        return DataofTick ;
    }
//task of user
    @SuppressWarnings("unchecked")
    public String getAllTasksOfUser(HttpServletRequest request) {
        List<TaskModel> tasks = null;
        String userId = null;

        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("username")) {
                    userId = cookie.getValue();
                    break;
                }
            }
        }

        if (userId != null) {
            try {
                session = sessionFactory.openSession();
                transaction = session.beginTransaction();
                tasks = session.createQuery("FROM TaskModel WHERE assignee = :userId")
                        .setParameter("userId", userId).list();
                
            } catch (HibernateException e) {
                if (transaction != null) transaction.rollback();
                e.printStackTrace();
            } finally {
                if (session != null) session.close();
            }
        }
        Gson gson = new Gson();
        String DataofempList = gson.toJson(tasks);
        System.out.println("Data of emp: " + tasks);

        return DataofempList ;
        
        
    }
    
    //add task
    public String addTask(TaskModel task) {
        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();
            session.save(task);
        } catch (HibernateException e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
            return "Failed to add task";
        } finally {
            if (session != null) session.close();
        }
        return "Task added successfully";
    }

    //remove task
    public String removeTask(TaskModel task) {
        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();
            session.delete(task);
        } catch (HibernateException e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
            return "Failed to Rempve task";
        } finally {
            if (session != null) session.close();
        }
        return "Task Removed successfully";
    }
    
  //update task
    public String updateTask(TaskModel task) {
        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();
            session.update(task);
          
        } catch (HibernateException e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
            return "Failed to update task";
        } finally {
            if (session != null) session.close();
        }
        return "Task updated successfully";
    }
    
    //search by id
    @SuppressWarnings("unchecked")
	public String searchTasks(String searchCriteria) {
        List<TaskModel> tasks = null;
        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();

            Criteria criteria = session.createCriteria(TaskModel.class);
            criteria.add(Restrictions.or(
                Restrictions.ilike("ticketName", "%" + searchCriteria + "%"),
                Restrictions.ilike("ticketDescription", "%" + searchCriteria + "%"),
                Restrictions.ilike("createdBy", "%" + searchCriteria + "%"),
                Restrictions.ilike("assignee", "%" + searchCriteria + "%"),
                Restrictions.ilike("severity", "%" + searchCriteria + "%"),
                Restrictions.ilike("remark", "%" + searchCriteria + "%"),
                Restrictions.ilike("status", "%" + searchCriteria + "%"),
                Restrictions.ilike("manager", "%" + searchCriteria + "%")
            ));

            tasks = criteria.list();

            transaction.commit();
        } catch (HibernateException e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
        } finally {
            if (session != null) session.close();
        }
        Gson gson = new Gson();
        return gson.toJson(tasks);
    }

    
    
}