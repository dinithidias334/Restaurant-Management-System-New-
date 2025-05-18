<%@ page import="java.sql.*" %>
<%
    String message = null;
// Handle POST for marking order as complete
    if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("orderId") != null) {
        int completeOrderId = Integer.parseInt(request.getParameter("orderId"));
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/resturent1", "root", "");
            conn.setAutoCommit(false); // Start transaction

            // First check if this order is already in complete_orders to prevent duplicates
            PreparedStatement checkPs = conn.prepareStatement(
                    "SELECT order_id FROM complete_orders WHERE order_id=?"
            );
            checkPs.setInt(1, completeOrderId);
            ResultSet checkRs = checkPs.executeQuery();
            boolean alreadyCompleted = checkRs.next();
            checkRs.close();
            checkPs.close();

            if (!alreadyCompleted) {
                // 1. Update order status
                PreparedStatement updatePs = conn.prepareStatement("UPDATE orders SET status='Complete' WHERE order_id=?");
                updatePs.setInt(1, completeOrderId);
                int rows = updatePs.executeUpdate();

                // 2. Insert into complete_orders table
                if (rows > 0) {
                    PreparedStatement insertPs = conn.prepareStatement("INSERT INTO complete_orders (order_id) VALUES (?)");
                    insertPs.setInt(1, completeOrderId);
                    insertPs.executeUpdate();
                    insertPs.close();
                    message = "Order ID " + completeOrderId + " marked as Complete and saved!";
                }
                updatePs.close();
            }

            conn.commit(); // Commit transaction

          
            response.sendRedirect("kitchen.jsp?success=" + (message != null ? completeOrderId : "false"));
            return; // Stop further execution
        } catch(Exception e) {
            if(conn != null) try { conn.rollback(); } catch(Exception ex) {}
            
            response.sendRedirect("kitchen.jsp?error=" + e.getMessage());
            return; // Stop further execution
        } finally {
            if(conn != null) try {conn.close();} catch(Exception e) {}
        }
    }

// Handle success or error messages from redirects
    if (request.getParameter("success") != null && !"false".equals(request.getParameter("success"))) {
        message = "Order ID " + request.getParameter("success") + " marked as Complete and saved!";
    } else if (request.getParameter("error") != null) {
        message = "Error updating status: " + request.getParameter("error");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Kitchen Orders</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
       
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
            background: linear-gradient(90deg, #3a7bd5, #3a6073);
            border-radius: 2px;
            animation: expandWidth 1.5s ease-out forwards;
        }

        /* Container styles with animation from menu.jsp */
        .container {
            max-width: 1200px;
            margin: 0 auto 60px;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            animation: fadeIn 0.8s ease-out;
            transition: transform 0.3s ease;
            padding: 20px;
        }

        .container:hover {
            transform: translateY(-5px);
        }

        /* Navigation buttons with gradient style from menu.jsp */
        .nav-buttons {
            margin: 15px 0;
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
        }

        .link-btn {
            display: inline-flex;
            align-items: center;
            padding: 10px 20px;
            background: linear-gradient(90deg, #3a7bd5, #3a6073);
            color: white;
            text-decoration: none;
            border-radius: 50px;
            font-weight: 600;
            letter-spacing: 0.5px;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
            box-shadow: 0 4px 15px rgba(58, 123, 213, 0.3);
        }

        .link-btn:hover {
            background: linear-gradient(90deg, #3a6db9, #2d4c5e);
            transform: translateY(-3px);
            box-shadow: 0 6px 18px rgba(58, 123, 213, 0.4);
        }

        .link-btn i {
            margin-right: 8px;
        }

        /* Alert messages with animation */
        .alert {
            padding: 15px 20px;
            margin: 15px 0;
            border-radius: 10px;
            position: relative;
            animation: fadeIn 0.5s;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }

        .success-msg {
            background: linear-gradient(to right, #d4edda, #e8f6ed);
            color: #155724;
            border-left: 4px solid #28a745;
        }

        .error-msg {
            background: linear-gradient(to right, #f8d7da, #feebee);
            color: #721c24;
            border-left: 4px solid #dc3545;
        }

        .close-alert {
            position: absolute;
            right: 10px;
            top: 10px;
            cursor: pointer;
            color: inherit;
            opacity: 0.7;
            transition: all 0.2s ease;
        }

        .close-alert:hover {
            opacity: 1;
            transform: scale(1.1);
        }

        /* Table styling with box shadow and hover effects */
        table {
            border-collapse: collapse;
            width: 100%;
            margin-top: 20px;
            background: white;
            box-shadow: 0 8px 20px rgba(0,0,0,0.08);
            border-radius: 10px;
            overflow: hidden;
        }

        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #eaeaea;
        }

        th {
            background: linear-gradient(90deg, #3a7bd5, #3a6073);
            color: white;
            font-weight: 600;
            position: sticky;
            top: 0;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tr:hover {
            background-color: #f1f5f9;
            transform: translateY(-1px);
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
            transition: all 0.2s ease;
        }

        /* Action button styled like menu.jsp buttons */
        .action-btn {
            padding: 8px 16px;
            background: linear-gradient(90deg, #4CAF50, #45a049);
            color: white;
            border: none;
            border-radius: 50px;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            letter-spacing: 0.5px;
            box-shadow: 0 4px 10px rgba(76, 175, 80, 0.3);
        }

        .action-btn:hover {
            background: linear-gradient(90deg, #43a047, #388e3c);
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(76, 175, 80, 0.4);
        }

        .action-btn i {
            margin-right: 6px;
        }

        /* Order items styling with enhanced visual hierarchy */
        .order-item {
            margin-bottom: 8px;
            padding: 6px 8px;
            border-radius: 6px;
            background-color: #f9f9f9;
            transition: all 0.2s ease;
            border-left: 3px solid #3a7bd5;
        }

        .order-item:hover {
            background-color: #f1f5f9;
            transform: translateX(2px);
        }

        .order-item:last-child {
            margin-bottom: 0;
        }

        .item-id {
            color: #666;
            font-size: 0.85em;
            display: inline-block;
            margin-right: 5px;
        }

        .item-name {
            font-weight: 600;
            color: #333;
        }

        .item-qty {
            background: linear-gradient(90deg, #3a7bd5, #3a6073);
            color: white;
            padding: 2px 8px;
            border-radius: 20px;
            font-weight: 500;
            margin-left: 5px;
            font-size: 0.85em;
            display: inline-block;
        }

        /* Status badges with gradients */
        .status-badge {
            display: inline-block;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 0.85em;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        .status-pending {
            background: linear-gradient(90deg, #ff9800, #ff7800);
            color: white;
        }

        .status-complete {
            background: linear-gradient(90deg, #4CAF50, #45a049);
            color: white;
        }

        /* Auto-refresh countdown */
        .refresh-timer {
            display: flex;
            align-items: center;
            background: linear-gradient(90deg, #f1f3f6, #e4e8f0);
            padding: 8px 15px;
            border-radius: 50px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
            font-size: 0.9em;
            color: #666;
        }

        .refresh-timer i {
            margin-right: 5px;
            color: #3a7bd5;
        }

        .refresh-timer span {
            margin-left: 3px;
            font-weight: bold;
            color: #3a7bd5;
        }

        /* Header container with flex */
        .header-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        /* Empty state styling */
        .empty-state {
            text-align: center;
            padding: 40px 20px;
            color: #666;
            background: linear-gradient(135deg, #f9f9f9, #f1f1f1);
            border-radius: 10px;
            margin: 20px 0;
        }

        .empty-state i {
            font-size: 2.5rem;
            color: #3a7bd5;
            margin-bottom: 15px;
            display: block;
        }

        /* Animations from menu.jsp */
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

        /* Responsive design */
        @media (max-width: 768px) {
            h2 {
                font-size: 2rem;
            }

            .container {
                padding: 15px;
            }

            th, td {
                padding: 10px;
            }

            .action-btn {
                padding: 6px 12px;
                font-size: 0.9em;
            }

            .header-container {
                flex-direction: column;
                gap: 10px;
            }

            .refresh-timer {
                align-self: flex-end;
            }
        }
    </style>
</head>
<body>
<h2>Kitchen Orders</h2>
<div class="container">
    <div class="header-container">
        <div class="refresh-timer">
            <i class="fas fa-sync-alt"></i> Auto refresh in <span id="countdown">60</span>s
        </div>
    </div>

    <% if (message != null) { %>
    <div class="alert success-msg">
        <i class="fas fa-check-circle"></i> <%=message%>
        <span class="close-alert" onclick="this.parentElement.style.display='none';">&times;</span>
    </div>
    <% } %>

    <div class="nav-buttons">
        <a href="completeOrder.jsp" class="link-btn">
            <i class="fas fa-check-double"></i> View Completed Orders
        </a>
        <button class="link-btn" onclick="refreshPage()">
            <i class="fas fa-sync-alt"></i> Refresh Now
        </button>
    </div>

    <table id="ordersTable">
        <thead>
        <tr>
            <th>Order ID</th>
            <th>Items</th>
            <th>Status</th>
            <th>Action</th>
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

                // Only show pending orders in the main view
                ResultSet rs = stmt.executeQuery("SELECT * FROM orders WHERE status='Pending' OR status IS NULL ORDER BY order_id DESC");
                while(rs.next()) {
                    hasOrders = true;
                    int orderId = rs.getInt("order_id");
                    String status = rs.getString("status");
                    if(status == null) status = "Pending"; // Handle NULL status

                    // Fetch order items for this order
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
        <tr id="order-<%=orderId%>">
            <td><strong>#<%=orderId%></strong></td>
            <td><%=itemsStr.toString()%></td>
            <td><span class="status-badge status-<%=status.toLowerCase()%>"><%=status%></span></td>
            <td>
                <% if("Pending".equalsIgnoreCase(status)) { %>
                <form method="post" style="display:inline;" onsubmit="return confirmComplete(<%=orderId%>);">
                    <input type="hidden" name="orderId" value="<%=orderId%>">
                    <button type="submit" class="action-btn">
                        <i class="fas fa-check"></i> Mark Complete
                    </button>
                </form>
                <% } else { %>
                <span><i class="fas fa-check-circle"></i> Complete</span>
                <% } %>
            </td>
        </tr>
        <%
            }
            rs.close();
            stmt.close();

            // If no orders found, display a message
            if (!hasOrders) {
        %>
        <tr>
            <td colspan="4">
                <div class="empty-state">
                    <i class="fas fa-utensils"></i>
                    <p>No pending orders found. All caught up!</p>
                </div>
            </td>
        </tr>
        <%
            }
        } catch(Exception e) {
        %>
        <tr>
            <td colspan="4" style="color:red; text-align: center;">
                <i class="fas fa-exclamation-triangle"></i> Database Error: <%=e.getMessage()%>
            </td>
        </tr>
        <%
            } finally {
                if(conn!=null) try { conn.close(); } catch(Exception e) {}
            }
        %>
        </tbody>
    </table>
</div>

<script>
    // Auto refresh functionality
    let seconds = 60;
    const countdown = document.getElementById('countdown');

    function updateCountdown() {
        countdown.textContent = seconds;
        if (seconds <= 0) {
            refreshPage();
        } else {
            seconds--;
            setTimeout(updateCountdown, 1000);
        }
    }

    function refreshPage() {
        window.location.reload();
    }

    // Confirmation before marking order as complete
    function confirmComplete(orderId) {
        return confirm('Are you sure you want to mark Order #' + orderId + ' as complete?');
    }

    // Highlight newly completed orders
    document.addEventListener('DOMContentLoaded', function() {
        const urlParams = new URLSearchParams(window.location.search);
        const successParam = urlParams.get('success');

        if (successParam && successParam !== 'false') {
            // Scroll to the message
            const successMsg = document.querySelector('.success-msg');
            if (successMsg) {
                successMsg.scrollIntoView({ behavior: 'smooth', block: 'center' });
            }

            // Auto-hide success message after 5 seconds
            setTimeout(function() {
                const alert = document.querySelector('.alert');
                if (alert) {
                    alert.style.opacity = '0';
                    alert.style.transition = 'opacity 0.5s';
                    setTimeout(() => alert.style.display = 'none', 500);
                }
            }, 5000);
        }

        // Start the countdown
        updateCountdown();

        // Add staggered animations to table rows
        const rows = document.querySelectorAll('#ordersTable tbody tr');
        rows.forEach((row, index) => {
            row.style.animation = `fadeIn 0.6s ease-out ${index * 0.1}s forwards`;
            row.style.opacity = '0';
        });
    });
</script>
</body>
</html>