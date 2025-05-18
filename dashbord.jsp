<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap');

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', Arial, sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            padding: 0;
            margin: 0;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            overflow-x: hidden;
        }

        .header {
            width: 100%;
            padding: 2rem 0;
            text-align: center;
            position: relative;
            animation: fadeInDown 1s ease-out forwards;
        }

        h1 {
            margin-bottom: 1rem;
            font-size: 3em;
            color: #3b82f6;
            letter-spacing: 2px;
            font-weight: 700;
            text-shadow: 0 4px 15px rgba(59, 130, 246, 0.15);
            position: relative;
            display: inline-block;
        }

        h1::after {
            content: '';
            position: absolute;
            width: 60%;
            height: 4px;
            background: linear-gradient(90deg, #3b82f6, #10b981);
            bottom: -8px;
            left: 50%;
            transform: translateX(-50%) scaleX(0);
            animation: underlineExpand 1.5s 0.5s ease forwards;
            border-radius: 2px;
        }

        .dashboard-container {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 2.5rem;
            width: 90%;
            max-width: 1200px;
            padding: 2rem 0;
            perspective: 1000px;
        }

        .card {
            background: rgba(255, 255, 255, 0.9);
            width: 260px;
            height: 200px;
            border-radius: 24px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.08);
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            font-size: 1.25em;
            font-weight: 600;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            text-decoration: none;
            color: #334155;
            position: relative;
            overflow: hidden;
            animation: cardEntrance 0.8s cubic-bezier(0.21, 1.02, 0.73, 1) forwards;
            opacity: 0;
            transform: translateY(40px) rotateX(10deg);
            backdrop-filter: blur(10px);
            border: 2px solid rgba(255, 255, 255, 0.1);
        }

        .card:nth-child(1) { animation-delay: 0.1s; }
        .card:nth-child(2) { animation-delay: 0.2s; }
        .card:nth-child(3) { animation-delay: 0.3s; }
        .card:nth-child(4) { animation-delay: 0.4s; }
        .card:nth-child(5) { animation-delay: 0.5s; }

        .card::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(
                    90deg,
                    transparent,
                    rgba(255, 255, 255, 0.2),
                    transparent
            );
            transition: 0.5s;
        }

        .card:hover::before {
            left: 100%;
            transition: 0.5s;
        }

        .card::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 5px;
            background: linear-gradient(90deg, #3b82f6, #10b981);
            transform: scaleX(0);
            transform-origin: left;
            transition: transform 0.5s cubic-bezier(0.645, 0.045, 0.355, 1);
        }

        .card:hover::after {
            transform: scaleX(1);
        }

        .card:hover {
            transform: translateY(-15px) scale(1.05);
            box-shadow: 0 15px 35px rgba(59, 130, 246, 0.2);
            background: linear-gradient(135deg, #3b82f6, #10b981);
            color: white;
        }

        .card i {
            font-size: 2.5em;
            margin-bottom: 1.25rem;
            color: #3b82f6;
            transition: all 0.4s ease;
        }

        .card:hover i {
            color: white;
            transform: scale(1.2) rotate(360deg);
        }

        .card-content {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            z-index: 1;
            transition: transform 0.3s ease;
        }

        .card:hover .card-content {
            transform: scale(1.05);
        }

        .background-shapes {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
            overflow: hidden;
        }

        .shape {
            position: absolute;
            opacity: 0.3;
            filter: blur(60px);
            animation: float 15s infinite ease-in-out;
        }

        .shape-1 {
            background: #3b82f6;
            width: 300px;
            height: 300px;
            border-radius: 50%;
            top: -100px;
            left: -100px;
            animation-delay: 0s;
        }

        .shape-2 {
            background: #10b981;
            width: 250px;
            height: 250px;
            border-radius: 50%;
            bottom: -50px;
            right: -50px;
            animation-delay: 5s;
        }

        .shape-3 {
            background: #6366f1;
            width: 200px;
            height: 200px;
            border-radius: 30% 70% 70% 30% / 30% 30% 70% 70%;
            top: 40%;
            right: 20%;
            animation-delay: 2.5s;
        }

        .shape-4 {
            background: #f59e0b;
            width: 150px;
            height: 150px;
            border-radius: 30% 70% 70% 30% / 30% 30% 70% 70%;
            bottom: 20%;
            left: 15%;
            animation-delay: 7.5s;
        }

        .logout-btn {
            position: relative;
            overflow: hidden;
        }

        .logout-btn i {
            margin-right: 0.5rem;
            transition: transform 0.3s ease;
        }

        .logout-btn:hover i {
            animation: pulse 1.5s infinite;
        }

        @keyframes float {
            0% {
                transform: translateY(0) rotate(0deg);
            }
            50% {
                transform: translateY(-40px) rotate(180deg);
            }
            100% {
                transform: translateY(0) rotate(360deg);
            }
        }

        @keyframes fadeInDown {
            from {
                opacity: 0;
                transform: translateY(-30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes cardEntrance {
            from {
                opacity: 0;
                transform: translateY(40px) rotateX(10deg);
            }
            to {
                opacity: 1;
                transform: translateY(0) rotateX(0);
            }
        }

        @keyframes underlineExpand {
            from {
                transform: translateX(-50%) scaleX(0);
            }
            to {
                transform: translateX(-50%) scaleX(1);
            }
        }

        @keyframes pulse {
            0% {
                transform: scale(1);
            }
            50% {
                transform: scale(1.2);
            }
            100% {
                transform: scale(1);
            }
        }

        @media (max-width: 900px) {
            .dashboard-container {
                gap: 1.5rem;
            }
            .card {
                width: 90%;
                max-width: 320px;
                height: 180px;
            }
            h1 {
                font-size: 2.5em;
            }
        }
    </style>
</head>
<body>
<div class="background-shapes">
    <div class="shape shape-1"></div>
    <div class="shape shape-2"></div>
    <div class="shape shape-3"></div>
    <div class="shape shape-4"></div>
</div>

<div class="header">
    <h1>Admin Dashboard</h1>
</div>

<div class="dashboard-container">
    <a href="employee.jsp" class="card">
        <div class="card-content">
            <i class="fas fa-users"></i>
            <span>Manage Employees</span>
        </div>
    </a>

    <a href="item.jsp" class="card">
        <div class="card-content">
            <i class="fas fa-utensils"></i>
            <span>Edit & View Food</span>
        </div>
    </a>

    <a href="completeOrder.jsp" class="card">
        <div class="card-content">
            <i class="fas fa-shopping-cart"></i>
            <span>Orders View</span>
        </div>
    </a>

    <a href="kitchen.jsp" class="card">
        <div class="card-content">
            <i class="fas fa-bell"></i>
            <span>Current Orders</span>
        </div>
    </a>

    <a href="logout" class="card logout-btn">
        <div class="card-content">
            <i class="fas fa-sign-out-alt"></i>
            <span>Logout</span>
        </div>
    </a>
</div>
</body>
</html>