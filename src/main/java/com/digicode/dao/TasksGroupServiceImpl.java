package com.digicode.dao;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import com.digicode.model.TasksGroupModel;
import com.google.gson.Gson;

import java.util.List;

public class TasksGroupServiceImpl {

    Configuration configuration = new Configuration().configure();
    @SuppressWarnings("deprecation")
	SessionFactory sessionFactory = configuration.buildSessionFactory();
    Session session = null;
    Transaction transaction = null;

    // Get all tasks groups
    @SuppressWarnings("unchecked")
    public String getAllTasksGroups() {
        List<TasksGroupModel> groups = null;
        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();
            groups = session.createQuery("FROM TasksGroupModel").list();
            transaction.commit();
        } catch (HibernateException e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
        } finally {
            if (session != null) session.close();
        }
        Gson gson = new Gson();
        return gson.toJson(groups);
    }

    // Get tasks group by ID
    public TasksGroupModel getTasksGroupById(int id) {
        TasksGroupModel group = null;
        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();
            group = (TasksGroupModel) session.get(TasksGroupModel.class, id);
            transaction.commit();
        } catch (HibernateException e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
        } finally {
            if (session != null) session.close();
        }
        return group;
    }

    // Add a new tasks group
    public String addTasksGroup(TasksGroupModel group) {
        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();
            session.save(group);
            transaction.commit();
        } catch (HibernateException e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
            return "Failed to add tasks group";
        } finally {
            if (session != null) session.close();
        }
        return "Tasks group added successfully";
    }

    // Update an existing tasks group
    public String updateTasksGroup(TasksGroupModel group) {
        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();
            session.update(group);
            transaction.commit();
        } catch (HibernateException e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
            return "Failed to update tasks group";
        } finally {
            if (session != null) session.close();
        }
        return "Tasks group updated successfully";
    }

    // Delete a tasks group by ID
    public String deleteTasksGroup(int id) {
        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();
            TasksGroupModel group = (TasksGroupModel) session.get(TasksGroupModel.class, id);
            if (group != null) {
                session.delete(group);
                transaction.commit();
                return "Tasks group deleted successfully";
            } else {
                return "Tasks group not found";
            }
        } catch (HibernateException e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
            return "Failed to delete tasks group";
        } finally {
            if (session != null) session.close();
        }
    }

    // Global search by various fields
    @SuppressWarnings("unchecked")
    public String searchTasksGroups(String searchText) {
        List<TasksGroupModel> groups = null;
        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();
            groups = session.createQuery("FROM TasksGroupModel WHERE " +
                            "id = :searchText OR " +
                            "groupName LIKE :searchTextPattern OR " +
                            "groupDescription LIKE :searchTextPattern OR " +
                            "groupLocation LIKE :searchTextPattern OR " +
                            "groupStatus LIKE :searchTextPattern")
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
        return gson.toJson(groups);
    }

    private int parseIntOrZero(String text) {
        try {
            return Integer.parseInt(text);
        } catch (NumberFormatException e) {
            return 0;
        }
    }
}
