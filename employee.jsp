<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>Employee Management</title>
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

    h1 {
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

    h1::after {
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

    .dashboard-container {
      display: flex;
      justify-content: center;
      flex-wrap: wrap;
      gap: 30px;
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

    .card {
      background: white;
      width: 200px;
      height: 150px;
      border-radius: 10px;
      box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 18px;
      font-weight: bold;
      transition: all 0.3s ease;
      text-decoration: none;
      color: #333;
      position: relative;
      overflow: hidden;
    }

    .card:hover {
      background-color: #007bff;
      color: white;
      transform: translateY(-5px) scale(1.05);
      box-shadow: 0 15px 30px rgba(0, 0, 0, 0.15);
    }

    /* Glow effect on hover */
    .card::before {
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

    .card:hover::before {
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

      .dashboard-container {
        width: 100%;
      }

      .card {
        width: 100%;
        max-width: 200px;
      }
    }
  </style>
</head>
<body>
<h1>Employee Management</h1>
<div class="dashboard-container">
  <a href="employee_register.jsp" class="card">Add Employee</a>
  <a href="employee_search.jsp" class="card">Remove Employee</a>
  <a href="view.jsp" class="card">View Employees</a>

</div>
<div class="back-link">
  <a href="dashbord.jsp">Back</a>
</div>
</body>
</html>