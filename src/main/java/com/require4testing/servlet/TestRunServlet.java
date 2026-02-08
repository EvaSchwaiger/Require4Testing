package com.require4testing.servlet;

import com.require4testing.dao.TestRunDAO;
import com.require4testing.entity.TestRun;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/test-runs")
public class TestRunServlet extends HttpServlet {
    private TestRunDAO testRunDAO = new TestRunDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("edit".equals(action)) {
            Long id = Long.parseLong(request.getParameter("id"));
            TestRun testRun = testRunDAO.findById(id);
            request.setAttribute("testRun", testRun);
            request.getRequestDispatcher("/test-run-form.jsp").forward(request, response);
        } else if ("delete".equals(action)) {
            Long id = Long.parseLong(request.getParameter("id"));
            testRunDAO.delete(id);
            response.sendRedirect(request.getContextPath() + "/test-runs");
        } else if ("view".equals(action)) {
            Long id = Long.parseLong(request.getParameter("id"));
            TestRun testRun = testRunDAO.findByIdWithAssignments(id);
            request.setAttribute("testRun", testRun);
            request.getRequestDispatcher("/test-run-details.jsp").forward(request, response);
        } else {
            // List all test runs
            List<TestRun> testRuns = testRunDAO.findAll();
            request.setAttribute("testRuns", testRuns);
            request.getRequestDispatcher("/test-runs-list.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String managerName = request.getParameter("managerName");

        if ("add".equals(action)) {
            TestRun testRun = new TestRun();
            testRun.setName(name);
            testRun.setDescription(description);
            testRun.setManagerName(managerName);
            testRunDAO.save(testRun);
            response.sendRedirect(request.getContextPath() + "/test-runs");
        } else if ("update".equals(action)) {
            Long id = Long.parseLong(request.getParameter("id"));
            TestRun testRun = testRunDAO.findById(id);
            testRun.setName(name);
            testRun.setDescription(description);
            testRun.setManagerName(managerName);
            testRunDAO.update(testRun);
            response.sendRedirect(request.getContextPath() + "/test-runs");
        }
    }
}
