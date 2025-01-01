<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error Page</title>
    <style>
        body {
            font-family:Georgia, serif;
            text-align: center;
            margin-top: 50px;
        }
        .error-message {
            color: red;
            font-size: 18px;
        }
        a {
            text-decoration: none;
            color: blue;
        }
    </style>
</head>
<body>
    <h1>Error Occurred</h1>
    <p class="error-message">${error}</p>
</body>
</html>
