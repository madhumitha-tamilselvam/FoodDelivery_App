<!DOCTYPE html>
<html>
<head>
    <title>Register | Food Delivery</title>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

    <style>
        body {
            margin: 0;
            font-family: 'Poppins', sans-serif;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;

            /* Background Image */
            background: url("https://images.unsplash.com/photo-1504674900247-0877df9cc836") 
                        no-repeat center center/cover;
        }

        /* Dark Overlay */
        .overlay {
            position: absolute;
            height: 100%;
            width: 100%;
            background: rgba(0,0,0,0.4);
            backdrop-filter: blur(3px);
        }

        /* Glass Box */
        .box {
            position: relative;
            z-index: 5;
            width: 420px;
            padding: 35px;
            border-radius: 20px;

            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(12px);
            border: 1px solid rgba(255, 255, 255, 0.3);

            box-shadow: 0 8px 25px rgba(0,0,0,0.3);
            text-align: center;
            color: white;
        }

        h2 {
            margin-bottom: 10px;
            font-weight: 600;
        }

        input {
            width: 100%;
            padding: 12px;
            margin-top: 15px;
            border-radius: 10px;
            border: none;
            outline: none;
            background: rgba(255,255,255,0.8);
            font-size: 15px;
        }

        button {
            width: 100%;
            padding: 14px;
            margin-top: 20px;

            background: linear-gradient(135deg, #7f00ff, #e100ff);
            color: white;
            border: none;
            border-radius: 10px;
            font-weight: 600;
            cursor: pointer;
            font-size: 16px;

            transition: 0.3s;
        }

        button:hover {
            transform: scale(1.05);
            box-shadow: 0 5px 18px rgba(147, 0, 255, 0.6);
        }

        a {
            color: #ffe9ff;
            font-weight: bold;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }

    </style>
</head>
<body>

<div class="overlay"></div>

<div class="box">
    <h2>Create Account</h2>
    <p>Join our food delivery family! 🍕</p>

    <form action="RegisterServlet" method="post">

        <input type="text" name="name" placeholder="Full Name" required>
        <input type="text" name="username" placeholder="Username" required>
        <input type="password" name="password" placeholder="Password" required>
        <input type="email" name="email" placeholder="Email" required>
        <input type="text" name="phone" placeholder="Phone Number" required>
        <input type="text" name="address" placeholder="Address" required>

        <button type="submit">Register</button>
    </form>

    <p style="margin-top: 15px;">
        Already have an account? <a href="Login.jsp">Login</a>
    </p>
</div>

</body>
</html>
