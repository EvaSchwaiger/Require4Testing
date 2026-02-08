<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Test case details - Require4Testing</title>
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
        <h2>${testCase.name}</h2>

        <div class="details-card">
            <div class="detail-row">
                <span class="label">ID:</span>
                <span class="value">${testCase.id}</span>
            </div>
            <div class="detail-row">
                <span class="label">Description:</span>
                <span class="value">${testCase.description}</span>
            </div>
            <div class="detail-row">
                <span class="label">Requirement:</span>
                <span class="value"><a href="requirements?action=view&id=${testCase.requirement.id}">${testCase.requirement.name}</a></span>
            </div>
            <div class="detail-row">
                <span class="label">Steps:</span>
                <span class="value"><pre>${testCase.steps}</pre></span>
            </div>
            <div class="detail-row">
                <span class="label">Expected result:</span>
                <span class="value"><pre>${testCase.expectedResult}</pre></span>
            </div>
            <div class="detail-row">
                <span class="label">Creator:</span>
                <span class="value">${testCase.creatorName}</span>
            </div>
            <div class="detail-row">
                <span class="label">Date of creation:</span>
                <span class="value">${testCase.createdDate}</span>
            </div>
        </div>

        <div class="action-buttons">
            <a href="test-cases?action=edit&id=${testCase.id}" class="btn btn-primary">Edit</a>
            <a href="test-cases" class="btn btn-secondary">Back to test cases</a>
        </div>
    </div>

    <footer>
        <p>&copy; 2026 Require4Testing. All rights reserved.</p>
    </footer>
</body>
</html>
