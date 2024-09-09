<#ftl encoding='UTF-8'>
<html>
<head>
    <meta charset="UTF-8">
    <link href="/static/css/style.css" rel="stylesheet">
    <title>Оголошення</title>
    <script>
        window.onload = function() {
            document.querySelector('#giveHomeButton').addEventListener('click', function() {
                document.querySelector('#giveHomeButton').style.display = 'none';
                document.querySelector('.button-list').style.display = 'flex';
            });
            document.querySelector('#getContacts').addEventListener('click', function() {
                document.querySelector('#getContacts').style.display = 'none';
                document.querySelector('#contactInfo').style.display = 'flex';
                document.querySelector('#sendSmsInAppButton').style.display = 'none';
                document.querySelector('#adoptionRulesButton').style.display = 'flex';
            })
        }
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
        <div class="catNameInAdvert"><b>${advert.cat.name}</b></div>
        <div class="addContainer">
            <div class="product-image">
                <#if advert.images?has_content>
                    <#list advert.images as image>
                        <#if image.isCoverImage??>
                            <img src="/dynamicImages/${image.name}">
                        </#if>
                    </#list>
                </#if>
            </div>
            <div class="cat-details">
                <p id="character"><b>Характер:</b>
                    <#if advert.cat.character == "independent">
                        Незалежний
                    <#elseif advert.cat.character == "sociable">
                        Товариський
                    </#if></p>
                <p id="activity"><b>Активність:</b>
                    <#if advert.cat.activity == "calm">
                        Спокійний
                    <#elseif advert.cat.activity == "active">
                        Активний
                    </#if></p>
                <p id="gender"><b>Стать:</b>
                    <#if advert.cat.gender == "male">
                        Хлопчик
                    <#elseif advert.cat.gender == "female">
                        Дівчинка
                    <#else>
                        Невідомо
                    </#if> </p>
                <p id="age"><b>Вік:</b> ${advert.cat.age} </p>
                <p id="weight"><b>Вага:</b> ${advert.cat.weight} кг</p>
                <p id="sterilized"><b>Стерелізація:</b>
                    <#if advert.cat.character == "independent">
                        Незалежний
                    <#elseif advert.cat.character == "sociable">
                        Товариський
                    </#if></p>
                <p id="vaccinated"><b>Вакцинація:</b>
                        <#if advert.cat.vaccinated == true>
                            Вакцинований
                        <#elseif advert.cat.vaccinated == false>
                            Не вакцинований
                        </#if></p>
                <p id="childFriendly"><b>Досвід спілкування з дітьми:</b>
                    <#if advert.cat.childFriendly == true>
                        Так
                    <#elseif advert.cat.childFriendly == false>
                        Невідомо
                    </#if></p>
                <button id="giveHomeButton" class="submit-form">Взяти додому</button>
                <ul class="button-list">
                    <li id="sendSmsInAppButton"><a>Залишити повідомлення у додатку</a></li>
                    <button id="getContacts">Показати контактні дані опікуна</button>
                    <li id="adoptionRulesButton"><a href="/rules">Правила адопції</a></li>
                </ul>
                <div id="contactInfo">
                    <#if advert.user.contactInfo.phoneNumber??>
                        <p>Телефон: ${advert.user.contactInfo.phoneNumber}</p>
                    </#if>
                    <#if advert.user.contactInfo.telegramUsername??>
                        <p>Telegram: ${advert.user.contactInfo.telegramUsername}</p>
                    </#if>
                </div>
            </div>
        </div>
        <div class="describe">
            <div id="headline"><b>Опис</b></div>
            <p>${advert.details}</p>
            <div class="complaintButton">Поскаржитись</div>
            <div id="creationDate">Дата створення: ${advert.creationDate}</div>
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