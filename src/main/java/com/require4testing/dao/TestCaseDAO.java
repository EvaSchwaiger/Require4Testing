package com.require4testing.dao;

import com.require4testing.db.HibernateUtil;
import com.require4testing.entity.TestCase;
import org.hibernate.Session;
import org.hibernate.Transaction;
import javax.persistence.Query;
import java.util.List;

public class TestCaseDAO {

    public void save(TestCase testCase) {
        Session session = HibernateUtil.getSession();
        Transaction transaction = session.beginTransaction();
        try {
            session.save(testCase);
            transaction.commit();
        } catch (Exception e) {
            transaction.rollback();
            throw e;
        } finally {
            session.close();
        }
    }

    public void update(TestCase testCase) {
        Session session = HibernateUtil.getSession();
        Transaction transaction = session.beginTransaction();
        try {
            session.merge(testCase);
            transaction.commit();
        } catch (Exception e) {
            transaction.rollback();
            throw e;
        } finally {
            session.close();
        }
    }

    public TestCase findById(Long id) {
        Session session = HibernateUtil.getSession();
        try {
            return session.get(TestCase.class, id);
        } finally {
            session.close();
        }
    }

    public List<TestCase> findByRequirementId(Long requirementId) {
        Session session = HibernateUtil.getSession();
        try {
            Query query = session.createQuery("FROM TestCase WHERE requirement.id = :reqId ORDER BY createdDate DESC");
            query.setParameter("reqId", requirementId);
            return query.getResultList();
        } finally {
            session.close();
        }
    }

    public List<TestCase> findAll() {
        Session session = HibernateUtil.getSession();
        try {
            Query query = session.createQuery("FROM TestCase ORDER BY createdDate DESC");
            return query.getResultList();
        } finally {
            session.close();
        }
    }

    public void delete(Long id) {
        Session session = HibernateUtil.getSession();
        Transaction transaction = session.beginTransaction();
        try {
            TestCase testCase = session.get(TestCase.class, id);
            if (testCase != null) {
                session.delete(testCase);
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
