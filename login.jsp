<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>Login Page</title>
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: 'Poppins', Arial, sans-serif;
    }

    body {
      background: linear-gradient(120deg, #2563eb 0%, #16a34a 100%);
      height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      overflow: hidden;
      position: relative;
    }

    /* Animated background elements */
    .bg-bubbles {
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      z-index: 1;
      overflow: hidden;
    }

    .bg-bubbles li {
      position: absolute;
      list-style: none;
      display: block;
      width: 40px;
      height: 40px;
      background-color: rgba(255, 255, 255, 0.15);
      bottom: -160px;
      border-radius: 50%;
      animation: square 25s infinite;
      transition-timing-function: linear;
    }

    .bg-bubbles li:nth-child(1) {
      left: 10%;
      animation-delay: 0s;
      animation-duration: 22s;
      width: 80px;
      height: 80px;
    }

    .bg-bubbles li:nth-child(2) {
      left: 20%;
      animation-delay: 2s;
      animation-duration: 17s;
      width: 60px;
      height: 60px;
    }

    .bg-bubbles li:nth-child(3) {
      left: 25%;
      animation-delay: 4s;
      width: 50px;
      height: 50px;
    }

    .bg-bubbles li:nth-child(4) {
      left: 40%;
      animation-delay: 0s;
      animation-duration: 18s;
      width: 60px;
      height: 60px;
    }

    .bg-bubbles li:nth-child(5) {
      left: 70%;
      animation-delay: 4s;
    }

    .bg-bubbles li:nth-child(6) {
      left: 80%;
      animation-delay: 8s;
      width: 70px;
      height: 70px;
    }

    .bg-bubbles li:nth-child(7) {
      left: 32%;
      animation-delay: 10s;
      width: 90px;
      height: 90px;
    }

    .bg-bubbles li:nth-child(8) {
      left: 55%;
      animation-delay: 15s;
      animation-duration: 40s;
      width: 45px;
      height: 45px;
    }

    .bg-bubbles li:nth-child(9) {
      left: 25%;
      animation-delay: 2s;
      animation-duration: 40s;
      width: 35px;
      height: 35px;
    }

    .bg-bubbles li:nth-child(10) {
      left: 90%;
      animation-delay: 11s;
      width: 90px;
      height: 90px;
    }

    @keyframes square {
      0% {
        transform: translateY(0) rotate(0deg);
        opacity: 1;
      }
      100% {
        transform: translateY(-1000px) rotate(720deg);
        opacity: 0;
      }
    }

    .login-box {
      background: rgba(255, 255, 255, 0.9);
      border-radius: 20px;
      padding: 40px;
      width: 400px;
      max-width: 90%;
      box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
      z-index: 10;
      position: relative;
      backdrop-filter: blur(10px);
      transform: translateY(30px);
      opacity: 0;
      animation: fadeIn 0.8s forwards;
    }

    @keyframes fadeIn {
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }

    .login-box h2 {
      text-align: center;
      color: #2563eb;
      margin-bottom: 30px;
      font-size: 32px;
      font-weight: 700;
      position: relative;
      padding-bottom: 10px;
    }

    .login-box h2:after {
      content: '';
      position: absolute;
      left: 50%;
      bottom: 0;
      transform: translateX(-50%);
      height: 4px;
      width: 50px;
      border-radius: 2px;
      background: linear-gradient(90deg, #2563eb, #16a34a);
    }

    .error {
      color: #e53e3e;
      text-align: center;
      margin-bottom: 20px;
      background: rgba(229, 62, 62, 0.1);
      padding: 10px;
      border-radius: 5px;
      border-left: 4px solid #e53e3e;
      animation: shake 0.5s;
    }

    @keyframes shake {
      0%, 100% { transform: translateX(0); }
      10%, 30%, 50%, 70%, 90% { transform: translateX(-5px); }
      20%, 40%, 60%, 80% { transform: translateX(5px); }
    }

    form {
      display: flex;
      flex-direction: column;
      gap: 20px;
    }

    input {
      width: 100%;
      padding: 15px;
      border: none;
      background: rgba(255, 255, 255, 0.8);
      border-radius: 10px;
      box-shadow: inset 0 2px 5px rgba(0, 0, 0, 0.1);
      font-size: 16px;
      transition: all 0.3s;
      position: relative;
      z-index: 1;
    }

    input::placeholder {
      color: #999;
    }

    input:focus {
      outline: none;
      box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.3), inset 0 2px 5px rgba(0, 0, 0, 0.1);
    }

    input[type="text"], input[type="password"] {
      transform: translateX(-20px);
      opacity: 0;
      animation: slideIn 0.5s forwards;
    }

    input[type="password"] {
      animation-delay: 0.2s;
    }

    input[type="submit"] {
      background: linear-gradient(90deg, #2563eb, #16a34a);
      color: white;
      cursor: pointer;
      font-weight: 600;
      box-shadow: 0 4px 15px rgba(37, 99, 235, 0.3);
      transform: translateY(20px);
      opacity: 0;
      animation: slideUp 0.5s forwards;
      animation-delay: 0.4s;
      transition: transform 0.3s, box-shadow 0.3s;
    }

    input[type="submit"]:hover {
      transform: translateY(-3px);
      box-shadow: 0 6px 20px rgba(37, 99, 235, 0.4);
    }

    input[type="submit"]:active {
      transform: translateY(0);
      box-shadow: 0 4px 15px rgba(37, 99, 235, 0.3);
    }

    @keyframes slideIn {
      to {
        transform: translateX(0);
        opacity: 1;
      }
    }

    @keyframes slideUp {
      to {
        transform: translateY(0);
        opacity: 1;
      }
    }

    /* Floating label effect */
    .input-container {
      position: relative;
    }

    .input-container label {
      position: absolute;
      left: 15px;
      top: 50%;
      transform: translateY(-50%);
      color: #999;
      pointer-events: none;
      transition: all 0.3s;
    }

    .input-container input:focus ~ label,
    .input-container input:not(:placeholder-shown) ~ label {
      top: 0;
      transform: translateY(-50%) scale(0.8);
      background: white;
      padding: 0 5px;
      color: #2563eb;
    }
  </style>
</head>
<body>
<ul class="bg-bubbles">
  <li></li>
  <li></li>
  <li></li>
  <li></li>
  <li></li>
  <li></li>
  <li></li>
  <li></li>
  <li></li>
  <li></li>
</ul>
<div class="login-box">
  <h2>Login</h2>

  <% String error = (String) request.getAttribute("error"); %>
  <% if (error != null) { %>
  <p class="error"><%= error %></p>
  <% } %>

  <form method="post" action="Login">
    <input type="text" name="email" placeholder="Email" required />
    <input type="password" name="password" placeholder="Password" required />
    <input type="submit" value="Login" />
  </form>
</div>

</body>
</html>
