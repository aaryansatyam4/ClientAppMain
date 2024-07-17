package com.digicode.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class SessionUtil {

	private static SessionUtil session = null;
	private SessionFactory sessionFactory;
	
	private SessionUtil(){
		Configuration configuration = new Configuration();
		configuration.configure("hibernate.cfg.xml");
		sessionFactory = configuration.buildSessionFactory();
		
	}
	
	public static SessionUtil getInstance(){
		
		if(session == null){
			session = new SessionUtil();
		}
		return session;
	}
	
	public static Session getSession(){
		Session session = getInstance().sessionFactory.openSession();
		return session;
	}
	
	
}
