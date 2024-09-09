<#ftl encoding='UTF-8'>
<html>
<head>
    <title>Реєстрація</title>
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
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.querySelector('form');
            form.addEventListener('submit', function(event) {
                const telegramUsername = form.elements['telegramUsername'].value.trim();
                const phoneNumber = form.elements['phoneNumber'].value.trim();
                if (!telegramUsername && !phoneNumber) {
                    alert('Будь-ласка, вкажіть хоча б один контакт. Для цього заповніть поле "Нікнейм Telegram" або "Номер телефону".');
                    event.preventDefault();
                }
            });
        });
    </script>
</head>
<body>

<form action="/registration" method="post">
    <div class="container">
        <h1>Реєстрація</h1>
        <p>Будь-ласка заповінсть форму для реєстрації.</p>
        <hr>
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

        <#if error??>
            <div class="errorMessage">${error}</div>
            <hr>
        </#if>

        <label for="email"><b>Email</b></label>
        <input type="text" placeholder="Enter Email" name="email" required>

        <label for="password"><b>Пароль</b></label>
        <input type="password" placeholder="Enter Password" name="password" required>

        <label for="passwordConfirm"><b>Підтвердження паролю</b></label>
        <input type="password" placeholder="Repeat Password" name="passwordConfirm" required>

        <label for="username"><b>Оберіть ім'я користувача</b></label>
        <input type="text" placeholder="Enter your Username" name="username"
            <#if userForm.username??>value="${userForm.username}"</#if> required>

        <label><b>Вкажіть ваші контакти, що будуть відображатись у ваших оголошеннях для зворотнього зв'язку (щонайменше один конакт):</b></label>
        <br><br>

        <label for="telegramUsername"><b>Нікнейм Телеграм (через @)</b></label>
        <input type="text" placeholder="Enter your Telegram username" name="telegramUsername"
               <#if telegramUsername??>value="${telegramUsername}"</#if>>

        <label for="phoneNumber"><b>Номер телефону</b></label>
        <input type="text" placeholder="Enter your Phone number" name="phoneNumber"
               <#if phoneNumber??>value="${phoneNumber}"</#if>>

        <p>Створюючи акаунт ви погоджуєтесь з нашими <a href="#">Terms & Privacy</a>.</p>

        <button type="submit" class="registerbtn">Зареєструвати акаунт</button>
    </div>

    <div class="container signin">
        <p>Вже маєте аккаунт? <a href="/login">Аворизація</a></p>
    </div>
</form>

</body>
</html>