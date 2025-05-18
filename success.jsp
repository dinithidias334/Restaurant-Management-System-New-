<html>
<head>
    <title>Order Confirmation</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Segoe+UI:wght@300;400;500;600;700&display=swap');

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background: linear-gradient(135deg, #f6f7fb 0%, #e9f7ef 100%);
            min-height: 100vh;
            margin: 0;
            padding: 20px;
            font-family: 'Segoe UI', Arial, sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            overflow-x: hidden;
        }

        /* Floating particles animation from previous design */
        body::before,
        body::after {
            content: '';
            position: fixed;
            width: 250px;
            height: 250px;
            border-radius: 50%;
            background: linear-gradient(45deg, rgba(0, 123, 255, 0.08), rgba(78, 204, 163, 0.08));
            filter: blur(40px);
            z-index: -1;
            animation: float 15s infinite linear alternate;
        }

        body::before {
            top: -100px;
            left: -100px;
            animation-delay: 0s;
        }

        body::after {
            bottom: -100px;
            right: -100px;
            animation-delay: -7.5s;
        }

        @keyframes float {
            0% {
                transform: translate(0, 0) scale(1);
            }
            25% {
                transform: translate(100px, 50px) scale(1.1);
            }
            50% {
                transform: translate(50px, 100px) scale(0.9);
            }
            75% {
                transform: translate(-50px, 50px) scale(1.2);
            }
            100% {
                transform: translate(0, 0) scale(1);
            }
        }

        .confirmation-container {
            background: #fff;
            border-radius: 18px;
            box-shadow: 0 8px 32px rgba(44, 62, 80, 0.08), 0 1.5px 6px rgba(44,62,80,0.04);
            padding: 40px 32px 32px 32px;
            max-width: 400px;
            width: 100%;
            text-align: center;
            animation: pop-in 0.7s cubic-bezier(.21,1.02,.73,1) 1;
            position: relative;
            overflow: hidden;
            transform-style: preserve-3d;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .confirmation-container:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 40px rgba(44, 62, 80, 0.15);
        }

        /* Enhanced pop-in animation */
        @keyframes pop-in {
            0% { transform: scale(0.8) translateY(40px) rotateX(5deg); opacity: 0; }
            50% { transform: scale(1.03) translateY(-10px) rotateX(0); opacity: 1; }
            100% { transform: scale(1) translateY(0) rotateX(0); opacity: 1; }
        }

        /* Glow effect on hover */
        .confirmation-container::before {
            content: '';
            position: absolute;
            top: -5px;
            left: -5px;
            right: -5px;
            bottom: -5px;
            background: linear-gradient(90deg, #007BFF, #4ecca3, #007BFF);
            z-index: -1;
            border-radius: 22px;
            opacity: 0;
            transition: opacity 0.3s ease;
            animation: border-glow 3s infinite alternate;
            filter: blur(12px);
        }

        .confirmation-container:hover::before {
            opacity: 0.5;
        }

        @keyframes border-glow {
            0% {
                opacity: 0.2;
                filter: blur(15px);
            }
            100% {
                opacity: 0.4;
                filter: blur(10px);
            }
        }

        .bill-image {
            width: 160px;
            margin-bottom: 22px;
            border-radius: 12px;
            box-shadow: 0 4px 16px rgba(44,62,80,0.09);
            background: #f8f9fa;
            animation: image-appear 1s ease forwards;
            animation-delay: 0.3s;
            opacity: 0;
            transform: translateY(20px);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .bill-image:hover {
            transform: scale(1.05);
            box-shadow: 0 8px 24px rgba(44,62,80,0.18);
        }

        @keyframes image-appear {
            0% {
                opacity: 0;
                transform: translateY(20px);
            }
            100% {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .success-message {
            font-size: 1.7em;
            color: #28a745;
            font-weight: 600;
            margin-bottom: 12px;
            letter-spacing: 0.01em;
            position: relative;
            animation: message-appear 1s ease forwards;
            animation-delay: 0.5s;
            opacity: 0;
        }

        @keyframes message-appear {
            0% {
                opacity: 0;
                transform: translateY(15px);
            }
            100% {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Message underline animation */
        .success-message::after {
            content: '';
            position: absolute;
            bottom: -8px;
            left: 50%;
            transform: translateX(-50%);
            width: 60px;
            height: 3px;
            background: linear-gradient(90deg, #28a745, #4ecca3);
            border-radius: 2px;
            animation: underline-expand 1s ease forwards;
            animation-delay: 0.8s;
            transform-origin: center;
            opacity: 0;
        }

        @keyframes underline-expand {
            0% {
                width: 0;
                opacity: 0;
            }
            100% {
                width: 60px;
                opacity: 1;
            }
        }

        .order-details {
            background: #f6f7fb;
            border-radius: 8px;
            padding: 14px 12px;
            margin: 18px 0 8px 0;
            color: #333;
            font-size: 1.05em;
            box-shadow: 0 1px 3px rgba(44,62,80,0.03);
            animation: details-appear 1s ease forwards;
            animation-delay: 0.7s;
            opacity: 0;
            transform: translateY(10px);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .order-details:hover {
            transform: translateY(-2px);
            box-shadow: 0 3px 8px rgba(44,62,80,0.1);
        }

        @keyframes details-appear {
            0% {
                opacity: 0;
                transform: translateY(10px);
            }
            100% {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .continue-link {
            display: inline-block;
            margin-top: 28px;
            padding: 13px 36px;
            background: linear-gradient(90deg, #007bff 0%, #4ecca3 100%);
            color: #fff;
            text-decoration: none;
            border-radius: 7px;
            font-size: 1.12em;
            font-weight: 500;
            box-shadow: 0 2px 8px rgba(44,62,80,0.09);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            animation: button-appear 1s ease forwards;
            animation-delay: 0.9s;
            opacity: 0;
        }

        @keyframes button-appear {
            0% {
                opacity: 0;
                transform: translateY(15px);
            }
            100% {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Button shine effect */
        .continue-link::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
            transition: all 0.6s ease;
        }

        .continue-link:hover {
            background: linear-gradient(90deg, #4ecca3 0%, #007bff 100%);
            box-shadow: 0 4px 16px rgba(44,62,80,0.13);
            transform: translateY(-2px) scale(1.03);
        }

        .continue-link:hover::before {
            left: 100%;
        }

        .continue-link:active {
            transform: translateY(1px);
            box-shadow: 0 2px 8px rgba(44,62,80,0.09);
        }

        /* Additional pulse animation for success effect */
        .pulse {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 30px;
            height: 30px;
            border-radius: 50%;
            background: rgba(40, 167, 69, 0.6);
            animation: pulse 2s infinite;
            opacity: 0;
            z-index: -1;
        }

        @keyframes pulse {
            0% {
                transform: translate(-50%, -50%) scale(0);
                opacity: 1;
            }
            100% {
                transform: translate(-50%, -50%) scale(10);
                opacity: 0;
            }
        }

        /* Checkmark animation */
        .checkmark {
            position: absolute;
            top: 15px;
            right: 15px;
            width: 25px;
            height: 25px;
            transform: scale(0);
            animation: checkmark-appear 0.5s cubic-bezier(.21,1.02,.73,1) forwards;
            animation-delay: 1s;
        }

        @keyframes checkmark-appear {
            0% {
                transform: scale(0) rotate(-45deg);
            }
            50% {
                transform: scale(1.2) rotate(0deg);
            }
            100% {
                transform: scale(1) rotate(0deg);
            }
        }

        .checkmark::before,
        .checkmark::after {
            content: '';
            position: absolute;
            background-color: #28a745;
            border-radius: 2px;
        }

        .checkmark::before {
            width: 3px;
            height: 9px;
            left: 6px;
            top: 11px;
            transform: rotate(-45deg);
        }

        .checkmark::after {
            width: 3px;
            height: 15px;
            left: 14px;
            top: 5px;
            transform: rotate(45deg);
        }

        @media (max-width: 600px) {
            .confirmation-container {
                padding: 24px 16px 22px 16px;
                max-width: 92vw;
            }
            .bill-image {
                width: 120px;
            }
            .success-message {
                font-size: 1.4em;
            }
            .continue-link {
                padding: 12px 30px;
                font-size: 1em;
            }
        }
    </style>
</head>
<body>
<div class="confirmation-container">
    <div class="checkmark"></div>
    <div class="pulse"></div>
    <img class="bill-image" src="https://img.freepik.com/free-vector/invoice-concept-illustration_114360-2143.jpg" alt="Order Bill/Receipt"/>
    <div class="success-message">Your order has been placed successfully!</div>
    <!-- Optional: Add order details here -->
    <div class="order-details">

        Estimated delivery: 30 minutes
    </div>
    <a class="continue-link" href="menu.jsp">Continue Shopping</a>
</div>
</body>
</html>