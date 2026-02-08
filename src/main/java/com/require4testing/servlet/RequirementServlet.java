package com.require4testing.servlet;

import com.require4testing.dao.RequirementDAO;
import com.require4testing.entity.Requirement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/requirements")
public class RequirementServlet extends HttpServlet {
    private RequirementDAO requirementDAO = new RequirementDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("edit".equals(action)) {
            Long id = Long.parseLong(request.getParameter("id"));
            Requirement requirement = requirementDAO.findById(id);
            request.setAttribute("requirement", requirement);
            request.getRequestDispatcher("/requirement-form.jsp").forward(request, response);
        } else if ("delete".equals(action)) {
            Long id = Long.parseLong(request.getParameter("id"));
            requirementDAO.delete(id);
            response.sendRedirect(request.getContextPath() + "/requirements");
        } else if ("view".equals(action)) {
            Long id = Long.parseLong(request.getParameter("id"));
            Requirement requirement = requirementDAO.findById(id);
            request.setAttribute("requirement", requirement);
            request.getRequestDispatcher("/requirement-details.jsp").forward(request, response);
        } else {
            // List all requirements
            List<Requirement> requirements = requirementDAO.findAll();
            request.setAttribute("requirements", requirements);
            request.getRequestDispatcher("/requirements-list.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String engineerName = request.getParameter("engineerName");

        if ("add".equals(action)) {
            Requirement requirement = new Requirement();
            requirement.setName(name);
            requirement.setDescription(description);
            requirement.setEngineerName(engineerName);
            requirementDAO.save(requirement);
            response.sendRedirect(request.getContextPath() + "/requirements");
        } else if ("update".equals(action)) {
            Long id = Long.parseLong(request.getParameter("id"));
            Requirement requirement = requirementDAO.findById(id);
            requirement.setName(name);
            requirement.setDescription(description);
            requirement.setEngineerName(engineerName);
            requirementDAO.update(requirement);
            response.sendRedirect(request.getContextPath() + "/requirements");
        }
    }
}
