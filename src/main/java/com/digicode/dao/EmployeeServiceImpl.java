package com.digicode.dao;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import com.digicode.model.EmployeeModel;
import com.google.gson.Gson;

import java.util.List;

public class EmployeeServiceImpl {

    Configuration configuration = new Configuration().configure();
    SessionFactory sessionFactory = configuration.buildSessionFactory();

    // Get all employees
    @SuppressWarnings("unchecked")
    public String getAllEmployees() {
        List<EmployeeModel> employees = null;
        Transaction transaction = null;
        Session session = null;
        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();
            employees = session.createQuery("FROM EmployeeModel").list();
            transaction.commit();
        } catch (HibernateException e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
        } finally {
            if (session != null) session.close();
        }
        Gson gson = new Gson();
        return gson.toJson(employees);
    }
    
    @SuppressWarnings("unchecked")
	public List<EmployeeModel> getEmployeesUnderEmployer(String employerId) {
        List<EmployeeModel> employees = null;
        Transaction transaction = null;
        Session session = null;
        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();
            
            // Query to retrieve employees under the specified employer
            employees = session.createQuery("FROM EmployeeModel WHERE employer = :employerId")
                               .setParameter("employerId", employerId)
                               .list();
            
            transaction.commit();
        } catch (HibernateException e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
        } finally {
            if (session != null) session.close();
        }
        return employees;
    }

    
    public int countEmployeesUnderEmployer(String employerId) {
        int employeeCount = 0;
        Transaction transaction = null;
        Session session = null;
        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();
            
            // Query to count employees under the specified employer
            employeeCount = ((Long) session.createQuery("SELECT COUNT(*) FROM EmployeeModel WHERE employer = :employerId")
                                 .setParameter("employerId", employerId)
                                 .uniqueResult()).intValue();
            
            transaction.commit();
        } catch (HibernateException e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
        } finally {
            if (session != null) session.close();
        }
        return employeeCount;
    }


    

    // Get employee by userId
    public EmployeeModel getEmployeeById(String userId) {
        EmployeeModel employee = null;
        Transaction transaction = null;
        Session session = null;
        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();
            employee = (EmployeeModel) session.get(EmployeeModel.class, userId);
            transaction.commit();
        } catch (HibernateException e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
        } finally {
            if (session != null) session.close();
        }
        return employee;
    }

    // Add a new employee
    public String addEmployee(EmployeeModel employee) {
        Transaction transaction = null;
        Session session = null;
        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();
            session.save(employee);
            transaction.commit();
        } catch (HibernateException e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
            return "Failed to add employee";
        } finally {
            if (session != null) session.close();
        }
        return "Employee added successfully";
    }

    // Update an employee
    public String updateEmployee(String userId, EmployeeModel employee) {
        Transaction transaction = null;
        Session session = null;
        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();
            EmployeeModel existingEmployee = (EmployeeModel) session.get(EmployeeModel.class, userId);

            if (existingEmployee != null) {
                // Update fields only if they are not null
                if (employee.getFirstName() != null) existingEmployee.setFirstName(employee.getFirstName());
                if (employee.getLastName() != null) existingEmployee.setLastName(employee.getLastName());
                if (employee.getEmail() != null) existingEmployee.setEmail(employee.getEmail());
                if (employee.getContact_no() != null) existingEmployee.setContact_no(employee.getContact_no());
                if (employee.getAddress() != null) existingEmployee.setAddress(employee.getAddress());
                if (employee.getCity() != null) existingEmployee.setCity(employee.getCity());
                if (employee.getState() != null) existingEmployee.setState(employee.getState());
                // Add other fields if necessary

                session.update(existingEmployee);
                transaction.commit();
                return "Employee updated successfully";
            } else {
                return "Employee not found";
            }
        } catch (HibernateException e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
            return "Failed to update employee";
        } finally {
            if (session != null) session.close();
        }
    }

    // Change password
    public String changePassword(String userId, String currentPassword, String newPassword) {
        Transaction transaction = null;
        Session session = null;
        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();
            EmployeeModel existingEmployee = (EmployeeModel) session.get(EmployeeModel.class, userId);

            if (existingEmployee != null) {
                // Verify the current password
                if (!existingEmployee.getPassword().equals(currentPassword)) {
                    return "Current password is incorrect";
                }

                // Update the password
                existingEmployee.setPassword(newPassword);
                session.update(existingEmployee);
                transaction.commit();
                return "Password changed successfully";
            } else {
                return "Employee not found";
            }
        } catch (HibernateException e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
            return "Failed to change password";
        } finally {
            if (session != null) session.close();
        }
    }

    // Delete an employee
    public String deleteEmployee(String userId) {
        Transaction transaction = null;
        Session session = null;
        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();
            EmployeeModel employee = (EmployeeModel) session.get(EmployeeModel.class, userId);
            if (employee != null) {
                session.delete(employee);
                transaction.commit();
                return "Employee deleted successfully";
            } else {
                return "Employee not found";
            }
        } catch (HibernateException e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
            return "Failed to delete employee";
        } finally {
            if (session != null) session.close();
        }
    }
}
