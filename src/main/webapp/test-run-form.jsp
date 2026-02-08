<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create/Edit Test Run - Require4Testing</title>
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

    <div class="container form-container">
        <h2><c:if test="${empty testRun}">Create a new test run</c:if><c:if test="${not empty testRun}">Edit a new test run</c:if></h2>

        <form method="POST" action="test-runs" class="form">
            <input type="hidden" name="action" value="${empty testRun ? 'add' : 'update'}">
            <c:if test="${not empty testRun}">
                <input type="hidden" name="id" value="${testRun.id}">
            </c:if>

            <div class="form-group">
                <label for="name">Test run name *</label>
                <input type="text" id="name" name="name" value="${testRun.name}" required>
            </div>

            <div class="form-group">
                <label for="description">Description</label>
                <textarea id="description" name="description" rows="4">${testRun.description}</textarea>
            </div>

            <div class="form-group">
                <label for="managerName">Manager Name *</label>
                <input type="text" id="managerName" name="managerName" value="${testRun.managerName}" required>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn btn-primary">Save</button>
                <a href="test-runs" class="btn btn-secondary">Cancel</a>
            </div>
        </form>
    </div>

    <footer>
        <p>&copy; 2026 Require4Testing. All rights reserved.</p>
    </footer>
</body>
</html>
