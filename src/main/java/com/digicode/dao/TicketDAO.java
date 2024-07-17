package com.digicode.dao;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.hibernate.Query; // Import correct Query class for older Hibernate versions

import java.util.List;
import com.digicode.model.TasksGroupModel;
import com.digicode.model.TaskSubgroupModel;
import com.digicode.model.TicketsModel;

public class TicketDAO {
    private static SessionFactory factory;

    static {
        factory = new Configuration().configure("hibernate.cfg.xml").buildSessionFactory();
    }

    public List<TasksGroupModel> getTicketGroups() {
        Session session = null;
        List<TasksGroupModel> ticketGroups = null;
        try {
            session = factory.openSession();
            session.beginTransaction();
            Query query = session.createQuery("FROM TasksGroupModel");
            ticketGroups = query.list();
            session.getTransaction().commit();
        } catch (Exception e) {
            if (session != null) {
                session.getTransaction().rollback();
            }
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return ticketGroups;
    }

    public List<TaskSubgroupModel> getSubgroupsByGroupId(int groupId) {
        Session session = null;
        List<TaskSubgroupModel> subgroups = null;
        try {
            session = factory.openSession();
            session.beginTransaction();
            Query query = session.createQuery("FROM TaskSubgroupModel WHERE parent_id = :groupId");
            query.setParameter("groupId", groupId);
            subgroups = query.list();
            session.getTransaction().commit();
        } catch (Exception e) {
            if (session != null) {
                session.getTransaction().rollback();
            }
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return subgroups;
    }

    public List<TicketsModel> getTicketsBySubgroupId(int subgroupId) {
        Session session = null;
        List<TicketsModel> tickets = null;
        try {
            session = factory.openSession();
            session.beginTransaction();
            Query query = session.createQuery("FROM TicketsModel WHERE subgroup_id = :subgroupId");
            query.setParameter("subgroupId", subgroupId);
            tickets = query.list();
            session.getTransaction().commit();
        } catch (Exception e) {
            if (session != null) {
                session.getTransaction().rollback();
            }
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return tickets;
    }
}
