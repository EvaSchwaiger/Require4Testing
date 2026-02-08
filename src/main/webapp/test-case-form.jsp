<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create/Edit Test Case - Require4Testing</title>
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
        <h2><c:if test="${empty testCase}">Create a new test case</c:if><c:if test="${not empty testCase}">Edit a test case</c:if></h2>

        <form method="POST" action="test-cases" class="form">
            <input type="hidden" name="action" value="${empty testCase ? 'add' : 'update'}">
            <c:if test="${not empty testCase}">
                <input type="hidden" name="id" value="${testCase.id}">
            </c:if>

            <div class="form-group">
                <label for="name">Test case name *</label>
                <input type="text" id="name" name="name" value="${testCase.name}" required>
            </div>

            <div class="form-group">
                <label for="description">Description</label>
                <textarea id="description" name="description" rows="3">${testCase.description}</textarea>
            </div>

            <div class="form-group">
                <label for="steps">Steps *</label>
                <textarea id="steps" name="steps" rows="4" required>${testCase.steps}</textarea>
            </div>

            <div class="form-group">
                <label for="expectedResult">Expected Result *</label>
                <textarea id="expectedResult" name="expectedResult" rows="3" required>${testCase.expectedResult}</textarea>
            </div>

            <div class="form-group">
                <label for="creatorName">Creator Name *</label>
                <input type="text" id="creatorName" name="creatorName" value="${testCase.creatorName}" required>
            </div>

            <div class="form-group">
                <label for="requirementId">Requirement *</label>
                <select id="requirementId" name="requirementId" required>
                    <option value="">-- Select a requirement --</option>
                    <c:forEach var="req" items="${requirements}">
                        <option value="${req.id}" <c:if test="${not empty testCase and testCase.requirement.id == req.id}">selected</c:if>>${req.name}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn btn-primary">Save test case</button>
                <a href="test-cases" class="btn btn-secondary">Cancel</a>
            </div>
        </form>
    </div>

    <footer>
        <p>&copy; 2026 Require4Testing. All rights reserved.</p>
    </footer>
</body>
</html>
