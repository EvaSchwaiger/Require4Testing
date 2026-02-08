<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Requirements - Require4Testing</title>
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
        <h2>Requirements for test</h2>
        <a href="requirement-form.jsp" class="btn btn-primary">+ Create a new requirement</a>

        <table class="data-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Engineer</th>
                    <th>Test case</th>
                    <th>Create date</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:if test="${empty requirements}">
                    <tr>
                        <td colspan="6" class="text-center">Requirements not found. <a href="requirement-form.jsp">Create now</a>.</td>
                    </tr>
                </c:if>
                <c:forEach var="req" items="${requirements}">
                    <tr>
                        <td>${req.id}</td>
                        <td><strong>${req.name}</strong></td>
                        <td>${req.engineerName}</td>
                        <td>${req.testCases.size()}</td>
                        <td>${req.createdDate}</td>
                        <td>
                            <a href="requirements?action=view&id=${req.id}" class="link">View</a> |
                            <a href="requirements?action=edit&id=${req.id}" class="link">Edit</a> |
                            <a href="requirements?action=delete&id=${req.id}" class="link delete" onclick="return confirm('Are you shor?')">Delete</a>
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
