<%@ page import="com.resturent.model.items" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<html>
<head>
    <title>Menu</title>

    <script src="js.js" defer></script>
    <style>
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: #f6f7fb;
            margin: 0;
            padding: 0;
        }

        h1, h2 {
            color: #2c3e50;
            text-align: center;
            margin-top: 30px;
        }

        .add-form, .error-message {
            max-width: 500px;
            margin: 30px auto 20px auto;
            background: #fff;
            padding: 24px 28px;
            border-radius: 12px;
            box-shadow: 0 2px 12px rgba(44, 62, 80, 0.07);
        }

        .add-form input[type="text"],
        .add-form input[type="number"],
        .add-form select,
        .add-form input[type="file"] {
            width: 100%;
            padding: 12px 10px;
            margin-bottom: 14px;
            border: 1px solid #dbe2ef;
            border-radius: 5px;
            font-size: 1em;
            background: #f9fafc;
            transition: border 0.2s;
        }

        .add-form input[type="text"]:focus,
        .add-form input[type="number"]:focus,
        .add-form select:focus {
            border: 1.5px solid #4ecca3;
            outline: none;
        }

        .add-form input[type="submit"] {
            background: linear-gradient(90deg, #4ecca3 0%, #393e46 100%);
            color: #fff;
            border: none;
            padding: 12px 0;
            width: 100%;
            border-radius: 5px;
            font-size: 1.1em;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.2s;
        }

        .add-form input[type="submit"]:hover {
            background: linear-gradient(90deg, #393e46 0%, #4ecca3 100%);
        }

        .error-message {
            color: #b80000;
            background: #ffeaea;
            border-left: 4px solid #b80000;
            font-weight: 500;
            margin-bottom: 20px;
        }

        table {
            width: 95%;
            margin: 40px auto 0 auto;
            border-collapse: collapse;
            background: #fff;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 2px 12px rgba(44, 62, 80, 0.07);
        }

        th, td {
            padding: 14px 18px;
            text-align: center;
            border-bottom: 1px solid #f0f0f0;
        }

        th {
            background: #4ecca3;
            color: #fff;
            font-size: 1.08em;
            letter-spacing: 0.02em;
        }

        tr:last-child td {
            border-bottom: none;
        }

        .item-image {
            width: 70px;
            height: 70px;
            object-fit: cover;
            border-radius: 8px;
            border: 1px solid #e0e0e0;
            box-shadow: 0 1px 5px rgba(44, 62, 80, 0.04);
        }

        .no-image {
            color: #aaa;
            font-style: italic;
            font-size: 0.95em;
        }

        .action-form {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .action-form form {
            display: flex;
            gap: 5px;
            align-items: center;
            justify-content: center;
        }

        .action-form input[type="text"],
        .action-form input[type="number"],
        .action-form select {
            width: 90px;
            padding: 6px;
            font-size: 0.95em;
        }

        .action-form input[type="submit"], .delete-button {
            background: #393e46;
            color: #fff;
            border: none;
            padding: 7px 14px;
            border-radius: 4px;
            font-size: 0.98em;
            cursor: pointer;
            transition: background 0.2s;
        }

        .action-form input[type="submit"]:hover {
            background: #4ecca3;
        }

        .delete-button {
            background: #b80000;
        }

        .delete-button:hover {
            background: #ff3c3c;
        }

        @media (max-width: 700px) {
            .add-form, .error-message, table {
                width: 98%;
                padding: 10px;
            }
            th, td {
                padding: 8px 5px;
                font-size: 0.97em;
            }
            .item-image {
                width: 50px;
                height: 50px;
            }
        }

    </style>
</head>
<body>

<h1>ADD NEW ITEM</h1>

<%-- Error Message --%>
<% if (request.getAttribute("error") != null) { %>
<div class="error-message">
    <%= request.getAttribute("error") %>
</div>
<% } %>

<%-- Add Item Form --%>
<div class="add-form">
    <form action="menu" method="post" enctype="multipart/form-data">
        <input type="hidden" name="action" value="add">
        <input type="text" name="name" placeholder="Item Name" required>
        <input type="number" name="price" step="0.01" min="0" placeholder="Price" required>
        <select name="category" required>
            <option value="KOTTU">KOTTU</option>
            <option value="RICE">RICE</option>
            <option value="NOODLESS">NOODLESS</option>
            <option value="SOFTDRINK">SOFTDRINKS</option>
        </select>
        <input type="file" name="image" accept="image/*">
        <input type="submit" value="Add Item">
    </form>
</div>

<h2>RICE TYPES</h2>

<%
    List<items> itemsList = (List<items>) request.getAttribute("item");
    if (itemsList == null) {
        itemsList = new ArrayList<>();
    }
%>

<% if (itemsList.isEmpty()) { %>
<div class="error-message">No menu items found.</div>
<% } else { %>
<table>
    <thead>
    <tr>
        <th>Image</th>
        <th>ID</th>
        <th>Name</th>
        <th>Price ($)</th>
        <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <% for (items item : itemsList) { %>
    <tr>
        <td>
            <% if (item.getImage() != null && !item.getImage().isEmpty()) { %>
            <img src="${pageContext.request.contextPath}/<%= item.getImage() %>" alt="Item Image" class="item-image">
            <% } else { %>
            <div class="no-image">No Image</div>
            <% } %>
        </td>
        <td><%= item.getId() %></td>
        <td><%= item.getName() %></td>
        <td><%= String.format("%.2f", item.getPrice()) %></td>
        <td>
            <div class="action-form">
                <%-- Update Form --%>
                <form action="menu" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="action" value="edit">
                    <input type="hidden" name="id" value="<%= item.getId() %>">
                    <input type="text" name="name" value="<%= item.getName() %>" required>
                    <input type="number" name="price" step="0.01" min="0" value="<%= item.getPrice() %>" required>

                    <%-- Keep current image path in hidden field --%>
                    <input type="hidden" name="currentImage" value="<%= item.getImage() %>">

                    <%-- File input to upload new image (optional) --%>
                    <input type="file" name="image" accept="image/*">

                    <%-- Category select --%>
                    <select name="category" required>
                        <option value="KOTTU" <%= "KOTTU".equals(item.getCategory()) ? "selected" : "" %>>KOTTU</option>
                        <option value="RICE" <%= "RICE".equals(item.getCategory()) ? "selected" : "" %>>RICE</option>
                        <option value="NOODLESS" <%= "NOODLESS".equals(item.getCategory()) ? "selected" : "" %>>NOODLESS</option>
                        <option value="SOFTDRINK" <%= "SOFTDRINK".equals(item.getCategory()) ? "selected" : "" %>>SOFTDRINK</option>
                    </select>

                    <input type="submit" value="Update">
                </form>

                <%-- Delete Form --%>
                <form action="menu" method="post">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="id" value="<%= item.getId() %>">
                    <input type="submit" value="Delete" class="delete-button">
                </form>
            </div>
        </td>
    </tr>
    <% } %>
    </tbody>
</table>
<% } %>

</body>
</html>