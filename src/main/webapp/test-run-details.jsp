<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Test runs details - Require4Testing</title>
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
        <h2>${testRun.name}</h2>

        <div class="details-card">
            <div class="detail-row">
                <span class="label">ID:</span>
                <span class="value">${testRun.id}</span>
            </div>
            <div class="detail-row">
                <span class="label">Description:</span>
                <span class="value">${testRun.description}</span>
            </div>
            <div class="detail-row">
                <span class="label">Manager:</span>
                <span class="value">${testRun.managerName}</span>
            </div>
            <div class="detail-row">
                <span class="label">Status:</span>
                <span class="value"><strong>${testRun.status}</strong></span>
            </div>
            <div class="detail-row">
                <span class="label">Create date:</span>
                <span class="value">${testRun.createdDate}</span>
            </div>
        </div>

        <h3>Test Case Assignments</h3>
        <a href="assignments?action=new&testRunId=${testRun.id}" class="btn btn-primary">+ Assign test cases</a>
        <a href="assignments?action=bulk-form&testRunId=${testRun.id}" class="btn btn-secondary" style="margin-left: 10px;">+ Assignments</a>

        <table class="data-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Test case</th>
                    <th>Tester</th>
                    <th>Status</th>
                    <th>Aktions</th>
                </tr>
            </thead>
            <tbody>
                <c:if test="${testRun.assignments.size() == 0}">
                    <tr>
                        <td colspan="5" class="text-center">There are no test cases assigned for this run yet.</td>
                    </tr>
                </c:if>
                <c:forEach var="assign" items="${testRun.assignments}">
                    <tr>
                        <td>${assign.id}</td>
                        <td><strong>${assign.testCase.name}</strong></td>
                        <td>${assign.testerName}</td>
                        <td><span class="badge">${assign.status}</span></td>
                        <td>
                            <a href="assignments?action=execute&id=${assign.id}" class="link">Execute</a> |
                            <a href="assignments?action=delete&id=${assign.id}" class="link delete" onclick="return confirm('Are you sure?')">Delete</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <div class="action-buttons">
            <a href="test-runs?action=edit&id=${testRun.id}" class="btn btn-primary">edit</a>
            <a href="test-runs" class="btn btn-secondary">Back to test runs</a>
        </div>
    </div>

    <footer>
        <p>&copy; 2026 Require4Testing. All rights reserved.</p>
    </footer>
</body>
</html>
