<#ftl encoding='UTF-8'>
<html>
<head>
    <title>Авторирація</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        *,
        *:before,
        *:after{
            padding: 0;
            border: 0;
            box-sizing: border-box;
        }
        body {
            font-family: Arial, Helvetica, sans-serif;
        }

        * {
            box-sizing: border-box;
        }

        /* Add padding to containers */
        .container {
            padding: 9px 12px;
            background-color: white;
        }

        /* Full-width input fields */
        input[type=text], input[type=password] {
            width: 100%;
            padding: 15px;
            margin: 5px 0 22px 0;
            display: inline-block;
            border: none;
            background: #f1f1f1;
        }

        input[type=text]:focus, input[type=password]:focus {
            background-color: #ddd;
            outline: none;
        }

        /* Overwrite default styles of hr */
        hr {
            border: 1px solid #f1f1f1;
            margin-bottom: 12px;
        }

        /* Set a style for the submit button */
        .registerbtn {
            background-color: #4C587D;
            color: white;
            padding: 16px 18px;
            margin: 8px 0;
            border: none;
            cursor: pointer;
            width: 100%;
            opacity: 0.9;
        }

        .registerbtn:hover {
            opacity: 1;
        }

        /* Add a blue text color to links */
        a {
            color: dodgerblue;
        }

        /* Set a grey background color and center the text of the "sign in" section */
        .signin {
            background-color: #f1f1f1;
            text-align: center;
        }
    </style>
</head>
<body>

<form action="/login" method="post">
    <div class="container">
        <h1>Авторизація</h1>
        <p>Будь-ласка введіть дані для авторизації у сервісі.</p>
        <hr>

        <#if error??>
            <div class="errorMessage">${error}</div>
            <hr>
        </#if>

        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

        <label for="email"><b>Email</b></label>
        <input type="text" placeholder="Enter Email" name="username" required>

        <label for="password"><b>Пароль</b></label>
        <input type="password" placeholder="Enter Password" name="password" required>

        <hr>
        <p>Забули пароль? <a href="#">Відновлення паролю</a>.</p>

        <button type="submit" class="registerbtn">Увійти</button>
    </div>

    <div class="container signin">
        <p>Не маєте акаунту? <a href="/registration">Реєстрація</a></p>
    </div>
</form>

</body>
</html>