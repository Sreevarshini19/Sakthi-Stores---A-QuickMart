<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Login</title>
    <style>
        /* Body and Background */
        body {
            font-family: Georgia, serif;
            margin: 0;
            padding: 0;
          /*  background: url('https://plus.unsplash.com/premium_photo-1664476845274-27c2dabdd7f0?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8c3RvY2slMjBtYXJrZXR8ZW58MHx8MHx8fDA%3D') no-repeat center center fixed;
            */
            background: url('data:image/jpeg;base64,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');
            background-size: cover;
            backdrop-filter: blur(3px) brightness(0.9); /* Backdrop filter for blending */
            color: #333;
            height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }

        /* Header */
        #header {
            background: rgba(255, 255, 255, 0.8); /* Full-length header background with slight transparency */
            color: #d35400; /* Burnt orange for the store name */
            /*color: #006400;*/
            padding: 20px;
            font-size: 32px;
            font-weight: bold;
            letter-spacing: 1.5px;
            border-radius: 15px;
            width: 100%;
            max-width: 1000px;
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.2);
            display: flex;
            flex-direction: row;
            align-items: center;
            justify-content: space-between;
        }

        #header img {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            margin:5px;
        }

        h2 {
            margin: 0;
            text-align: center;
            flex-grow: 1; /* Makes the text centered */
        }

        /* Navigation Buttons */
        #navigation {
            text-align: center;
            margin: 20px 0;
        }

        #navigation button {
            margin: 10px;
            padding: 15px 30px;
            font-size: 20px;
            border: none;
            background: linear-gradient(135deg, #f39c12, #e67e22); /* Orange/yellow gradient */
         /*   background: #006400;*/
            color: white;
            cursor: pointer;
            border-radius: 30px;
            font-weight: bold;
            letter-spacing: 1px;
            box-shadow: 0px 6px 12px rgba(0, 0, 0, 0.4);
            transition: all 0.3s ease-in-out;
        }

        #navigation button:hover {
            transform: scale(1.1);
            background: linear-gradient(135deg, #f1c40f, #e74c3c); /* Brighter gradients for hover effect */
        }

        /* Section Styling */
        .section {
            display: none;
            background: rgba(255, 255, 255, 0.8); /* Translucent background with blur */
            border-radius: 15px;
            max-width: 500px;
            margin: 20px auto;
            padding: 40px 30px;
            box-shadow: 0px 10px 20px rgba(0, 0, 0, 0.5);
            animation: fadeIn 0.5s ease-in-out;
        }

        .section.active {
            display: block;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Input Fields */
        input[type="text"], input[type="password"] {
            width: 90%;
            padding: 12px 15px;
            margin: 10px auto 20px;
            border: 1px solid rgba(0, 0, 0, 0.2);
            border-radius: 10px;
            background: rgba(255, 255, 255, 0.6);
            color: #2c3e50;
            box-shadow: inset 0px 2px 5px rgba(0, 0, 0, 0.1);
            font-size: 16px;
            outline: none;
        }

        input[type="text"]::placeholder, input[type="password"]::placeholder {
            color: rgba(44, 62, 80, 0.7);
        }

        /* Buttons Inside Forms */
        button[type="submit"] {
            width: 90%;
            padding: 12px;
            font-size: 18px;
            background: linear-gradient(135deg, #e74c3c, #c0392b);
            color: white;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            box-shadow: 0px 6px 10px rgba(0, 0, 0, 0.3);
            font-weight: bold;
            letter-spacing: 1px;
            transition: all 0.3s ease-in-out;
        }

        button[type="submit"]:hover {
            transform: scale(1.05);
            background: linear-gradient(135deg, #f39c12, #e74c3c);
        }

        /* About Section Text */
        #about-us p {
            font-size: 18px;
            line-height: 1.6;
        }

        .error {
            color: red;
        }

        .img {
            width: 70px;
            height: 70px;
            visibility: visible;
            border-radius: 50px;
        }
    </style>
    <script>
        function showSection(sectionId) {
            const sections = document.querySelectorAll('.section');
            sections.forEach(section => section.classList.remove('active'));

            const targetSection = document.getElementById(sectionId);
            if (targetSection) {
                targetSection.classList.add('active');
            }
        }
    </script>
</head>
<body>
    <div id="header">
        <img class="img" src="SakthiStores_edit.png" alt="Sakthi Stores Logo"/>
        <h2>SAKTHI STORES</h2>
    </div>

    <div id="navigation">
        <button onclick="showSection('customer-login')">Customer Login</button>
        <button onclick="showSection('admin-login')">Admin Login</button>
        <button onclick="showSection('about-us')">About Us</button>
    </div>

    <div id="customer-login" class="section active">
        <h3>Customer Login</h3>
        <form method="post" action="AddCustomer">
            <label>Phone Number:</label>
            <input type="text" name="phoneNum" placeholder="Enter phone number" required />
            <button type="submit">Login</button>
        </form>
    </div>

    <div id="admin-login" class="section">
        <h3>Admin Login</h3>
        <form method="post" action="checkAdmin">
            <label for="adminName">Username:</label>
            <input type="text" id="adminName" name="adminName" placeholder="Enter username" required />
            <label for="adminPassword">Password:</label>
            <input type="password" id="adminPassword" name="adminPassword" placeholder="Enter password" required />
            <button type="submit">Login</button>
        </form>
    </div>
    <div id="about-us" class="section">
        <h3>About Us</h3>
        <p>
            Welcome to Sakthi Stores, your trusted partner in managing and organizing stock efficiently. 
            We ensure seamless operations with innovative solutions tailored for your business needs.
        </p>
    </div>
</body>
</html>
