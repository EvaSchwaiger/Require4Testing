<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My assignments - Require4Testing</title>
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
        <h2>Assignments for ${testerName}</h2>

        <table class="data-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Rest run</th>
                    <th>Test case</th>
                    <th>Status</th>
                    <th>Date of assignment</th>
                    <th>Completion date</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:if test="${empty assignments}">
                    <tr>
                        <td colspan="7" class="text-center">No assignments found for this tester.</td>
                    </tr>
                </c:if>
                <c:forEach var="assign" items="${assignments}">
                    <tr>
                        <td>${assign.id}</td>
                        <td><a href="test-runs?action=view&id=${assign.testRun.id}">${assign.testRun.name}</a></td>
                        <td><a href="test-cases?action=view&id=${assign.testCase.id}">${assign.testCase.name}</a></td>
                        <td><span class="badge">${assign.status}</span></td>
                        <td>${assign.assignedDate}</td>
                        <td>${assign.executionDate}</td>
                        <td>
                            <c:if test="${assign.status == 'ASSIGNED'}">
                                <a href="assignments?action=execute&id=${assign.id}" class="link">Execute</a>
                            </c:if>
                            <c:if test="${assign.status != 'ASSIGNED'}">
                                <a href="assignments?action=view&id=${assign.id}" class="link">View result</a>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <div class="action-buttons">
            <a href="assignments" class="btn btn-secondary">Return to all assignments</a>
        </div>
    </div>

    <footer>
        <p>&copy; 2026 Require4Testing. All rights reserved.</p>
    </footer>
</body>
</html>
