<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.resturent.model.Employee" %>
<%
  Employee emp = (Employee) request.getAttribute("employee");
%>
<!DOCTYPE html>
<html>
<head>
  <title>Employee Search Result</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background: #f0f2f5;
      padding: 40px;
    }
    .container {
      width: 500px;
      margin: 0 auto;
      background: white;
      border-radius: 8px;
      box-shadow: 0 0 10px rgba(0,0,0,0.1);
      padding: 30px;
    }
    h2 {
      text-align: center;
      color: #333;
    }
    .form-group {
      margin-bottom: 15px;
    }
    label {
      font-weight: bold;
      display: block;
      margin-bottom: 5px;
      color: #555;
    }
    input[type="text"], input[type="email"], select {
      width: 100%;
      padding: 8px;
      background: #f8f8f8;
      border: 1px solid #ccc;
      border-radius: 5px;
    }
    input[readonly] {
      background-color: #e9ecef;
    }
    .btn {
      width: 100%;
      padding: 10px;
      background-color: #007BFF;
      color: white;
      font-weight: bold;
      border: none;
      border-radius: 5px;
      cursor: pointer;
      margin-top: 10px;
    }
    .btn:hover {
      background-color: #0056b3;
    }
    .back-link {
      text-align: center;
      margin-top: 20px;
    }
    .back-link a {
      text-decoration: none;
      color: #007BFF;
      font-weight: bold;
    }
    .success-message {
      color: green;
      text-align: center;
      margin-bottom: 15px;
    }
  </style>
</head>
<body>
<div class="container">
  <h2>Update Employee Status</h2>
  <%
    if (emp != null) {
  %>
  <%
    String message = (String) request.getAttribute("message");
    if (message != null) {
  %>
  <div class="success-message">
    <%= message %>
  </div>
  <%
    }
  %>
  <form action="EmployeeHandling" method="post">
    <input type="hidden" name="id" value="<%= emp.getId() %>">

    <div class="form-group">
      <label>Name:</label>
      <input type="text" name="name" value="<%= emp.getName() %>" readonly>
    </div>

    <div class="form-group">
      <label>Email:</label>
      <input type="email" name="searchEmail" value="<%= emp.getEmail() %>" readonly>
    </div>

    <div class="form-group">
      <label>Role:</label>
      <input type="text" name="role" value="<%= emp.getrole() %>" readonly>
    </div>

    <div class="form-group">
      <label>Phone Number:</label>
      <input type="text" name="number" value="<%= emp.getNumber() %>" readonly>
    </div>

    <div class="form-group">
      <label>Status:</label>
      <select name="status">
        <option value="active" <%= "active".equals(emp.getStatus()) ? "selected" : "" %>>Active</option>
        <option value="inactive" <%= "inactive".equals(emp.getStatus()) ? "selected" : "" %>>Inactive</option>
      </select>
    </div>

    <input type="submit" name="action" value="UpdateStatus" class="btn">
  </form>
  <%
  } else {
  %>
  <p>No employee found with the provided email.</p>
  <%
    }
  %>
  <div class="back-link">
    <a href="employee_search.jsp">Back to Search</a>
  </div>
</div>
</body>
</html>
