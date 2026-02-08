<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create/Edit a requirement - Require4Testing</title>
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
        <h2><c:if test="${empty requirement}">Create a new requirement</c:if><c:if test="${not empty requirement}">Edit requirement</c:if></h2>

        <form method="POST" action="requirements" class="form">
            <input type="hidden" name="action" value="${empty requirement ? 'add' : 'update'}">
            <c:if test="${not empty requirement}">
                <input type="hidden" name="id" value="${requirement.id}">
            </c:if>

            <div class="form-group">
                <label for="name">Name of the requirement *</label>
                <input type="text" id="name" name="name" value="${requirement.name}" required>
            </div>

            <div class="form-group">
                <label for="description">Description</label>
                <textarea id="description" name="description" rows="4">${requirement.description}</textarea>
            </div>

            <div class="form-group">
                <label for="engineerName">Engineer's name *</label>
                <input type="text" id="engineerName" name="engineerName" value="${requirement.engineerName}" required>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn btn-primary">Save</button>
                <a href="requirements" class="btn btn-secondary">Cancel</a>
            </div>
        </form>
    </div>

    <footer>
        <p>&copy; 2026 Require4Testing. All rights reserved.</p>
    </footer>
</body>
</html>
