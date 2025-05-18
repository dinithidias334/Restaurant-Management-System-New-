<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>Employee Registration</title>
  <style>
    @import url('https://fonts.googleapis.com/css2?family=Segoe+UI:wght@300;400;500;600;700&display=swap');

    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: 'Segoe UI', sans-serif;
      background: linear-gradient(120deg, #f4f6f9 0%, #e8eef5 100%);
      padding: 50px;
      min-height: 100vh;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      position: relative;
      overflow-x: hidden;
    }

    /* Floating particles animation */
    body::before,
    body::after {
      content: '';
      position: fixed;
      width: 250px;
      height: 250px;
      border-radius: 50%;
      background: linear-gradient(45deg, rgba(0, 123, 255, 0.1), rgba(0, 86, 179, 0.1));
      filter: blur(40px);
      z-index: -1;
      animation: float 15s infinite linear alternate;
    }

    body::before {
      top: -100px;
      left: -100px;
      animation-delay: 0s;
    }

    body::after {
      bottom: -100px;
      right: -100px;
      animation-delay: -7.5s;
    }

    @keyframes float {
      0% {
        transform: translate(0, 0) scale(1);
      }
      25% {
        transform: translate(100px, 50px) scale(1.1);
      }
      50% {
        transform: translate(50px, 100px) scale(0.9);
      }
      75% {
        transform: translate(-50px, 50px) scale(1.2);
      }
      100% {
        transform: translate(0, 0) scale(1);
      }
    }

    .container {
      max-width: 500px;
      margin: auto;
      background: #ffffff;
      padding: 30px;
      border-radius: 8px;
      box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
      position: relative;
      animation: container-appear 0.8s ease-out forwards;
      transform-style: preserve-3d;
      overflow: hidden;
      transition: transform 0.3s ease, box-shadow 0.3s ease;
    }

    .container:hover {
      transform: translateY(-5px);
      box-shadow: 0 15px 30px rgba(0, 0, 0, 0.15);
    }

    @keyframes container-appear {
      0% {
        opacity: 0;
        transform: translateY(30px) rotateX(5deg);
      }
      100% {
        opacity: 1;
        transform: translateY(0) rotateX(0);
      }
    }

    /* Glow effect on hover */
    .container::before {
      content: '';
      position: absolute;
      top: -5px;
      left: -5px;
      right: -5px;
      bottom: -5px;
      background: linear-gradient(90deg, #007BFF, #0056b3, #007BFF);
      z-index: -1;
      border-radius: 12px;
      opacity: 0;
      transition: opacity 0.3s ease;
      animation: border-glow 3s infinite alternate;
      filter: blur(12px);
    }

    .container:hover::before {
      opacity: 0.5;
    }

    @keyframes border-glow {
      0% {
        opacity: 0.2;
        filter: blur(15px);
      }
      100% {
        opacity: 0.4;
        filter: blur(10px);
      }
    }

    h2 {
      text-align: center;
      margin-bottom: 25px;
      color: #333;
      position: relative;
      animation: title-appear 1s ease forwards;
      animation-delay: 0.2s;
      opacity: 0;
    }

    @keyframes title-appear {
      0% {
        opacity: 0;
        transform: translateY(-15px);
      }
      100% {
        opacity: 1;
        transform: translateY(0);
      }
    }

    h2::after {
      content: '';
      position: absolute;
      bottom: -8px;
      left: 50%;
      transform: translateX(-50%);
      width: 60px;
      height: 3px;
      background: linear-gradient(90deg, #007BFF, #0056b3);
      border-radius: 2px;
      animation: underline-expand 1s ease forwards;
      animation-delay: 0.5s;
      transform-origin: center;
      opacity: 0;
    }

    @keyframes underline-expand {
      0% {
        width: 0;
        opacity: 0;
      }
      100% {
        width: 60px;
        opacity: 1;
      }
    }

    form {
      animation: form-appear 1s ease forwards;
      animation-delay: 0.4s;
      opacity: 0;
    }

    @keyframes form-appear {
      0% {
        opacity: 0;
        transform: translateY(15px);
      }
      100% {
        opacity: 1;
        transform: translateY(0);
      }
    }

    label {
      font-weight: bold;
      margin-bottom: 6px;
      display: block;
      color: #555;
      transition: color 0.3s ease;
    }

    select,
    input[type="text"],
    input[type="email"],
    input[type="password"],
    input[type="submit"] {
      width: 100%;
      padding: 12px;
      border: 1px solid #ccc;
      border-radius: 6px;
      box-sizing: border-box;
      font-size: 14px;
      transition: all 0.3s ease;
      box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
      margin-bottom: 18px;
    }

    input[type="submit"] {
      background-color: #007BFF;
      color: white;
      border: none;
      cursor: pointer;
      font-weight: bold;
      transition: background 0.3s ease, transform 0.2s ease;
      margin-top: 10px;
    }

    input[type="submit"]:hover {
      background-color: #0056b3;
      transform: translateY(-2px);
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    input[type="submit"]:active {
      transform: translateY(0);
    }

    .success-message {
      color: #28a745;
      text-align: center;
      margin-bottom: 15px;
      padding: 10px;
      background-color: rgba(40, 167, 69, 0.1);
      border-radius: 6px;
      font-weight: 500;
      animation: form-appear 1s ease forwards;
    }

    .back-link {
      text-align: center;
      margin-top: 20px;
      animation: back-link-appear 1s ease forwards;
      animation-delay: 0.6s;
      opacity: 0;
    }

    @keyframes back-link-appear {
      0% {
        opacity: 0;
        transform: translateY(15px);
      }
      100% {
        opacity: 1;
        transform: translateY(0);
      }
    }

    .back-link a {
      text-decoration: none;
      color: #007BFF;
      font-weight: bold;
      padding: 8px 16px;
      border-radius: 6px;
      transition: all 0.3s ease;
      position: relative;
    }

    .back-link a::after {
      content: '';
      position: absolute;
      bottom: 0;
      left: 0;
      width: 0;
      height: 2px;
      background: #007BFF;
      transition: width 0.3s ease;
    }

    .back-link a:hover {
      background: rgba(0, 123, 255, 0.08);
    }

    .back-link a:hover::after {
      width: 100%;
    }

    /* Responsive adjustments */
    @media (max-width: 600px) {
      body {
        padding: 30px 15px;
      }

      .container {
        width: 100%;
        padding: 25px;
      }
    }
  </style>
</head>
<body>
<div class="container">
  <h2>Employee Registration</h2>

  <% if ("success".equals(request.getParameter("status"))) { %>
  <p class="success-message">Employee registered successfully!</p>
  <% } %>

  <form action="EmployeeHandling" method="post">
    <label for="role">Role:</label>
    <input type="text" name="role" id="role" required>

    <label for="name">Full Name:</label>
    <input type="text" name="name" id="name" required>

    <label for="number">Phone Number:</label>
    <input type="text" name="number" id="number" required>

    <label for="email">Email:</label>
    <input type="email" name="email" id="email" required>

    <label for="password">Password:</label>
    <input type="password" name="password" id="password" required>

    <label for="status">Status</label>
    <select name="status" id="status">
      <option value="active">Active</option>
      <option value="inactive">Inactive</option>
    </select>

    <input type="submit" name="action" value="Register">
  </form>
  <div class="back-link">
    <a href="employee.jsp">Back</a>
  </div>
</div>
</body>
</html>