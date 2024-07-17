package com.digicode.dao;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import com.digicode.model.TaskSubgroupModel;
import com.google.gson.Gson;

import java.util.List;

public class TaskSubgroupServiceImpl {

    Configuration configuration = new Configuration().configure();
    @SuppressWarnings("deprecation")
	SessionFactory sessionFactory = configuration.buildSessionFactory();
    Session session = null;
    Transaction transaction = null;

    // Get all task subgroups
    @SuppressWarnings("unchecked")
    public String getAllTaskSubgroups() {
        List<TaskSubgroupModel> subgroups = null;
        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();
            subgroups = session.createQuery("FROM TaskSubgroupModel").list();
            transaction.commit();
        } catch (HibernateException e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
        } finally {
            if (session != null) session.close();
        }
        Gson gson = new Gson();
        return gson.toJson(subgroups);
    }

    // Get task subgroup by ID
    @SuppressWarnings("unchecked")
	public String searchTaskSubgroups(String searchText) {
        List<TaskSubgroupModel> subgroups = null;
        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();
            subgroups = session.createQuery("FROM TaskSubgroupModel WHERE " +
                            "id = :searchText OR " +
                            "subgroupName LIKE :searchTextPattern OR " +
                            "subgroupDescription LIKE :searchTextPattern OR " +
                            "subgroupLocation LIKE :searchTextPattern OR " +
                            "subgroupStatus LIKE :searchTextPattern")
                    .setParameter("searchText", parseIntOrZero(searchText))
                    .setParameter("searchTextPattern", "%" + searchText + "%")
                    .list();
            transaction.commit();
        } catch (HibernateException e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
        } finally {
            if (session != null) session.close();
        }
        Gson gson = new Gson();
        return gson.toJson(subgroups);
    }


    private Object parseIntOrZero(String searchText) {		
		return null;
	}

	// Add a new task subgroup
    public String addTaskSubgroup(TaskSubgroupModel subgroup) {
        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();
            session.save(subgroup);
            transaction.commit();
        } catch (HibernateException e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
            return "Failed to add task subgroup";
        } finally {
            if (session != null) session.close();
        }
        return "Task subgroup added successfully";
    }

    // Update an existing task subgroup
    public String updateTaskSubgroup(TaskSubgroupModel subgroup) {
        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();
            session.update(subgroup);
            transaction.commit();
        } catch (HibernateException e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
            return "Failed to update task subgroup";
        } finally {
            if (session != null) session.close();
        }
        return "Task subgroup updated successfully";
    }

    // Delete a task subgroup by ID
    public String deleteTaskSubgroup(int id) {
        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();
            TaskSubgroupModel subgroup = (TaskSubgroupModel) session.get(TaskSubgroupModel.class, id);
            if (subgroup != null) {
                session.delete(subgroup);
                transaction.commit();
                return "Task subgroup deleted successfully";
            } else {
                return "Task subgroup not found";
            }
        } catch (HibernateException e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
            return "Failed to delete task subgroup";
        } finally {
            if (session != null) session.close();
        }
    }
}
