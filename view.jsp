<!DOCTYPE html>
<html>
<head>
  <title>Employee Search</title>
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

    .form-container {
      max-width: 400px;
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

    .form-container:hover {
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
    .form-container::before {
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

    .form-container:hover::before {
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

    select, input[type="text"] {
      width: 100%;
      padding: 12px;
      margin-bottom: 20px;
      border: 1px solid #ccc;
      border-radius: 6px;
      box-sizing: border-box;
      font-size: 14px;
      transition: all 0.3s ease;
      box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
    }

    input[type="text"]:focus {
      border-color: #007BFF;
      box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.2);
      outline: none;
      transform: translateY(-2px);
    }

    input[type="submit"] {
      width: 100%;
      padding: 12px;
      margin-bottom: 20px;
      background-color: #007BFF;
      color: white;
      border: none;
      border-radius: 6px;
      cursor: pointer;
      transition: all 0.3s ease;
      font-size: 14px;
      font-weight: 600;
      box-shadow: 0 4px 10px rgba(0, 123, 255, 0.2);
      position: relative;
      overflow: hidden;
    }

    input[type="submit"]::before {
      content: '';
      position: absolute;
      top: 0;
      left: -100%;
      width: 100%;
      height: 100%;
      background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
      transition: all 0.6s ease;
    }

    input[type="submit"]:hover {
      background-color: #0056b3;
      transform: translateY(-2px);
      box-shadow: 0 6px 15px rgba(0, 123, 255, 0.25);
    }

    input[type="submit"]:hover::before {
      left: 100%;
    }

    input[type="submit"]:active {
      transform: translateY(1px);
      box-shadow: 0 2px 5px rgba(0, 123, 255, 0.25);
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

      .form-container {
        width: 100%;
        padding: 25px;
      }
    }
  </style>
</head>
<body>

<div class="form-container">
  <h2>Search Employee</h2>

  <form action="EmployeeHandling" method="post">
    <label for="searchEmail">Search by Email</label>
    <input type="text" name="searchEmail" id="searchEmail" placeholder="Enter email to search" required>
    <input type="submit" name="action" value="SearchForView">
  </form>
</div>
<div class="back-link">
  <a href="employee.jsp">Back</a>
</div>

</body>
</html>