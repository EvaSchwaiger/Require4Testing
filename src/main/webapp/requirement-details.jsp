<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Details of the requirement - Require4Testing</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <nav class="navbar">
        <div class="container">
            <h1 class="logo">Require4Testing</h1>
            <ul class="nav-menu">
                <li><a href="index.html">Home</a></li>
                <li><a href="requirements">Requirements</a></li>
                <li><a href="test-runs">Test runs</a></li>
                <li><a href="test-cases">Test cases</a></li>
                <li><a href="assignments">Assignments</a></li>
            </ul>
        </div>
    </nav>

    <div class="container">
        <h2>${requirement.name}</h2>

        <div class="details-card">
            <div class="detail-row">
                <span class="label">ID:</span>
                <span class="value">${requirement.id}</span>
            </div>
            <div class="detail-row">
                <span class="label">Description:</span>
                <span class="value">${requirement.description}</span>
            </div>
            <div class="detail-row">
                <span class="label">Engineer:</span>
                <span class="value">${requirement.engineerName}</span>
            </div>
            <div class="detail-row">
                <span class="label">Date of creation:</span>
                <span class="value">${requirement.createdDate}</span>
            </div>
        </div>

        <h3>Related test cases</h3>
        <table class="data-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Create from</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:if test="${empty requirement.testCases}">
                    <tr>
                        <td colspan="4" class="text-center">There are no test cases for this requirement yet.</td>
                    </tr>
                </c:if>
                <c:forEach var="tc" items="${requirement.testCases}">
                    <tr>
                        <td>${tc.id}</td>
                        <td><strong>${tc.name}</strong></td>
                        <td>${tc.creatorName}</td>
                        <td>
                            <a href="test-cases?action=view&id=${tc.id}" class="link">View</a> |
                            <a href="test-cases?action=delete&id=${tc.id}" class="link delete" onclick="return confirm('Are you sure?')">Delete</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <div class="action-buttons">
            <a href="requirements?action=edit&id=${requirement.id}" class="btn btn-primary">Edit</a>
            <a href="requirements" class="btn btn-secondary">Return to requirements</a>
        </div>
    </div>

    <footer>
        <p>&copy; 2026 Require4Testing. All rights reserved.</p>
    </footer>
</body>
</html>
