package com.require4testing.servlet;

import com.require4testing.dao.TestCaseDAO;
import com.require4testing.dao.RequirementDAO;
import com.require4testing.entity.TestCase;
import com.require4testing.entity.Requirement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/test-cases")
public class TestCaseServlet extends HttpServlet {
    private TestCaseDAO testCaseDAO = new TestCaseDAO();
    private RequirementDAO requirementDAO = new RequirementDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("new".equals(action)) {
            List<Requirement> requirements = requirementDAO.findAll();
            request.setAttribute("requirements", requirements);
            request.getRequestDispatcher("/test-case-form.jsp").forward(request, response);
        } else if ("edit".equals(action)) {
            Long id = Long.parseLong(request.getParameter("id"));
            TestCase testCase = testCaseDAO.findById(id);
            List<Requirement> requirements = requirementDAO.findAll();
            request.setAttribute("testCase", testCase);
            request.setAttribute("requirements", requirements);
            request.getRequestDispatcher("/test-case-form.jsp").forward(request, response);
        } else if ("delete".equals(action)) {
            Long id = Long.parseLong(request.getParameter("id"));
            testCaseDAO.delete(id);
            response.sendRedirect(request.getContextPath() + "/test-cases");
        } else if ("view".equals(action)) {
            Long id = Long.parseLong(request.getParameter("id"));
            TestCase testCase = testCaseDAO.findById(id);
            request.setAttribute("testCase", testCase);
            request.getRequestDispatcher("/test-case-details.jsp").forward(request, response);
        } else {
            // List all test cases
            List<TestCase> testCases = testCaseDAO.findAll();
            request.setAttribute("testCases", testCases);
            request.getRequestDispatcher("/test-cases-list.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String steps = request.getParameter("steps");
        String expectedResult = request.getParameter("expectedResult");
        String creatorName = request.getParameter("creatorName");
        Long requirementId = Long.parseLong(request.getParameter("requirementId"));

        Requirement requirement = requirementDAO.findById(requirementId);

        if ("add".equals(action)) {
            TestCase testCase = new TestCase();
            testCase.setName(name);
            testCase.setDescription(description);
            testCase.setSteps(steps);
            testCase.setExpectedResult(expectedResult);
            testCase.setCreatorName(creatorName);
            testCase.setRequirement(requirement);
            testCaseDAO.save(testCase);
            response.sendRedirect(request.getContextPath() + "/test-cases");
        } else if ("update".equals(action)) {
            Long id = Long.parseLong(request.getParameter("id"));
            TestCase testCase = testCaseDAO.findById(id);
            testCase.setName(name);
            testCase.setDescription(description);
            testCase.setSteps(steps);
            testCase.setExpectedResult(expectedResult);
            testCase.setCreatorName(creatorName);
            testCase.setRequirement(requirement);
            testCaseDAO.update(testCase);
            response.sendRedirect(request.getContextPath() + "/test-cases");
        }
    }
}
