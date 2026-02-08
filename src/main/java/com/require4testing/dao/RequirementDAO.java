package com.require4testing.dao;

import com.require4testing.db.HibernateUtil;
import com.require4testing.entity.Requirement;
import org.hibernate.Session;
import org.hibernate.Transaction;
import javax.persistence.Query;
import java.util.List;

public class RequirementDAO {

    public void save(Requirement requirement) {
        Session session = HibernateUtil.getSession();
        Transaction transaction = session.beginTransaction();
        try {
            session.save(requirement);
            transaction.commit();
        } catch (Exception e) {
            transaction.rollback();
            throw e;
        } finally {
            session.close();
        }
    }

    public void update(Requirement requirement) {
        Session session = HibernateUtil.getSession();
        Transaction transaction = session.beginTransaction();
        try {
            session.merge(requirement);
            transaction.commit();
        } catch (Exception e) {
            transaction.rollback();
            throw e;
        } finally {
            session.close();
        }
    }

    public Requirement findById(Long id) {
        Session session = HibernateUtil.getSession();
        try {
            return session.get(Requirement.class, id);
        } finally {
            session.close();
        }
    }

    public List<Requirement> findAll() {
        Session session = HibernateUtil.getSession();
        try {
            Query query = session.createQuery("SELECT DISTINCT r FROM Requirement r LEFT JOIN FETCH r.testCases ORDER BY r.createdDate DESC");
            return query.getResultList();
        } finally {
            session.close();
        }
    }

    public void delete(Long id) {
        Session session = HibernateUtil.getSession();
        Transaction transaction = session.beginTransaction();
        try {
            Requirement requirement = session.get(Requirement.class, id);
            if (requirement != null) {
                session.delete(requirement);
            }
            transaction.commit();
        } catch (Exception e) {
            transaction.rollback();
            throw e;
        } finally {
            session.close();
        }
    }
}
