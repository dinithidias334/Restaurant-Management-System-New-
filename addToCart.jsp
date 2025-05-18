
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%@ page import="java.util.*" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    String name = request.getParameter("name");
    int price = Integer.parseInt(request.getParameter("price"));
    int quantity = Integer.parseInt(request.getParameter("quantity"));

    List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("cart");
    if (cart == null) {
        cart = new ArrayList<>();
    }

    boolean found = false;
    for (Map<String, Object> item : cart) {
        if ((int)item.get("id") == id) {

            item.put("quantity", (int)item.get("quantity") + quantity);
            found = true;
            break;
        }
    }
    if (!found) {
        Map<String, Object> cartItem = new HashMap<>();
        cartItem.put("id", id);
        cartItem.put("name", name);
        cartItem.put("price", price);
        cartItem.put("quantity", quantity);
        cart.add(cartItem);
    }
    session.setAttribute("cart", cart);
    response.sendRedirect("menu.jsp"); // Go back to menu
%>

</body>
</html>
