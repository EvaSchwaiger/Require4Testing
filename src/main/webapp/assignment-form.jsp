<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Assign test cases - Require4Testing</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <nav class="navbar">
        <div class="container">
            <h1 class="logo">Require4Testing</h1>
            <ul class="nav-menu">
                <li><a href="index.html">Home</a></li>
                <li><a href="requirements">Requirements</a></li>
                <li><a href="test-runs">Test-runs</a></li>
                <li><a href="test-cases">Test-cases</a></li>
                <li><a href="assignments">Assignments</a></li>
            </ul>
        </div>
    </nav>

    <div class="container form-container">
        <h2>Assign test cases to a test run: ${testRun.name}</h2>

        <form method="POST" action="assignments" class="form">
            <input type="hidden" name="action" value="add">
            <input type="hidden" name="testRunId" value="${testRun.id}">

            <div class="form-group">
                <label for="testCaseId">Test case *</label>
                <select id="testCaseId" name="testCaseId" required>
                    <option value="">-- Select a test case --</option>
                    <c:forEach var="tc" items="${testCases}">
                        <option value="${tc.id}">${tc.name} (Requirement: ${tc.requirement.name})</option>
                    </c:forEach>
                </select>
            </div>

            <div class="form-group">
                <label for="testerName">Tester's name *</label>
                <input type="text" id="testerName" name="testerName" placeholder="Enter the tester's name" required>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn btn-primary">Assign a test case</button>
                <a href="test-runs?action=view&id=${testRun.id}" class="btn btn-secondary">Cancel</a>
            </div>
        </form>
    </div>

    <footer>
        <p>&copy; 2026 Require4Testing. All rights reserved.</p>
    </footer>
</body>
</html>
