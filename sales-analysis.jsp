<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Restaurant Sales Analysis</title>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        /* sales-analysis.css */

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: #f5f7fa;
            color: #333;
            line-height: 1.6;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        header {
            text-align: center;
            margin-bottom: 30px;
            padding: 20px 0;
            border-bottom: 1px solid #e0e6ed;
        }

        header h1 {
            color: #2c3e50;
            margin-bottom: 10px;
            font-size: 32px;
        }

        .date-display {
            color: #7f8c8d;
            font-size: 14px;
        }

        /* Stats Cards */
        .stats-container {
            display: flex;
            justify-content: space-between;
            margin-bottom: 30px;
            flex-wrap: wrap;
            gap: 20px;
        }

        .stat-card {
            background-color: #fff;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            flex: 1;
            min-width: 200px;
            text-align: center;
            transition: transform 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-5px);
        }

        .stat-card h3 {
            color: #7f8c8d;
            font-size: 16px;
            margin-bottom: 10px;
        }

        .stat-value {
            font-size: 24px;
            font-weight: bold;
            color: #2c3e50;
        }

        /* Charts */
        .charts-container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            margin-bottom: 30px;
        }

        .chart-card {
            background-color: #fff;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            flex: 1;
            min-width: 300px;
        }

        .chart-card h2 {
            color: #2c3e50;
            font-size: 18px;
            margin-bottom: 15px;
            text-align: center;
        }

        .chart-container {
            height: 300px;
            position: relative;
        }

        .full-width {
            flex-basis: 100%;
        }

        /* Table */
        .table-container {
            background-color: #fff;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
        }

        .table-container h2 {
            color: #2c3e50;
            font-size: 18px;
            margin-bottom: 15px;
            text-align: center;
        }

        .data-table {
            width: 100%;
            border-collapse: collapse;
        }

        .data-table th,
        .data-table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #e0e6ed;
        }

        .data-table th {
            background-color: #f8f9fa;
            color: #2c3e50;
            font-weight: 600;
        }

        .data-table tr:hover {
            background-color: #f5f7fa;
        }

        /* Responsive Adjustments */
        @media (max-width: 768px) {
            .stats-container,
            .charts-container {
                flex-direction: column;
            }

            .stat-card,
            .chart-card {
                width: 100%;
            }
        }

        /* Nice animation for chart loading */
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        .chart-container {
            animation: fadeIn 1s ease-in-out;
        }

        /* Add some nice hover effects to table rows */
        .data-table tbody tr {
            transition: background-color 0.3s ease;
        }

        .data-table tbody tr:nth-child(even) {
            background-color: #f8f9fa;
        }
    </style>
</head>
<body>
<div class="container">
    <header>
        <h1>Restaurant Sales Analysis Dashboard</h1>
        <p class="date-display">Data as of <fmt:formatDate pattern="MMMM dd, yyyy" value="<%= new java.util.Date() %>" /></p>
    </header>

    <div class="stats-container">
        <div class="stat-card">
            <h3>Total Sales</h3>
            <p class="stat-value">Rs. <fmt:formatNumber value="${totalSales}" pattern="#,###" /></p>
        </div>
        <div class="stat-card">
            <h3>Total Orders</h3>
            <p class="stat-value">${totalOrders}</p>
        </div>
        <div class="stat-card">
            <h3>Average Order Value</h3>
            <p class="stat-value">Rs. <fmt:formatNumber value="${avgOrderValue}" pattern="#,###.##" /></p>
        </div>
    </div>

    <div class="charts-container">
        <div class="chart-card">
            <h2>Sales by Category</h2>
            <div class="chart-container">
                <canvas id="categoryChart"></canvas>
            </div>
        </div>

        <div class="chart-card">
            <h2>Top Selling Items</h2>
            <div class="chart-container">
                <canvas id="itemsChart"></canvas>
            </div>
        </div>

        <div class="chart-card full-width">
            <h2>Sales Trend (Last 7 Days)</h2>
            <div class="chart-container">
                <canvas id="salesTrendChart"></canvas>
            </div>
        </div>
    </div>

    <div class="table-container">
        <h2>Top Selling Items Details</h2>
        <table class="data-table">
            <thead>
            <tr>
                <th>Item</th>
                <th>Category</th>
                <th>Quantity Sold</th>
                <th>Total Sales</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${topSellingItems}" var="item">
                <tr>
                    <td>${item.name}</td>
                    <td>${item.category}</td>
                    <td>${item.quantity}</td>
                    <td>Rs. <fmt:formatNumber value="${item.sales}" pattern="#,###" /></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<script>
    // Sales by Category Chart
    const categoryData = {
        labels: [
            <c:forEach items="${salesByCategory}" var="category" varStatus="status">
            '${category.key}'<c:if test="${!status.last}">,</c:if>
            </c:forEach>
        ],
        datasets: [{
            data: [
                <c:forEach items="${salesByCategory}" var="category" varStatus="status">
                ${category.value}<c:if test="${!status.last}">,</c:if>
                </c:forEach>
            ],
            backgroundColor: [
                '#FF6384', '#36A2EB', '#FFCE56', '#4BC0C0', '#9966FF', '#FF9F40', '#8AC249'
            ]
        }]
    };

    const categoryChart = new Chart(document.getElementById('categoryChart'), {
        type: 'pie',
        data: categoryData,
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    position: 'right'
                },
                tooltip: {
                    callbacks: {
                        label: function(context) {
                            let label = context.label || '';
                            let value = context.parsed || 0;
                            return label + ': Rs. ' + value.toLocaleString();
                        }
                    }
                }
            }
        }
    });

    // Top Selling Items Chart
    const itemsData = {
        labels: [
            <c:forEach items="${topSellingItems}" var="item" varStatus="status">
            '${item.name}'<c:if test="${!status.last}">,</c:if>
            </c:forEach>
        ],
        datasets: [{
            data: [
                <c:forEach items="${topSellingItems}" var="item" varStatus="status">
                ${item.quantity}<c:if test="${!status.last}">,</c:if>
                </c:forEach>
            ],
            backgroundColor: [
                '#FF6384', '#36A2EB', '#FFCE56', '#4BC0C0', '#9966FF'
            ]
        }]
    };

    const itemsChart = new Chart(document.getElementById('itemsChart'), {
        type: 'pie',
        data: itemsData,
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    position: 'right'
                },
                tooltip: {
                    callbacks: {
                        label: function(context) {
                            let label = context.label || '';
                            let value = context.parsed || 0;
                            return label + ': ' + value + ' units';
                        }
                    }
                }
            }
        }
    });

    // Sales Trend Chart
    const salesTrendData = {
        labels: [
            <c:forEach items="${salesByDate}" var="entry" varStatus="status">
            '${entry.key}'<c:if test="${!status.last}">,</c:if>
            </c:forEach>
        ],
        datasets: [{
            label: 'Daily Sales',
            data: [
                <c:forEach items="${salesByDate}" var="entry" varStatus="status">
                ${entry.value}<c:if test="${!status.last}">,</c:if>
                </c:forEach>
            ],
            fill: false,
            borderColor: '#36A2EB',
            tension: 0.1
        }]
    };

    const salesTrendChart = new Chart(document.getElementById('salesTrendChart'), {
        type: 'line',
        data: salesTrendData,
        options: {
            responsive: true,
            maintainAspectRatio: false,
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: {
                        callback: function(value) {
                            return 'Rs. ' + value.toLocaleString();
                        }
                    }
                }
            },
            plugins: {
                tooltip: {
                    callbacks: {
                        label: function(context) {
                            let label = context.dataset.label || '';
                            let value = context.parsed.y || 0;
                            return label + ': Rs. ' + value.toLocaleString();
                        }
                    }
                }
            }
        }
    });
</script>
</body>
</html>