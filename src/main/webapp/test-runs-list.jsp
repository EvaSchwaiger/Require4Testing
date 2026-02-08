<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Test runs - Require4Testing</title>
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
                <li><a href="test-cases">Test case</a></li>
                <li><a href="assignments">Assignments</a></li>
            </ul>
        </div>
    </nav>

    <div class="container">
        <h2>Test runs</h2>
        <a href="test-run-form.jsp" class="btn btn-primary">+ Create new test run</a>

        <table class="data-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Manager</th>
                    <th>Status</th>
                    <th>Create Date</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:if test="${empty testRuns}">
                    <tr>
                        <td colspan="6" class="text-center">Test run not found. <a href="test-run-form.jsp">Create now</a>.</td>
                    </tr>
                </c:if>
                <c:forEach var="run" items="${testRuns}">
                    <tr>
                        <td>${run.id}</td>
                        <td><strong>${run.name}</strong></td>
                        <td>${run.managerName}</td>
                        <td><span class="badge">${run.status}</span></td>
                        <td>${run.createdDate}</td>
                        <td>
                            <a href="test-runs?action=view&id=${run.id}" class="link">View</a> |
                            <a href="test-runs?action=edit&id=${run.id}" class="link">Edit</a> |
                            <a href="test-runs?action=delete&id=${run.id}" class="link delete" onclick="return confirm('Are you sure?')">Delete</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <footer>
        <p>&copy; 2026 Require4Testing. All rights reserved.</p>
    </footer>
</body>
</html>
