package com.digicode.dao;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import com.digicode.model.PlantModel;
import com.google.gson.Gson;

import java.util.List;

public class PlantServiceImpl {

    Configuration configuration = new Configuration().configure();
    @SuppressWarnings("deprecation")
	SessionFactory sessionFactory = configuration.buildSessionFactory();
    Session session = null;
    Transaction transaction = null;

    // Get all plants
    @SuppressWarnings("unchecked")
    public String getAllPlants() {
        List<PlantModel> plants = null;
        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();
            plants = session.createQuery("FROM PlantModel").list();
            transaction.commit();
        } catch (HibernateException e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
        } finally {
            if (session != null) session.close();
        }
        Gson gson = new Gson();
        return gson.toJson(plants);
    }

    // Get plant by id
    public PlantModel getPlantById(int id) {
        PlantModel plant = null;
        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();
            plant = (PlantModel) session.get(PlantModel.class, id);
            transaction.commit();
        } catch (HibernateException e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
        } finally {
            if (session != null) session.close();
        }
        return plant;
    }

    // Add a new plant
    public String addPlant(PlantModel plant) {
        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();
            session.save(plant);
            transaction.commit();
        } catch (HibernateException e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
            return "Failed to add plant";
        } finally {
            if (session != null) session.close();
        }
        return "Plant added successfully";
    }

    // Update an existing plant
    public String updatePlant(PlantModel plant) {
        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();
            session.update(plant);
            transaction.commit();
        } catch (HibernateException e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
            return "Failed to update plant";
        } finally {
            if (session != null) session.close();
        }
        return "Plant updated successfully";
    }

    // Delete a plant by id
    public String deletePlant(int id) {
        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();
            PlantModel plant = (PlantModel) session.get(PlantModel.class, id);
            if (plant != null) {
                session.delete(plant);
                transaction.commit();
                return "Plant deleted successfully";
            } else {
                return "Plant not found";
            }
        } catch (HibernateException e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
            return "Failed to delete plant";
        } finally {
            if (session != null) session.close();
        }
    }
}
