<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Your Cart</title>
  <style>
    /* Modern Font and Base Styles */
    @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap');

    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: 'Poppins', sans-serif;
    }

    body {
      background: linear-gradient(135deg, #f5f7fa 0%, #e4e8f0 100%);
      min-height: 100vh;
      padding: 40px 20px;
      overflow-x: hidden;
    }

    h2 {
      text-align: center;
      margin-bottom: 30px;
      color: #333;
      font-size: 2.5rem;
      font-weight: 600;
      letter-spacing: 1px;
      position: relative;
      padding-bottom: 15px;
      animation: fadeInDown 0.8s ease-out;
    }

    h2::after {
      content: '';
      position: absolute;
      bottom: 0;
      left: 50%;
      transform: translateX(-50%);
      width: 80px;
      height: 4px;
      background: linear-gradient(90deg, #ff7e5f, #feb47b);
      border-radius: 2px;
      animation: expandWidth 1.5s ease-out forwards;
    }

    .cart-container {
      max-width: 1000px;
      margin: 0 auto 60px;
      background: rgba(255, 255, 255, 0.95);
      border-radius: 20px;
      box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
      overflow: hidden;
      animation: fadeIn 0.8s ease-out;
      transition: transform 0.3s ease;
      padding: 30px;
    }

    .cart-container:hover {
      transform: translateY(-5px);
    }

    table {
      width: 100%;
      border-collapse: collapse;
      margin-bottom: 25px;
      animation: fadeIn 0.8s ease-out;
    }

    th, td {
      padding: 15px 12px;
      text-align: center;
    }

    th {
      background: linear-gradient(90deg, #ff7e5f, #feb47b);
      color: white;
      font-size: 1.1rem;
      font-weight: 600;
      letter-spacing: 0.5px;
      text-shadow: 0 1px 2px rgba(0, 0, 0, 0.2);
      position: relative;
      overflow: hidden;
    }

    th::before {
      content: '';
      position: absolute;
      top: 0;
      left: -100%;
      width: 100%;
      height: 100%;
      background: linear-gradient(90deg, rgba(255, 255, 255, 0), rgba(255, 255, 255, 0.3), rgba(255, 255, 255, 0));
      animation: shine 3s infinite;
    }

    tr {
      border-bottom: 1px solid #f0f0f0;
      transition: all 0.3s ease;
    }

    tr:hover:not(.total-row) {
      background-color: #f9f9f9;
    }

    tr:last-child {
      border-bottom: none;
    }

    td {
      font-size: 1rem;
      vertical-align: middle;
      color: #333;
    }

    .total-row {
      background: #f8fafc;
      font-weight: 600;
    }

    .total-row td:last-child {
      color: #ff7e5f;
      font-size: 1.1rem;
      font-weight: 700;
    }

    .discount-form {
      margin: 25px auto;
      text-align: center;
      padding: 20px 0;
      border-top: 1px dashed #ddd;
      animation: fadeIn 1s ease-out;
    }

    .discount-form label {
      font-size: 1rem;
      font-weight: 500;
      color: #555;
      margin-right: 10px;
    }

    .discount-form input[type="number"] {
      width: 80px;
      padding: 10px;
      border: 1px solid #ddd;
      border-radius: 8px;
      margin-right: 10px;
      font-size: 1rem;
      text-align: center;
    }

    .discount-form select {
      padding: 10px;
      border-radius: 8px;
      border: 1px solid #ddd;
      font-size: 1rem;
      margin-right: 10px;
      background: white;
    }

    .discount-form button {
      background: linear-gradient(90deg, #ff7e5f, #feb47b);
      color: white;
      border: none;
      padding: 10px 25px;
      border-radius: 50px;
      cursor: pointer;
      font-weight: 600;
      letter-spacing: 0.5px;
      box-shadow: 0 4px 15px rgba(255, 126, 95, 0.3);
      transition: all 0.3s ease;
      position: relative;
      overflow: hidden;
    }

    .discount-form button:hover {
      background: linear-gradient(90deg, #ff6b4a, #fea564);
      transform: translateY(-3px);
      box-shadow: 0 6px 18px rgba(255, 126, 95, 0.4);
    }

    .discount-form button::after {
      content: '';
      position: absolute;
      top: 50%;
      left: 50%;
      width: 5px;
      height: 5px;
      background: rgba(255, 255, 255, 0.8);
      opacity: 0;
      border-radius: 100%;
      transform: scale(1);
      transition: 0.5s;
    }

    .discount-form button:active::after {
      transform: scale(25);
      opacity: 0;
      transition: 0s;
    }

    .navigation {
      display: flex;
      flex-direction: column;
      align-items: center;
      margin: 20px 0;
      gap: 20px;
    }

    .back-to-menu {
      display: inline-block;
      color: #ff7e5f;
      text-decoration: none;
      font-weight: 600;
      font-size: 1.1rem;
      transition: all 0.3s ease;
      position: relative;
    }

    .back-to-menu:hover {
      color: #ff6b4a;
      transform: translateX(-3px);
    }

    .back-to-menu::after {
      content: '';
      position: absolute;
      bottom: -5px;
      left: 0;
      width: 0;
      height: 2px;
      background: linear-gradient(90deg, #ff7e5f, #feb47b);
      transition: width 0.3s ease;
    }

    .back-to-menu:hover::after {
      width: 100%;
    }

    .confirm-btn {
      background: linear-gradient(90deg, #3a7bd5, #3a6073);
      color: white;
      border: none;
      padding: 12px 30px;
      font-size: 1.1rem;
      font-weight: 600;
      border-radius: 50px;
      cursor: pointer;
      letter-spacing: 0.5px;
      box-shadow: 0 8px 20px rgba(58, 123, 213, 0.3);
      transition: all 0.3s ease;
      animation: pulse 2s infinite;
      width: 200px;
    }

    .confirm-btn:hover {
      background: linear-gradient(90deg, #3a6db9, #2d4c5e);
      box-shadow: 0 10px 25px rgba(58, 123, 213, 0.5);
      transform: translateY(-3px);
    }

    .empty-cart {
      text-align: center;
      padding: 50px 0;
      font-size: 1.2rem;
      color: #777;
      animation: fadeIn 1s ease-out;
    }

    /* Animations */
    @keyframes fadeIn {
      0% {
        opacity: 0;
      }
      100% {
        opacity: 1;
      }
    }

    @keyframes fadeInDown {
      0% {
        opacity: 0;
        transform: translateY(-30px);
      }
      100% {
        opacity: 1;
        transform: translateY(0);
      }
    }

    @keyframes expandWidth {
      0% {
        width: 0;
      }
      100% {
        width: 80px;
      }
    }

    @keyframes shine {
      0% {
        left: -100%;
      }
      20% {
        left: 100%;
      }
      100% {
        left: 100%;
      }
    }

    @keyframes pulse {
      0% {
        transform: scale(1);
        box-shadow: 0 8px 20px rgba(58, 123, 213, 0.3);
      }
      50% {
        transform: scale(1.03);
        box-shadow: 0 12px 25px rgba(58, 123, 213, 0.4);
      }
      100% {
        transform: scale(1);
        box-shadow: 0 8px 20px rgba(58, 123, 213, 0.3);
      }
    }

    /* Media Queries */
    @media (max-width: 768px) {
      h2 {
        font-size: 2rem;
      }

      .cart-container {
        padding: 20px 10px;
      }

      table, th, td {
        font-size: 0.9rem;
        padding: 10px 5px;
      }

      .discount-form button,
      .confirm-btn {
        width: 100%;
        max-width: 300px;
        font-size: 1rem;
      }
    }
  </style>
</head>
<body>
<h2>Your Cart</h2>
<%
  List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("cart");
  Integer discountValue = (Integer) session.getAttribute("discountValue");
  String discountType = (String) session.getAttribute("discountType");
  if (discountValue == null) discountValue = 0;
  if (discountType == null) discountType = "percent"; // default

  int grandTotal = 0;
  if (cart != null && !cart.isEmpty()) {
%>
<div class="cart-container">
  <table>
    <tr>
      <th>Item Name</th>
      <th>Unit Price</th>
      <th>Quantity</th>
      <th>Total</th>
    </tr>
    <%
      for (Map<String, Object> item : cart) {
        int price = (Integer)item.get("price");
        int qty = (Integer)item.get("quantity");
        int total = price * qty;
        grandTotal += total;
    %>
    <tr>
      <td><%= item.get("name") %></td>
      <td>Rs. <%= price %></td>
      <td><%= qty %></td>
      <td>Rs. <%= total %></td>
    </tr>
    <% } %>
    <tr class="total-row">
      <td colspan="3">Grand Total</td>
      <td>Rs. <%= grandTotal %></td>
    </tr>
    <%
      // Calculate discount
      int discountAmount = 0;
      if (discountValue > 0) {
        if ("percent".equals(discountType)) {
          discountAmount = grandTotal * discountValue / 100;
        } else {
          discountAmount = discountValue;
        }
      }
      int finalTotal = grandTotal - discountAmount;
    %>
    <tr class="total-row">
      <td colspan="3">Discount (<%= discountType.equals("percent") ? discountValue + "%" : "Rs. " + discountValue %>)</td>
      <td>- Rs. <%= discountAmount %></td>
    </tr>
    <tr class="total-row">
      <td colspan="3">Total to Pay</td>
      <td>Rs. <%= finalTotal %></td>
    </tr>
  </table>
  <form class="discount-form" action="CartServlet" method="post">
    <label>Discount:
      <input type="number" name="discountValue" value="<%= discountValue %>" min="0" />
    </label>
    <select name="discountType">
      <option value="percent" <%= "percent".equals(discountType) ? "selected" : "" %>>%</option>
      <option value="fixed" <%= "fixed".equals(discountType) ? "selected" : "" %>>Rs.</option>
    </select>
    <input type="hidden" name="action" value="applyDiscount"/>
    <button type="submit">Apply Discount</button>
  </form>

  <div class="navigation">
    <a href="menu.jsp" class="back-to-menu">Back to Menu</a>
    <form action="ConfirmOrderServlet" method="post">
      <button type="submit" class="confirm-btn">Pay & Confirm</button>
    </form>
  </div>
</div>
<% } else { %>
<div class="cart-container">
  <div class="empty-cart">Your cart is empty.</div>
  <div class="navigation">
    <a href="menu.jsp" class="back-to-menu">Back to Menu</a>
  </div>
</div>
<% } %>
</body>
</html>