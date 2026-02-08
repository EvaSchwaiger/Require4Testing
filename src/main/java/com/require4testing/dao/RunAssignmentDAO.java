package com.require4testing.dao;

import com.require4testing.db.HibernateUtil;
import com.require4testing.entity.RunAssignment;
import org.hibernate.Session;
import org.hibernate.Transaction;
import javax.persistence.Query;
import java.util.List;

public class RunAssignmentDAO {

    public void save(RunAssignment assignment) {
        Session session = HibernateUtil.getSession();
        Transaction transaction = session.beginTransaction();
        try {
            session.save(assignment);
            transaction.commit();
        } catch (Exception e) {
            transaction.rollback();
            throw e;
        } finally {
            session.close();
        }
    }

    public void update(RunAssignment assignment) {
        Session session = HibernateUtil.getSession();
        Transaction transaction = session.beginTransaction();
        try {
            session.merge(assignment);
            transaction.commit();
        } catch (Exception e) {
            transaction.rollback();
            throw e;
        } finally {
            session.close();
        }
    }

    public RunAssignment findById(Long id) {
        Session session = HibernateUtil.getSession();
        try {
            return session.get(RunAssignment.class, id);
        } finally {
            session.close();
        }
    }

    public List<RunAssignment> findByTestRunId(Long testRunId) {
        Session session = HibernateUtil.getSession();
        try {
            Query query = session.createQuery("FROM RunAssignment WHERE testRun.id = :runId");
            query.setParameter("runId", testRunId);
            return query.getResultList();
        } finally {
            session.close();
        }
    }

    public List<RunAssignment> findByTesterName(String testerName) {
        Session session = HibernateUtil.getSession();
        try {
            Query query = session.createQuery("FROM RunAssignment WHERE testerName = :tester ORDER BY assignedDate DESC");
            query.setParameter("tester", testerName);
            return query.getResultList();
        } finally {
            session.close();
        }
    }

    public List<RunAssignment> findAll() {
        Session session = HibernateUtil.getSession();
        try {
            Query query = session.createQuery("FROM RunAssignment ORDER BY assignedDate DESC");
            return query.getResultList();
        } finally {
            session.close();
        }
    }

    public List<Long> findAssignedTestCaseIdsByTestRunId(Long testRunId) {
        Session session = HibernateUtil.getSession();
        try {
            Query query = session.createQuery("SELECT ra.testCase.id FROM RunAssignment ra WHERE ra.testRun.id = :runId");
            query.setParameter("runId", testRunId);
            return query.getResultList();
        } finally {
            session.close();
        }
    }

    public void delete(Long id) {
        Session session = HibernateUtil.getSession();
        Transaction transaction = session.beginTransaction();
        try {
            RunAssignment assignment = session.get(RunAssignment.class, id);
            if (assignment != null) {
                session.delete(assignment);
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
