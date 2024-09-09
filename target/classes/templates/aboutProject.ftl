<#ftl encoding='UTF-8'>
<html>
<head>
    <link href="/static/css/style.css" rel="stylesheet">
    <title>Про проєкт</title>
    <script>
    </script>
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
        <div class="aboutProjectHeader">Про проєкт</div>
        <div class="partsFlexbox">
            <div class="leftAboutPart">
                <div class="aboutProject-image">
                    <img src="/static/images/logo.jpg">
                </div>
            </div>
            <div class="rightAboutPart">
                <div class="aboutDescribe">
                    <p>FindACat - благодійний проєкт, головною метою якого є допмога тваринам, що шукають новий дім.</p>
                    <p>Основною ціллю проєкту є сприяти зниженню кількості тварин у притулках та безхатніх тварин в Україні, допомогаючи знаходити їм нових господарів. Що сприятиме вирішення проблеми безхатніх тварин в Україні.</p>
                    <p>Веб-додаток проєкту створено для того, щоб дозволити притулкам, або тимчасовим опікунам тварин легко та безкоштовно створювати і поширювати оголошення в інтернеті. Також веб-додаток має забезпечити комфортні процеси пошуку, вибору та подальшої адопції тварини для людей, що вирішили завести тварину.</p>
                    <p></p></div>
            </div>
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