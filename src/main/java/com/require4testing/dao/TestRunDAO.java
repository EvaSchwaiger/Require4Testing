package com.require4testing.dao;

import com.require4testing.db.HibernateUtil;
import com.require4testing.entity.TestRun;
import org.hibernate.Session;
import org.hibernate.Transaction;
import javax.persistence.Query;
import java.util.List;

public class TestRunDAO {

    public void save(TestRun testRun) {
        Session session = HibernateUtil.getSession();
        Transaction transaction = session.beginTransaction();
        try {
            session.save(testRun);
            transaction.commit();
        } catch (Exception e) {
            transaction.rollback();
            throw e;
        } finally {
            session.close();
        }
    }

    public void update(TestRun testRun) {
        Session session = HibernateUtil.getSession();
        Transaction transaction = session.beginTransaction();
        try {
            session.merge(testRun);
            transaction.commit();
        } catch (Exception e) {
            transaction.rollback();
            throw e;
        } finally {
            session.close();
        }
    }

    public TestRun findById(Long id) {
        Session session = HibernateUtil.getSession();
        try {
            return session.get(TestRun.class, id);
        } finally {
            session.close();
        }
    }

    public TestRun findByIdWithAssignments(Long id) {
        Session session = HibernateUtil.getSession();
        try {
            Query query = session.createQuery("FROM TestRun tr LEFT JOIN FETCH tr.assignments WHERE tr.id = :id");
            query.setParameter("id", id);
            return (TestRun) query.getSingleResult();
        } finally {
            session.close();
        }
    }

    public List<TestRun> findAll() {
        Session session = HibernateUtil.getSession();
        try {
            Query query = session.createQuery("FROM TestRun ORDER BY createdDate DESC");
            return query.getResultList();
        } finally {
            session.close();
        }
    }

    public void delete(Long id) {
        Session session = HibernateUtil.getSession();
        Transaction transaction = session.beginTransaction();
        try {
            TestRun testRun = session.get(TestRun.class, id);
            if (testRun != null) {
                session.delete(testRun);
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
