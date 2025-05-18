<%@ page import="java.sql.*,java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Menu Items</title>
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

    .menu-container {
      max-width: 1200px;
      margin: 0 auto 60px;
      background: rgba(255, 255, 255, 0.95);
      border-radius: 20px;
      box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
      overflow: hidden;
      animation: fadeIn 0.8s ease-out;
      transition: transform 0.3s ease;
    }

    .menu-container:hover {
      transform: translateY(-5px);
    }

    .category-title {
      background: linear-gradient(90deg, #ff7e5f, #feb47b);
      color: white;
      font-size: 1.5rem;
      font-weight: 600;
      padding: 15px 25px;
      text-shadow: 0 1px 2px rgba(0, 0, 0, 0.2);
      letter-spacing: 0.5px;
      position: relative;
      overflow: hidden;
    }

    .category-title::before {
      content: '';
      position: absolute;
      top: 0;
      left: -100%;
      width: 100%;
      height: 100%;
      background: linear-gradient(90deg, rgba(255, 255, 255, 0), rgba(255, 255, 255, 0.3), rgba(255, 255, 255, 0));
      animation: shine 3s infinite;
    }

    .item-row {
      display: flex;
      flex-wrap: wrap;
      justify-content: space-around;
      padding: 20px;
    }

    .item-box {
      background: white;
      width: 46%;
      border-radius: 15px;
      margin-bottom: 25px;
      box-shadow: 0 8px 20px rgba(0, 0, 0, 0.05);
      padding: 20px;
      display: flex;
      flex-direction: column;
      align-items: center;
      position: relative;
      overflow: hidden;
      transform: translateY(30px);
      opacity: 0;
      animation: slideUp 0.6s ease-out forwards;
      transition: all 0.3s ease;
    }

    .item-box:hover {
      transform: scale(1.03);
      box-shadow: 0 12px 30px rgba(0, 0, 0, 0.1);
    }

    .item-box img {
      width: 75%;
      height: 180px;
      object-fit: cover;
      border-radius: 10px;
      margin-bottom: 15px;
      transition: transform 0.5s ease;
    }

    .item-box:hover img {
      transform: scale(1.08);
    }

    .item-name {
      font-size: 1.2rem;
      font-weight: 600;
      color: #333;
      margin-bottom: 8px;
      text-align: center;
    }

    .item-price {
      font-size: 1.25rem;
      font-weight: 700;
      color: #ff7e5f;
      margin-bottom: 15px;
    }

    .add-cart-form {
      width: 100%;
      display: flex;
      flex-direction: column;
      align-items: center;
    }

    .add-cart-form label {
      margin-bottom: 10px;
      font-size: 0.9rem;
      font-weight: 500;
      color: #555;
    }

    .add-cart-form input[type="number"] {
      padding: 8px;
      border: 1px solid #ddd;
      border-radius: 5px;
      text-align: center;
      font-size: 0.9rem;
      margin-left: 5px;
    }

    .add-cart-form input[type="submit"] {
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

    .add-cart-form input[type="submit"]:hover {
      background: linear-gradient(90deg, #ff6b4a, #fea564);
      transform: translateY(-3px);
      box-shadow: 0 6px 18px rgba(255, 126, 95, 0.4);
    }

    .add-cart-form input[type="submit"]::after {
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

    .add-cart-form input[type="submit"]:active::after {
      transform: scale(25);
      opacity: 0;
      transition: 0s;
    }

    .place-order-btn {
      display: block;
      width: 200px;
      margin: 30px auto;
      background: linear-gradient(90deg, #3a7bd5, #3a6073);
      color: white;
      border: none;
      padding: 12px 25px;
      font-size: 1.1rem;
      font-weight: 600;
      border-radius: 50px;
      cursor: pointer;
      letter-spacing: 0.5px;
      box-shadow: 0 8px 20px rgba(58, 123, 213, 0.3);
      transition: all 0.3s ease;
      animation: pulse 2s infinite;
    }

    .place-order-btn:hover {
      background: linear-gradient(90deg, #3a6db9, #2d4c5e);
      box-shadow: 0 10px 25px rgba(58, 123, 213, 0.5);
      transform: translateY(-3px);
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

    @keyframes slideUp {
      0% {
        opacity: 0;
        transform: translateY(30px);
      }
      100% {
        opacity: 1;
        transform: translateY(0);
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

    /* Apply staggered animations to each item-box */
    .item-box:nth-child(1) { animation-delay: 0.1s; }
    .item-box:nth-child(2) { animation-delay: 0.25s; }
    .item-box:nth-child(3) { animation-delay: 0.4s; }
    .item-box:nth-child(4) { animation-delay: 0.55s; }
    .item-box:nth-child(5) { animation-delay: 0.7s; }
    .item-box:nth-child(6) { animation-delay: 0.85s; }

    /* Media Queries */
    @media (max-width: 768px) {
      .item-box {
        width: 100%;
      }

      h2 {
        font-size: 2rem;
      }

      .category-title {
        font-size: 1.3rem;
      }
    }
  </style>
</head>
<body>
<h2>Menu Items</h2>
<%
  Connection conn = null;
  Statement stmt = null;
  ResultSet rs = null;
  Map<String, List<Map<String, Object>>> categories = new LinkedHashMap<>();
  try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/resturent1", "root", "");
    stmt = conn.createStatement();
    rs = stmt.executeQuery("SELECT * FROM item");
    while(rs.next()) {
      String category = rs.getString("category");
      Map<String, Object> item = new HashMap<>();
      item.put("id", rs.getInt("id"));
      item.put("name", rs.getString("name"));
      item.put("price", rs.getInt("price"));
      item.put("image", rs.getString("image"));
      //Group items by category
      if (!categories.containsKey(category)) {
        categories.put(category, new ArrayList<>());
      }
      categories.get(category).add(item);
    }
  } catch(Exception e) {
    out.println("Error: " + e.getMessage());
  } finally {
    if (rs != null) try { rs.close(); } catch(Exception e) {}
    if (stmt != null) try { stmt.close(); } catch(Exception e) {}
    if (conn != null) try { conn.close(); } catch(Exception e) {}
  }
  for (String category : categories.keySet()) {
%>
<div class="menu-container">
  <div class="category-title"><%= category %></div>
  <div class="item-row">
    <%
      List<Map<String, Object>> items = categories.get(category);
      for (int i = 0; i < items.size(); i++) {
        Map<String, Object> item = items.get(i);
    %>
    <div class="item-box">
      <img src="<%= item.get("image") %>" alt="Image"/>
      <div class="item-name"><%= item.get("name") %></div>
      <div class="item-price">Rs. <%= item.get("price") %></div>
      <form class="add-cart-form" action="CartServlet" method="post">

        <input type="hidden" name="action" value="add"/>
        <input type="hidden" name="id" value="<%= item.get("id") %>"/>
        <input type="hidden" name="name" value="<%= item.get("name") %>"/>
        <input type="hidden" name="price" value="<%= item.get("price") %>"/>
        <label>Qty:
          <input type="number" name="quantity" value="1" min="1" style="width: 60px;"/>
        </label>
        <input type="submit" value="Add to Cart"/>
      </form>
    </div>
    <%
      if ((i + 1) % 2 == 0 && (i + 1) < items.size()) {
    %>
  </div>
  <div class="item-row">
    <%
        }
      }
    %>
  </div>
  <%
    }
  %>
  <form action="CartServlet" method="post" >
    <input type="hidden" name="action" value="placeOrder"/>
    <button type="submit" class="place-order-btn">Check out</button>
  </form>

</div>
</body>
</html>