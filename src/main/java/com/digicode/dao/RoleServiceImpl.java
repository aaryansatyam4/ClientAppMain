package com.digicode.dao;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import com.digicode.model.RoleModel;
import com.google.gson.Gson;

import java.util.List;

public class RoleServiceImpl {

    Configuration configuration = new Configuration().configure();
    @SuppressWarnings("deprecation")
	SessionFactory sessionFactory = configuration.buildSessionFactory();
    Session session = null;
    Transaction transaction = null;

    // Get all roles
    @SuppressWarnings("unchecked")
    public String getAllRoles() {
        List<RoleModel> roles = null;
        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();
            roles = session.createQuery("FROM RoleModel").list();
            transaction.commit();
        } catch (HibernateException e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
        } finally {
            if (session != null) session.close();
        }
        Gson gson = new Gson();
        return gson.toJson(roles);
    }

    // Get role by id
    public RoleModel getRoleById(int id) {
        RoleModel role = null;
        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();
            role = (RoleModel) session.get(RoleModel.class, id);
            transaction.commit();
        } catch (HibernateException e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
        } finally {
            if (session != null) session.close();
        }
        return role;
    }

    // Add a new role
    public String addRole(RoleModel role) {
        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();
            session.save(role);
            transaction.commit();
        } catch (HibernateException e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
            return "Failed to add role";
        } finally {
            if (session != null) session.close();
        }
        return "Role added successfully";
    }

    // Update an existing role
    public String updateRole(RoleModel role) {
        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();
            session.update(role);
            transaction.commit();
        } catch (HibernateException e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
            return "Failed to update role";
        } finally {
            if (session != null) session.close();
        }
        return "Role updated successfully";
    }

    // Delete a role by id
    public String deleteRole(int id) {
        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();
            RoleModel role = (RoleModel) session.get(RoleModel.class, id);
            if (role != null) {
                session.delete(role);
                transaction.commit();
                return "Role deleted successfully";
            } else {
                return "Role not found";
            }
        } catch (HibernateException e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
            return "Failed to delete role";
        } finally {
            if (session != null) session.close();
        }
    }
}
