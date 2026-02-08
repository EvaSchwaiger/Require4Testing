<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Assignments - Require4Testing</title>
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
        <h2>Test Assignments</h2>

        <div class="action-buttons">
            <div class="form-group" style="display: inline-block; margin-bottom: 20px;">
                <form method="GET" action="assignments" style="display: flex; gap: 10px;">
                    <input type="hidden" name="action" value="my-assignments">
                    <input type="text" name="testerName" placeholder="Enter the tester's name" required>
                    <button type="submit" class="btn btn-primary">View my Assignments</button>
                </form>
            </div>
        </div>

        <h3>All Assignments</h3>
        <table class="data-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Test run</th>
                    <th>Test case</th>
                    <th>Tester</th>
                    <th>Status</th>
                    <th>Assignments date</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:if test="${empty assignments}">
                    <tr>
                        <td colspan="7" class="text-center">No assignments found.</td>
                    </tr>
                </c:if>
                <c:forEach var="assign" items="${assignments}">
                    <tr>
                        <td>${assign.id}</td>
                        <td><a href="test-runs?action=view&id=${assign.testRun.id}">${assign.testRun.name}</a></td>
                        <td><a href="test-cases?action=view&id=${assign.testCase.id}">${assign.testCase.name}</a></td>
                        <td>${assign.testerName}</td>
                        <td><span class="badge">${assign.status}</span></td>
                        <td>${assign.assignedDate}</td>
                        <td>
                            <c:if test="${assign.status == 'ASSIGNED'}">
                                <a href="assignments?action=execute&id=${assign.id}" class="link">Execute</a> |
                            </c:if>
                            <a href="assignments?action=delete&id=${assign.id}" class="link delete" onclick="return confirm('Are you sure?')">Delete</a>
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
