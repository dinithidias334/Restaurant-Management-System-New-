<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Restaurant Dashboard</title>
  <style>
    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      margin: 0;
      padding: 0;
      background-color: #f5f7fa;
    }

    .sidebar {
      width: 250px;
      background-color: #2c3e50;
      height: 100vh;
      position: fixed;
      left: 0;
      top: 0;
      color: white;
      padding-top: 20px;
    }

    .sidebar-header {
      text-align: center;
      padding: 10px;
      border-bottom: 1px solid #405063;
    }

    .sidebar-header h2 {
      margin: 0;
      font-size: 22px;
    }

    .sidebar-menu {
      list-style: none;
      padding: 0;
      margin: 20px 0;
    }

    .sidebar-menu li {
      padding: 10px 20px;
      transition: background-color 0.3s;
    }

    .sidebar-menu li:hover {
      background-color: #34495e;
    }

    .sidebar-menu li.active {
      background-color: #3498db;
    }

    .sidebar-menu a {
      color: white;
      text-decoration: none;
      display: block;
    }

    .content {
      margin-left: 250px;
      padding: 20px;
    }

    .dashboard-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 20px;
    }

    .dashboard-title {
      font-size: 24px;
      color: #2c3e50;
    }

    .date-display                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         