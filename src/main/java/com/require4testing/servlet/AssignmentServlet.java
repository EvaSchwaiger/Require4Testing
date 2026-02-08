package com.require4testing.servlet;

import com.require4testing.dao.RunAssignmentDAO;
import com.require4testing.dao.TestRunDAO;
import com.require4testing.dao.TestCaseDAO;
import com.require4testing.entity.RunAssignment;
import com.require4testing.entity.TestRun;
import com.require4testing.entity.TestCase;
import com.require4testing.entity.ExecutionStatus;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Date;

@WebServlet("/assignments")
public class AssignmentServlet extends HttpServlet {
    private RunAssignmentDAO assignmentDAO = new RunAssignmentDAO();
    private TestRunDAO testRunDAO = new TestRunDAO();
    private TestCaseDAO testCaseDAO = new TestCaseDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("new".equals(action)) {
            Long testRunId = Long.parseLong(request.getParameter("testRunId"));
            TestRun testRun = testRunDAO.findById(testRunId);
            List<TestCase> testCases = testCaseDAO.findAll();
            request.setAttribute("testRun", testRun);
            request.setAttribute("testCases", testCases);
            request.getRequestDispatcher("/assignment-form.jsp").forward(request, response);
        } else if ("bulk-form".equals(action)) {
            Long testRunId = Long.parseLong(request.getParameter("testRunId"));
            TestRun testRun = testRunDAO.findById(testRunId);

            // Get all test cases
            List<TestCase> allTestCases = testCaseDAO.findAll();

            // Get already assigned test case IDs
            List<Long> assignedTestCaseIds = assignmentDAO.findAssignedTestCaseIdsByTestRunId(testRunId);

            // Filter out already assigned test cases
            List<TestCase> availableTestCases = allTestCases.stream()
                .filter(tc -> !assignedTestCaseIds.contains(tc.getId()))
                .collect(java.util.stream.Collectors.toList());

            request.setAttribute("testRun", testRun);
            request.setAttribute("availableTestCases", availableTestCases);
            request.getRequestDispatcher("/assignment-bulk-form.jsp").forward(request, response);
        } else if ("delete".equals(action)) {
            Long id = Long.parseLong(request.getParameter("id"));
            assignmentDAO.delete(id);
            response.sendRedirect(request.getContextPath() + "/assignments");
        } else if ("execute".equals(action)) {
            Long id = Long.parseLong(request.getParameter("id"));
            RunAssignment assignment = assignmentDAO.findById(id);
            request.setAttribute("assignment", assignment);
            request.getRequestDispatcher("/assignment-execute.jsp").forward(request, response);
        } else if ("my-assignments".equals(action)) {
            String testerName = request.getParameter("testerName");
            List<RunAssignment> assignments = assignmentDAO.findByTesterName(testerName);
            request.setAttribute("testerName", testerName);
            request.setAttribute("assignments", assignments);
            request.getRequestDispatcher("/my-assignments.jsp").forward(request, response);
        } else {
            // List all assignments
            List<RunAssignment> assignments = assignmentDAO.findAll();
            request.setAttribute("assignments", assignments);
            request.getRequestDispatcher("/assignments-list.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            Long testRunId = Long.parseLong(request.getParameter("testRunId"));
            Long testCaseId = Long.parseLong(request.getParameter("testCaseId"));
            String testerName = request.getParameter("testerName");

            TestRun testRun = testRunDAO.findById(testRunId);
            TestCase testCase = testCaseDAO.findById(testCaseId);

            RunAssignment assignment = new RunAssignment();
            assignment.setTestRun(testRun);
            assignment.setTestCase(testCase);
            assignment.setTesterName(testerName);
            assignmentDAO.save(assignment);

            response.sendRedirect(request.getContextPath() + "/test-runs?action=view&id=" + testRunId);
        } else if ("bulk-assign".equals(action)) {
            Long testRunId = Long.parseLong(request.getParameter("testRunId"));
            String testerName = request.getParameter("testerName");
            String[] testCaseIds = request.getParameterValues("testCaseIds");

            if (testCaseIds != null && testCaseIds.length > 0) {
                TestRun testRun = testRunDAO.findById(testRunId);

                for (String testCaseIdStr : testCaseIds) {
                    Long testCaseId = Long.parseLong(testCaseIdStr);
                    TestCase testCase = testCaseDAO.findById(testCaseId);

                    RunAssignment assignment = new RunAssignment();
                    assignment.setTestRun(testRun);
                    assignment.setTestCase(testCase);
                    assignment.setTesterName(testerName);
                    assignmentDAO.save(assignment);
                }
            }

            response.sendRedirect(request.getContextPath() + "/test-runs?action=view&id=" + testRunId);
        } else if ("submit-result".equals(action)) {
            Long id = Long.parseLong(request.getParameter("id"));
            String result = request.getParameter("result");
            String notes = request.getParameter("notes");
            String status = request.getParameter("status");

            RunAssignment assignment = assignmentDAO.findById(id);
            assignment.setResult(result);
            assignment.setNotes(notes);
            assignment.setStatus(ExecutionStatus.valueOf(status));
            assignment.setExecutionDate(new Date());
            assignmentDAO.update(assignment);

            response.sendRedirect(request.getContextPath() + "/assignments");
        }
    }
}
