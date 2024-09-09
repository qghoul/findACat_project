<#ftl encoding='UTF-8'>
<html>
<head>
    <link href="/static/css/style.css" rel="stylesheet">
    <title>Змінити оголошення</title>
    <script>
        function setupCharacterCounter() {
            const ta = document.querySelector('#details');
            const counter = document.querySelector('.counter-text__current');

            ta.addEventListener('input', () => counter.textContent = ta.value.length);
        }
        document.addEventListener('DOMContentLoaded', setupCharacterCounter);
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
        <#if errorMessage??>
            <div class="errorMessage">${errorMessage}</div>
        </#if>
        <div class="filters">
            <form class="addForm" action="/user/myAdverts/edit/${advert.id}" method="post">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <div class="infoInAddForm">Форма для редагування оголошення</div>
                <div class="infoInAddForm">Ваші контактні дані, що будуть відображатися у оголошені:</div>
                <div class="infoInAddForm">
                    <#if advert.user.contactInfo.phoneNumber??>
                        Номер телефону: ${advert.user.contactInfo.phoneNumber} &
                    </#if>
                    <#if advert.user.contactInfo.telegramUsername??>
                        Телеграм: ${advert.user.contactInfo.telegramUsername}
                    </#if>
                </div>
                <div class="infoInAddForm"><a href="/user/changeContactInfo">Змінити?</a></div>
                <div class="text-field">
                    <label class="text-field__label" for="name">Ім'я кота:</label>
                    <input class="text-field__input" type="text" id="name" name="name" value="${advert.cat.name}" required>
                </div>
                <div class="text-field">
                    <label class="text-field__label" for="age">Вік:</label>
                    <input class="text-field__input" type="number" id="age" name="age" maxlength = "2" value="${advert.cat.age}" required>
                </div>
                <div class="text-field">
                    <label class="text-field__label" for="weight">Вага (кг):</label>
                    <input class="text-field__input" type="number" id="weight" name="weight" maxlength = "2" value="${advert.cat.weight}" required>
                </div>
                <div class="cont"><label class="filter" for="region">Область</label>
                    <div class="custom-select">
                        <select id="region" name="region">
                            <option value="Vinnytsia" <#if advert.cat.region == "Vinnytsia">selected</#if>>Вінницька</option>
                            <option value="Volyn" <#if advert.cat.region == "Volyn">selected</#if>>Волинська</option>
                            <option value="Dnipropetrovsk" <#if advert.cat.region == "Dnipropetrovsk">selected</#if>>Дніпропетровська</option>
                            <option value="Donetsk" <#if advert.cat.region == "Donetsk">selected</#if>>Донецька</option>
                            <option value="Zhytomyr" <#if advert.cat.region == "Zhytomyr">selected</#if>>Житомирська</option>
                            <option value="Zakarpattia" <#if advert.cat.region == "Zakarpattia">selected</#if>>Закарпатська</option>
                            <option value="Zaporizhzhia" <#if advert.cat.region == "Zaporizhzhia">selected</#if>>Запорізька</option>
                            <option value="IvanoFrankivsk" <#if advert.cat.region == "IvanoFrankivsk">selected</#if>>Івано-Франківська</option>
                            <option value="Kyiv" <#if advert.cat.region == "Kyiv">selected</#if>>Київська</option>
                            <option value="Kirovohrad" <#if advert.cat.region == "Kirovohrad">selected</#if>>Кіровоградська</option>
                            <option value="Luhansk" <#if advert.cat.region == "Luhansk">selected</#if>>Луганська</option>
                            <option value="Lviv" <#if advert.cat.region == "Lviv">selected</#if>>Львівська</option>
                            <option value="Mykolaiv" <#if advert.cat.region == "Mykolaiv">selected</#if>>Миколаївська</option>
                            <option value="Odesa" <#if advert.cat.region == "Odesa">selected</#if>>Одеська</option>
                            <option value="Poltava" <#if advert.cat.region == "Poltava">selected</#if>>Полтавська</option>
                            <option value="Rivne" <#if advert.cat.region == "Rivne">selected</#if>>Рівненська</option>
                            <option value="Sumy" <#if advert.cat.region == "Sumy">selected</#if>>Сумська</option>
                            <option value="Ternopil" <#if advert.cat.region == "Ternopil">selected</#if>>Тернопільська</option>
                            <option value="Kharkiv" <#if advert.cat.region == "Kharkiv">selected</#if>>Харківська</option>
                            <option value="Kherson" <#if advert.cat.region == "Kherson">selected</#if>>Херсонська</option>
                            <option value="Khmelnytskyi" <#if advert.cat.region == "Khmelnytskyi">selected</#if>>Хмельницька</option>
                            <option value="Cherkasy" <#if advert.cat.region == "Cherkasy">selected</#if>>Черкаська</option>
                            <option value="Chernivtsi" <#if advert.cat.region == "Chernivtsi">selected</#if>>Чернівецька</option>
                            <option value="Chernihiv" <#if advert.cat.region == "Chernihiv">selected</#if>>Чернігівська</option>
                        </select>
                    </div></div>
                <div class="cont">
                    <label class="filter">Активність</label>
                    <div class="radioContainer">
                        <label class="radioLabelActivity">
                            <input type="radio" class="option-input radio" name="activity" value="active"
                                    <#if advert.cat.activity == "active">checked</#if> >Активний</label></div>
                    <div class="radioContainer">
                        <label class="radioLabelActivity">
                            <input type="radio" class="option-input radio" name="activity" value="calm"
                                   <#if advert.cat.activity == "calm">checked</#if> >Спокійний</label></div>
                </div>
                <div class="cont">
                    <label class="filter">Характер</label>
                    <div class="radioContainer">
                        <label class="radioLabelCharacter">
                            <input type="radio" class="option-input radio" name="character" value="independent"
                                   <#if advert.cat.character == "independent">checked</#if>>Незалежний</label></div>
                    <div class="radioContainer">
                        <label class="radioLabelCharacter">
                            <input type="radio" class="option-input radio" name="character" value="sociable"
                                   <#if advert.cat.character == "sociable">checked</#if>>Товариський</label></div>
                </div>
                <div class="cont">
                    <label class="filter">Стать</label>
                    <div class="radioContainer">
                        <label class="radioLabelGender">
                            <input type="radio" class="option-input radio" name="gender" value="female"
                                   <#if advert.cat.gender == "female">checked</#if>>Дівчинка</label></div>
                    <div class="radioContainer">
                        <label class="radioLabelGender">
                            <input type="radio" class="option-input radio" name="gender" value="male"
                                   <#if advert.cat.gender == "male">checked</#if>>Хлопчик</label></div>
                    <div class="radioContainer">
                        <label class="radioLabelGender">
                            <input type="radio" class="option-input radio" name="gender" value="unknown"
                                   <#if advert.cat.gender == "unknown">checked</#if>>Невідомо</label></div>
                </div>
                <div class="cont">
                    <label class="filter">Стерилізація</label>
                    <div class="radioContainer">
                        <label class="radioLabelSterilized">
                            <input type="radio" class="option-input radio" name="sterilized" value="true"
                                   <#if advert.cat.sterilized == true>checked</#if>>Так</label></div>
                    <div class="radioContainer">
                        <label class="radioLabelSterilized">
                            <input type="radio" class="option-input radio" name="sterilized" value="false"
                                   <#if advert.cat.sterilized == false>checked</#if>>Ні</label></div>
                </div>
                <div class="cont">
                    <label class="filter">
                        Вакцинація</label>
                    <div class="radioContainer">
                        <label class="radioLabelVaccinated">
                            <input type="radio" class="option-input radio" name="vaccinated" value="true"
                                   <#if advert.cat.vaccinated == true>checked</#if>/>Так</label></div>
                    <div class="radioContainer">
                        <label class="radioLabelVaccinated">
                            <input type="radio" class="option-input radio" name="vaccinated" value="false"
                                   <#if advert.cat.vaccinated == false>checked</#if>/>Ні</label></div>
                </div>
                <div class="cont">
                    <label class="filter">Досвід спілкування з дітьми</label>
                    <div class="radioContainer">
                        <label class="radioLabelCF">
                            <input type="radio" class="option-input radio" name="childFriendly" value="false"
                                   <#if advert.cat.childFriendly == false>checked</#if>/>Немає</label></div>
                    <div class="radioContainer">
                        <label class="radioLabelCF">
                            <input type="radio" class="option-input radio" name="childFriendly" value="true"
                                   <#if advert.cat.childFriendly == true>checked</#if>/>Є</label></div>
                </div>

                <div class="contForDescribe">
                    <label for="details">Опис</label>
                    <textarea rows='7' cols="30" name="details" spellcheck="false" id="details" maxlength = "700" oninput="javascript:
            if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);"><#if advert.details??>${advert.details}</#if></textarea>
                    <span class="counter-text">
                <span class="counter-text__current">0</span>/<span class="counter-text__total">700</span>
            </span>
                </div>
                <!--<div class="infoInAddForm">Створюючи оголошення ви погоджуєтесь з нашими <a href="#">Terms & Privacy</a>.</div>-->
                <button type="submit" name="submit" class="submit-form">Зберегти зміни</button>
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