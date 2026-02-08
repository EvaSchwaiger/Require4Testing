<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Test cases - Require4Testing</title>
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
        <h2>Test cases</h2>
        <a href="test-cases?action=new" class="btn btn-primary">+ Create new Test case</a>

        <table class="data-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Requirement</th>
                    <th>Creator</th>
                    <th>Date</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <c:if test="${empty testCases}">
                    <tr>
                        <td colspan="6" class="text-center">Test case not found. <a href="test-cases?action=new">Create now</a>.</td>
                    </tr>
                </c:if>
                <c:forEach var="tc" items="${testCases}">
                    <tr>
                        <td>${tc.id}</td>
                        <td><strong>${tc.name}</strong></td>
                        <td>${tc.requirement.name}</td>
                        <td>${tc.creatorName}</td>
                        <td>${tc.createdDate}</td>
                        <td>
                            <a href="test-cases?action=view&id=${tc.id}" class="link">View</a> |
                            <a href="test-cases?action=edit&id=${tc.id}" class="link">Edit</a> |
                            <a href="test-cases?action=delete&id=${tc.id}" class="link delete" onclick="return confirm('Are you sure?')">Delete</a>
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
