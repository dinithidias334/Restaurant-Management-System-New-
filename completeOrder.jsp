<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Completed Orders</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
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

        .container {
            max-width: 1200px;
            margin: 0 auto 60px;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            animation: fadeIn 0.8s ease-out;
            transition: transform 0.3s ease;
            padding: 25px;
        }

        .container:hover {
            transform: translateY(-5px);
        }

        .nav-buttons {
            display: flex;
            justify-content: flex-start;
            margin-bottom: 20px;
            animation: fadeIn 0.8s ease-out;
        }

        .link-btn {
            background: linear-gradient(90deg, #3a7bd5, #3a6073);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 50px;
            cursor: pointer;
            font-weight: 600;
            letter-spacing: 0.5px;
            box-shadow: 0 4px 15px rgba(58, 123, 213, 0.3);
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            text-decoration: none;
        }

        .link-btn:hover {
            background: linear-gradient(90deg, #3a6db9, #2d4c5e);
            transform: translateY(-3px);
            box-shadow: 0 6px 18px rgba(58, 123, 213, 0.4);
        }

        .link-btn i {
            margin-right: 8px;
        }

        .controls {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            flex-wrap: wrap;
            animation: fadeIn 0.8s ease-out;
            animation-delay: 0.2s;
            opacity: 0;
            animation-fill-mode: forwards;
        }

        .search-box {
            position: relative;
            flex: 1;
            max-width: 350px;
            margin-right: 15px;
        }

        .search-box i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #999;
        }

        .search-box input {
            width: 100%;
            padding: 12px 15px 12px 40px;
            border: 1px solid #ddd;
            border-radius: 50px;
            font-size: 0.9rem;
            transition: all 0.3s ease;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }

        .search-box input:focus {
            border-color: #ff7e5f;
            box-shadow: 0 2px 15px rgba(255, 126, 95, 0.2);
            outline: none;
        }

        .date-filter {
            display: flex;
            align-items: center;
        }

        .date-filter label {
            margin-right: 10px;
            font-weight: 500;
            color: #555;
        }

        .date-filter select {
            padding: 10px 15px;
            border: 1px solid #ddd;
            border-radius: 50px;
            font-size: 0.9rem;
            background-color: white;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            transition: all 0.3s ease;
        }

        .date-filter select:focus {
            border-color: #ff7e5f;
            box-shadow: 0 2px 15px rgba(255, 126, 95, 0.2);
            outline: none;
        }

        .date-filter i {
            margin-right: 5px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.05);
            animation: slideUp 0.8s ease-out;
        }

        table thead {
            background: linear-gradient(90deg, #ff7e5f, #feb47b);
            color: white;
        }

        table th {
            padding: 15px;
            text-align: left;
            font-weight: 600;
            text-shadow: 0 1px 2px rgba(0, 0, 0, 0.2);
            position: relative;
        }

        table td {
            padding: 15px;
            border-bottom: 1px solid #eee;
            background-color: white;
            transition: all 0.3s ease;
        }

        .order-row {
            transform: translateY(30px);
            opacity: 0;
            animation: slideUp 0.6s ease-out forwards;
            transition: all 0.3s ease;
        }

        .order-row:hover td {
            background-color: #f9f9f9;
        }

        /* Apply staggered animations to each row */
        .order-row:nth-child(1) { animation-delay: 0.1s; }
        .order-row:nth-child(2) { animation-delay: 0.25s; }
        .order-row:nth-child(3) { animation-delay: 0.4s; }
        .order-row:nth-child(4) { animation-delay: 0.55s; }
        .order-row:nth-child(5) { animation-delay: 0.7s; }
        .order-row:nth-child(6) { animation-delay: 0.85s; }

        .order-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 5px 10px;
            margin-bottom: 5px;
            background-color: #f8f8f8;
            border-radius: 5px;
            transition: all 0.3s ease;
        }

        .order-item:hover {
            background-color: #f0f0f0;
        }

        .item-id {
            font-size: 0.8rem;
            color: #888;
            margin-right: 5px;
        }

        .item-name {
            flex: 1;
            font-weight: 500;
        }

        .item-qty {
            font-weight: 600;
            color: #ff7e5f;
            margin-left: 10px;
        }

        .timestamp {
            font-size: 0.9rem;
            color: #777;
        }

        .timestamp i {
            margin-right: 5px;
            color: #ff7e5f;
        }

        .empty-state {
            text-align: center;
            padding: 50px 20px;
            color: #888;
        }

        .empty-state i {
            font-size: 3rem;
            color: #ccc;
            margin-bottom: 15px;
        }

        .empty-state p {
            margin-bottom: 10px;
            font-size: 1.1rem;
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

        /* Media Queries */
        @media (max-width: 768px) {
            .controls {
                flex-direction: column;
                align-items: stretch;
            }

            .search-box {
                margin-right: 0;
                margin-bottom: 15px;
                max-width: 100%;
            }

            table th, table td {
                padding: 10px;
            }

            h2 {
                font-size: 2rem;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Completed Orders</h2>

    <div class="nav-buttons">
        <a href="kitchen.jsp" class="link-btn">
            <i class="fas fa-arrow-left"></i> Back to Kitchen
        </a>
    </div>

    <div class="controls">
        <div class="search-box">
            <i class="fas fa-search"></i>
            <input type="text" id="searchInput" placeholder="Search orders..." onkeyup="filterOrders()">
        </div>

        <div class="date-filter">
            <label for="dateFilter"><i class="fas fa-calendar-alt"></i> Filter by:</label>
            <select id="dateFilter" onchange="filterByDate()">
                <option value="all">All Time</option>
                <option value="today">Today</option>
                <option value="yesterday">Yesterday</option>
                <option value="week">This Week</option>
                <option value="month">This Month</option>
            </select>
        </div>
    </div>

    <table id="completedOrdersTable">
        <thead>
        <tr>
            <th>Order ID</th>
            <th>Items</th>
            <th>Completion Date</th>
        </tr>
        </thead>
        <tbody>
        <%
            Connection conn = null;
            boolean hasOrders = false;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/resturent1", "root", "");
                Statement stmt = conn.createStatement();

                // Query completed orders from the complete_orders table
                ResultSet completedRs = stmt.executeQuery(
                        "SELECT co.order_id, co.completion_date FROM complete_orders co ORDER BY co.completion_date DESC");

                while(completedRs.next()) {
                    hasOrders = true;
                    int orderId = completedRs.getInt("order_id");
                    Timestamp completionDate = completedRs.getTimestamp("completion_date");

                    // Fetch order items
                    PreparedStatement pst = conn.prepareStatement(
                            "SELECT oi.quantity, i.name, oi.item_id FROM order_items oi JOIN item i ON oi.item_id = i.id WHERE oi.order_id=?"
                    );
                    pst.setInt(1, orderId);
                    ResultSet itemsRs = pst.executeQuery();
                    StringBuilder itemsStr = new StringBuilder();
                    while(itemsRs.next()) {
                        itemsStr.append("<div class=\"order-item\">")
                                .append("<span class=\"item-id\">ID:").append(itemsRs.getInt("item_id")).append("</span> ")
                                .append("<span class=\"item-name\">").append(itemsRs.getString("name")).append("</span>")
                                .append("<span class=\"item-qty\">x ").append(itemsRs.getInt("quantity")).append("</span>")
                                .append("</div>");
                    }
                    itemsRs.close();
                    pst.close();
        %>
        <tr data-order-id="<%=orderId%>" data-date="<%=completionDate.getTime()%>" class="order-row">
            <td><strong>#<%=orderId%></strong></td>
            <td><%=itemsStr.toString()%></td>
            <td class="timestamp">
                <i class="far fa-calendar-alt"></i> <%=completionDate%>
            </td>
        </tr>
        <%
            }
            completedRs.close();
            stmt.close();

            // If no orders found, display a message
            if (!hasOrders) {
        %>
        <tr id="no-orders-row">
            <td colspan="3" class="empty-state">
                <i class="fas fa-clipboard-check"></i>
                <p>No completed orders found.</p>
                <p>Orders will appear here once they are marked as complete in the kitchen view.</p>
            </td>
        </tr>
        <%
            }
        } catch(Exception e) {
        %>
        <tr>
            <td colspan="3" style="color:red; text-align: center;">
                <i class="fas fa-exclamation-triangle"></i> Database Error: <%=e.getMessage()%>
            </td>
        </tr>
        <%
            } finally {
                if(conn != null) try { conn.close(); } catch(Exception e) {}
            }
        %>
        </tbody>
    </table>
</div>
<script src="js.js"></script>
</body>
</html>