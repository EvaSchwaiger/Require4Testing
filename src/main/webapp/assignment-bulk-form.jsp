<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Assignment of test cases - Require4Testing</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .test-case-item {
            border: 1px solid #ddd;
            padding: 10px;
            margin: 5px 0;
            border-radius: 5px;
            background-color: #f9f9f9;
        }
        .test-case-item.selected {
            background-color: #e3f2fd;
            border-color: #2196f3;
        }
        .checkbox-group {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .bulk-actions {
            background-color: #f5f5f5;
            padding: 15px;
            border-radius: 5px;
            margin: 20px 0;
        }
    </style>
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
        <h2>Assignment of test cases</h2>
        <p><strong>Test run:</strong> ${testRun.name}</p>

        <div class="bulk-actions">
            <button type="button" onclick="selectAll()" class="btn btn-secondary">Select all</button>
            <button type="button" onclick="deselectAll()" class="btn btn-secondary">Deselect</button>
            <span id="selected-count">Selected: 0</span>
        </div>

        <form method="POST" action="assignments" class="form" id="bulk-form">
            <input type="hidden" name="action" value="bulk-assign">
            <input type="hidden" name="testRunId" value="${testRun.id}">

            <div class="form-group">
                <label for="testerName">Name des Testers fuer alle ausgewaehlten Faelle *</label>
                <input type="text" id="testerName" name="testerName" placeholder="Geben Sie den Namen des Testers ein" required>
            </div>

            <h3>Verfuegbare Testfaelle:</h3>
            <div id="test-cases-list">
                <c:forEach var="tc" items="${availableTestCases}">
                    <div class="test-case-item" id="tc-${tc.id}">
                        <div class="checkbox-group">
                            <input type="checkbox" name="testCaseIds" value="${tc.id}" id="checkbox-${tc.id}" onchange="updateSelection()">
                            <label for="checkbox-${tc.id}">
                                <strong>${tc.name}</strong><br>
                                <small>Requirement: ${tc.requirement.name}</small><br>
                                <small>Description: ${tc.description}</small>
                            </label>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <c:if test="${empty availableTestCases}">
                <p class="text-center">All test cases are already assigned to this test run.</p>
            </c:if>

            <div class="form-actions">
                <button type="submit" class="btn btn-primary" id="assign-btn" disabled>Assign selected cases</button>
                <a href="test-runs?action=view&id=${testRun.id}" class="btn btn-secondary">Cancel</a>
            </div>
        </form>
    </div>

    <footer>
        <p>&copy; 2026 Require4Testing. All rights reserved.</p>
    </footer>

    <script>
        function selectAll() {
            const checkboxes = document.querySelectorAll('input[name="testCaseIds"]');
            checkboxes.forEach(cb => cb.checked = true);
            updateSelection();
        }

        function deselectAll() {
            const checkboxes = document.querySelectorAll('input[name="testCaseIds"]');
            checkboxes.forEach(cb => cb.checked = false);
            updateSelection();
        }

        function updateSelection() {
            const checkboxes = document.querySelectorAll('input[name="testCaseIds"]');
            const selectedCount = document.querySelectorAll('input[name="testCaseIds"]:checked').length;
            const assignBtn = document.getElementById('assign-btn');
            const counter = document.getElementById('selected-count');

            counter.textContent = `Selected: ${selectedCount}`;

            // Enable/disable assign button
            assignBtn.disabled = selectedCount === 0;

            // Visual feedback for selected items
            checkboxes.forEach(cb => {
                const item = cb.closest('.test-case-item');
                if (cb.checked) {
                    item.classList.add('selected');
                } else {
                    item.classList.remove('selected');
                }
            });
        }

        // Initialize on page load
        document.addEventListener('DOMContentLoaded', updateSelection);
    </script>
</body>
</html>