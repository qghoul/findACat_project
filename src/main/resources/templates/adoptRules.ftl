<#ftl encoding='UTF-8'>
<html>
<head>
    <link href="/static/css/style.css" rel="stylesheet">
    <title>Правила адопції</title>
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
    <div class="adoptRulesFlexbox">
        <div class="adoptRulesH1">Правила адопції тварин</div>
        <div class="adoptRulesPartsFlexbox">
            <div class="leftRulesPart">
                <div class="adoptRuleH3">Відповідальне ставлення</div>
                <div class="adoptRulesDescribe">
                    Адопція тварини - це серйозне зобов'язання на довгий термін. Будь ласка, переконайтеся, що у вас є достатньо часу, ресурсів та бажання забезпечити тварині комфортне та безпечне життя</div>
                <div class="adoptRuleH3">Ознайомлення з правилами догляду</div>
                <div class="adoptRulesDescribe">
                    Перед прийняттям рішення про адопцію тварини, ми наполегливо рекомендуємо ознайомитись з правилами та рекомендаціями щодо догляду та харчування</div>
                <div class="adoptRuleH3">
                    Слідкуйте за здоров'ям тварини</div>
                <div class="adoptRulesDescribe">
                    Після адопції, будь ласка, регулярно відвідуйте ветеринарного лікаря для профілактичних оглядів та вчасного лікування, якщо з'являться будь-які ознаки хвороби чи дискомфорту у тварини
                </div>
                <div class="adoptRuleH3">Вакцинація та стерилізація</div>
                <div class="adoptRulesDescribe">
                    Ми наголошуємо на важливості збереження популяції та здоров'я тварин, тому після адопції важливо вчасно провести процедури вакцинації та стерилізації</div>
                <div class="adoptRuleH3">Заборона на реалізацію</div>
                <div class="adoptRulesDescribe">
                    Заборонено продавати або передавати адоптовану тварину безпосередньо іншим особам. Якщо у вас виникли складнощі з доглядом за твариною, будь ласка, зверніться до нас для консультації або переадоптації
                </div>
            </div>
            <div class="rightRulesPart">
                <div class="adopt-image">
                    <img src="/static/images/rulesId1.jpg">
                </div>
                <div class="adopt-image">
                    <img src="/static/images/rulesId2.jpg">
                </div>
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