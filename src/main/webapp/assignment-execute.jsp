<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Execute a test case - Require4Testing</title>
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

    <div class="container form-container">
        <h2>Execute a test case</h2>

        <div class="details-card">
            <div class="detail-row">
                <span class="label">Test case:</span>
                <span class="value"><strong>${assignment.testCase.name}</strong></span>
            </div>
            <div class="detail-row">
                <span class="label">Test case:</span>
                <span class="value"><strong>${assignment.testRun.name}</strong></span>
            </div>
            <div class="detail-row">
                <span class="label">Tester:</span>
                <span class="value"><strong>${assignment.testerName}</strong></span>
            </div>
            <div class="detail-row">
                <span class="label">Steps:</span>
                <span class="value"><pre>${assignment.testCase.steps}</pre></span>
            </div>
            <div class="detail-row">
                <span class="label">Expected result:</span>
                <span class="value"><pre>${assignment.testCase.expectedResult}</pre></span>
            </div>
        </div>

        <h3>Test result</h3>
        <form method="POST" action="assignments" class="form">
            <input type="hidden" name="action" value="submit-result">
            <input type="hidden" name="id" value="${assignment.id}">

            <div class="form-group">
                <label for="status">Status*</label>
                <select id="status" name="status" required>
                    <option value="">-- Select status --</option>
                    <option value="PASSED">PASSED</option>
                    <option value="FAILED">FAILED</option>
                    <option value="BLOCKED">BLOCKED</option>
                </select>
            </div>

            <div class="form-group">
                <label for="result">Actual result *</label>
                <textarea id="result" name="result" rows="4" required placeholder="Describe what happened while running the test..."></textarea>
            </div>

            <div class="form-group">
                <label for="notes">Notes</label>
                <textarea id="notes" name="notes" rows="3" placeholder="Additional notes, bugs found, etc..."></textarea>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn btn-primary">Submit result</button>
                <a href="assignments" class="btn btn-secondary">Cancel</a>
            </div>
        </form>
    </div>

    <footer>
        <p>&copy; 2026 Require4Testing. All rights reserved.</p>
    </footer>
</body>
</html>
