<#ftl encoding='UTF-8'>
<html>
<head>
    <link href="/static/css/style.css" rel="stylesheet">
    <title>Зміна контактних даних</title>
</head>
<body>
<header>
    <ul class="menu">
        <div class="leftPart"><li id="findPet"><a href="/adverts">Знайти котика</a></li>
            <li><a href="/rules">Правила адопції</a></li>
            <li><a href="">Допомогти</a></li>
            <li><a href="/aboutProject">Про проєкт</a></li>
        </div>
        <div class="rightPart">
            <#if isAuthenticated>
                <div class="dropdown">
                    <button class="dropbtn" id="profile">Профіль</button>
                    <div class="dropdown-content">
                        <li id="myAdverts"><a href="/user/myAdverts">Мої оголошення</a></li>
                        <li id="changeContactInfo"><a href="/user/changeContactInfo">Оновити контактні дані</a></li>
                        <li id="logout"><a href="#" onclick="document.getElementById('logoutForm').submit()">Вийти з акаунту</a></li>
                        <form id="logoutForm" action="/logout" method="post" style="display: none;">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        </form>
                    </div>
                </div>
            <#else>
                <li id="login"><a href="/login">Увійти</a></li>
            </#if>
            <li id="createAdd"><a href="/user/add">Додати оголошення</a></li>
        </div>
    </ul>
</header>
<div class="content">
    <div class="center-global-container">
        <#if errorMessage??>
            <div class="errorMessage">${errorMessage}</div>
        </#if>
        <div class="filters">
            <form class="addForm" action="/user/changeContactInfo" method="post">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <div class="changeContacts">Контактні дані, що було вказано при реєстрації (вони будуть відображатись в усіх ваших оголошеннях):</div>
                <div class="changeContacts">
                    <#if currentUser.contactInfo.phoneNumber??>
                        Номер телефону: ${currentUser.contactInfo.phoneNumber}
                        <#else>Номер телефону: Не вказано
                    </#if>
                </div>
                <div class="changeContacts">
                    <#if currentUser.contactInfo.telegramUsername??>
                        Телеграм: ${currentUser.contactInfo.telegramUsername}
                        <#else>Телеграм: Не вказано
                    </#if>
                </div>
                <br>
                <div class="changeContacts">Для зміни контактних даних заповніть форму:</div>
                <div class="text-field">
                    <label class="changeContacts" for="phoneNumber">Номер телефону:</label>
                    <input class="changeContactsInput" type="text" id="phoneNumber" name="phoneNumber" maxlength="19">
                </div>
                <div class="text-field">
                    <label class="changeContacts" for="telegramUsername">Телеграм:</label>
                    <input class="changeContactsInput" type="text" id="telegramUsername" name="telegramUsername" maxlength="29">
                </div>
                <br>
                <!--<div class="infoInAddForm">Створюючи оголошення ви погоджуєтесь з нашими <a href="#">Terms & Privacy</a>.</div>-->
                <button type="submit" name="submit" class="submit-form">Оновити контактні дані</button>
            </form>
        </div>
    </div>
</div>
<footer>
    <div class="footer-content">
        <p>Copyright &copy; 2024 FindACat. All rights reserved.</p>
    </div>
</footer>
</body>
</html>