<#ftl encoding='UTF-8'>
<html>
<head>
  <link href="/static/css/style.css" rel="stylesheet">
  <title>Список оголошень</title>
  <script>
    document.addEventListener('DOMContentLoaded', function() {
      const advertisementContainers = document.querySelectorAll('.catalog-item');
      advertisementContainers.forEach(container => {
        container.addEventListener('click', function() {
          const advertisementId = container.getAttribute('data-advertisement-id');
          window.location.href = `/adverts/advert/` + advertisementId;
        });
      });
    });
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
  <div class="main-content">
    <div class="filters">
      <p>Налаштувати пошук</p>
      <form class="filterForm" action="/adverts/filteredAdverts" method="GET">
        <!-- Здесь размещаем фильтры для поиска -->
        <div class="cont">
          <label class="filter" for="regionLocation">Область України</label>
          <div class="custom-select">
            <select id="regionLocation" name="regionLocation">
              <option value="Vinnytsia" <#if selectedRegion?has_content && selectedRegion == 'Vinnytsia'>selected</#if>>Вінницька</option>
              <option value="Volyn" <#if selectedRegion?has_content && selectedRegion == 'Volyn'>selected</#if>>Волинська</option>
              <option value="Dnipropetrovsk" <#if selectedRegion?has_content && selectedRegion == 'Dnipropetrovsk'>selected</#if>>Дніпропетровська</option>
              <option value="Donetsk" <#if selectedRegion?has_content && selectedRegion == 'Donetsk'>selected</#if>>Донецька</option>
              <option value="Zhytomyr" <#if selectedRegion?has_content && selectedRegion == 'Zhytomyr'>selected</#if>>Житомирська</option>
              <option value="Zakarpattia" <#if selectedRegion?has_content && selectedRegion == 'Zakarpattia'>selected</#if>>Закарпатська</option>
              <option value="Zaporizhzhia" <#if selectedRegion?has_content && selectedRegion == 'Zaporizhzhia'>selected</#if>>Запорізька</option>
              <option value="IvanoFrankivsk" <#if selectedRegion?has_content && selectedRegion == 'IvanoFrankivsk'>selected</#if>>Івано-Франківська</option>
              <option value="Kyiv" <#if selectedRegion?has_content && selectedRegion == 'Kyiv'>selected</#if>>Київська</option>
              <option value="Kirovohrad" <#if selectedRegion?has_content && selectedRegion == 'Kirovohrad'>selected</#if>>Кіровоградська</option>
              <option value="Luhansk" <#if selectedRegion?has_content && selectedRegion == 'Luhansk'>selected</#if>>Луганська</option>
              <option value="Lviv" <#if selectedRegion?has_content && selectedRegion == 'Lviv'>selected</#if>>Львівська</option>
              <option value="Mykolaiv" <#if selectedRegion?has_content && selectedRegion == 'Mykolaiv'>selected</#if>>Миколаївська</option>
              <option value="Odesa" <#if selectedRegion?has_content && selectedRegion == 'Odesa'>selected</#if>>Одеська</option>
              <option value="Poltava" <#if selectedRegion?has_content && selectedRegion == 'Poltava'>selected</#if>>Полтавська</option>
              <option value="Rivne" <#if selectedRegion?has_content && selectedRegion == 'Rivne'>selected</#if>>Рівненська</option>
              <option value="Sumy" <#if selectedRegion?has_content && selectedRegion == 'Sumy'>selected</#if>>Сумська</option>
              <option value="Ternopil" <#if selectedRegion?has_content && selectedRegion == 'Ternopil'>selected</#if>>Тернопільська</option>
              <option value="Kharkiv" <#if selectedRegion?has_content && selectedRegion == 'Kharkiv'>selected</#if>>Харківська</option>
              <option value="Kherson" <#if selectedRegion?has_content && selectedRegion == 'Kherson'>selected</#if>>Херсонська</option>
              <option value="Khmelnytskyi" <#if selectedRegion?has_content && selectedRegion == 'Khmelnytskyi'>selected</#if>>Хмельницька</option>
              <option value="Cherkasy" <#if selectedRegion?has_content && selectedRegion == 'Cherkasy'>selected</#if>>Черкаська</option>
              <option value="Chernivtsi" <#if selectedRegion?has_content && selectedRegion == 'Chernivtsi'>selected</#if>>Чернівецька</option>
              <option value="Chernihiv" <#if selectedRegion?has_content && selectedRegion == 'Chernihiv'>selected</#if>>Чернігівська</option>
            </select>
          </div>
        </div>

        <!-- Фильтр Характер -->
        <div class="cont">
          <label class="filter" for="character">Характер</label>
          <div class="radioContainer">
            <label class="radioLabelCharacter">
              <input type="radio" class="option-input radio" name="character" value="any" <#if selectedCharacter?has_content && selectedCharacter != 'any'><#else>checked</#if>>Не важливо
            </label>
          </div>
          <div class="radioContainer">
            <label class="radioLabelCharacter">
              <input type="radio" class="option-input radio" name="character" value="independent" <#if selectedCharacter?has_content && selectedCharacter == 'independent'>checked</#if>>Незалежний
            </label>
          </div>
          <div class="radioContainer">
            <label class="radioLabelCharacter">
              <input type="radio" class="option-input radio" name="character" value="sociable" <#if selectedCharacter?has_content && selectedCharacter == 'sociable'>checked</#if>>Товариський
            </label>
          </div>
        </div>

        <!-- Фильтр Активність -->
        <div class="cont">
          <label class="filter" for="activity">Активність</label>
          <div class="radioContainer">
            <label class="radioLabelActivity">
              <input type="radio" class="option-input radio" name="activity" value="any" <#if selectedActivity?has_content && selectedActivity != 'any'><#else>checked</#if>>Не важливо
            </label>
          </div>
          <div class="radioContainer">
            <label class="radioLabelActivity">
              <input type="radio" class="option-input radio" name="activity" value="active" <#if selectedActivity?has_content && selectedActivity == 'active'>checked</#if>>Активний
            </label>
          </div>
          <div class="radioContainer">
            <label class="radioLabelActivity">
              <input type="radio" class="option-input radio" name="activity" value="calm" <#if selectedActivity?has_content && selectedActivity == 'calm'>checked</#if>>Спокійний
            </label>
          </div>
        </div>

        <!-- Фильтр Стать -->
        <div class="cont">
          <label class="filter" for="gender">Стать</label>
          <div class="radioContainer">
            <label class="radioLabelGender">
              <input type="radio" class="option-input radio" name="gender" value="any" <#if selectedGender?has_content && selectedGender != 'any'><#else>checked</#if>>Не важливо
            </label>
          </div>
          <div class="radioContainer">
            <label class="radioLabelGender">
              <input type="radio" class="option-input radio" name="gender" value="female" <#if selectedGender?has_content && selectedGender == 'female'>checked</#if>>Дівчинка
            </label>
          </div>
          <div class="radioContainer">
            <label class="radioLabelGender">
              <input type="radio" class="option-input radio" name="gender" value="male" <#if selectedGender?has_content && selectedGender == 'male'>checked</#if>>Хлопчик
            </label>
          </div>
        </div>

        <!-- Фильтр Вік -->
        <div class="cont">
          <label class="filter" for="age">Вік</label>
          <div class="radioContainer">
            <label class="radioLabelAge">
              <input type="radio" class="option-input radio" name="age" value="any" <#if selectedAge?has_content && selectedAge != 'any'><#else>checked</#if>>Не важливо
            </label>
          </div>
          <div class="radioContainer">
            <label class="radioLabelAge">
              <input type="radio" class="option-input radio" name="age" value="young" <#if selectedAge?has_content && selectedAge == 'young'>checked</#if>>0-1
            </label>
          </div>
          <div class="radioContainer">
            <label class="radioLabelAge">
              <input type="radio" class="option-input radio" name="age" value="middle" <#if selectedAge?has_content && selectedAge == 'middle'>checked</#if>>1-5
            </label>
          </div>
          <div class="radioContainer">
            <label class="radioLabelAge">
              <input type="radio" class="option-input radio" name="age" value="adult" <#if selectedAge?has_content && selectedAge == 'adult'>checked</#if>>5+
            </label>
          </div>
        </div>

        <!-- Фильтр Розмір -->
        <div class="cont">
          <label class="filter" for="weight">Розмір</label>
          <div class="radioContainer">
            <label class="radioLabelWeight">
              <input type="radio" class="option-input radio" name="weight" value="any" <#if selectedWeight?has_content && selectedWeight != 'any'><#else>checked</#if>>Не важливо
            </label>
          </div>
          <div class="radioContainer">
            <label class="radioLabelWeight">
              <input type="radio" class="option-input radio" name="weight" value="small" <#if selectedWeight?has_content && selectedWeight == 'small'>checked</#if>>0-2
            </label>
          </div>
          <div class="radioContainer">
            <label class="radioLabelWeight">
              <input type="radio" class="option-input radio" name="weight" value="medium" <#if selectedWeight?has_content && selectedWeight == 'medium'>checked</#if>>2-5
            </label>
          </div>
          <div class="radioContainer">
            <label class="radioLabelWeight">
              <input type="radio" class="option-input radio" name="weight" value="big" <#if selectedWeight?has_content && selectedWeight == 'big'>checked</#if>>5+
            </label>
          </div>
        </div>

        <!-- Фильтр Стерилізація -->
        <div class="cont">
          <label class="filter" for="sterilized">Стерилізація</label>
          <div class="radioContainer">
            <label class="radioLabelSterilized">
              <input type="radio" class="option-input radio" name="sterilized" value="any" <#if selectedSterilized?has_content && selectedSterilized != 'any'><#else>checked</#if>>Не важливо
            </label>
          </div>
          <div class="radioContainer">
            <label class="radioLabelSterilized">
              <input type="radio" class="option-input radio" name="sterilized" value="yes" <#if selectedSterilized?has_content && selectedSterilized == 'yes'>checked</#if>>Так
            </label>
          </div>
          <div class="radioContainer">
            <label class="radioLabelSterilized">
              <input type="radio" class="option-input radio" name="sterilized" value="no" <#if selectedSterilized?has_content && selectedSterilized == 'no'>checked</#if>>Ні
            </label>
          </div>
        </div>

        <!-- Фильтр Вакцинація -->
        <div class="cont">
          <label class="filter" for="vaccinated">Вакцинація</label>
          <div class="radioContainer">
            <label class="radioLabelVaccinated">
              <input type="radio" class="option-input radio" name="vaccinated" value="any" <#if selectedVaccinated?has_content && selectedVaccinated != 'any'><#else>checked</#if>>Не важливо
            </label>
          </div>
          <div class="radioContainer">
            <label class="radioLabelVaccinated">
              <input type="radio" class="option-input radio" name="vaccinated" value="yes" <#if selectedVaccinated?has_content && selectedVaccinated == 'yes'>checked</#if>>Так
            </label>
          </div>
          <div class="radioContainer">
            <label class="radioLabelVaccinated">
              <input type="radio" class="option-input radio" name="vaccinated" value="no" <#if selectedVaccinated?has_content && selectedVaccinated == 'no'>checked</#if>>Ні
            </label>
          </div>
        </div>

        <!-- Фильтр Дружні з дітьми -->
        <div class="cont">
          <label class="filter" for="childFriendly">Дружні з дітьми</label>
          <div class="radioContainer">
            <label class="radioLabelCF">
              <input type="radio" class="option-input radio" name="childFriendly" value="any" <#if selectedChildFriendly?has_content && selectedChildFriendly != 'any'><#else>checked</#if>>Не важливо
            </label>
          </div>
          <div class="radioContainer">
            <label class="radioLabelCF">
              <input type="radio" class="option-input radio" name="childFriendly" value="yes" <#if selectedChildFriendly?has_content && selectedChildFriendly == 'yes'>checked</#if>>Так
            </label>
          </div>
        </div>
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <div id="flexBoxForSubmits">
          <button type="submit" name="submit" class="submit-form" value="getRandom">Отримати випадкову анкету</button>
          <button type="submit" name="submit" class="submit-form" value="getAll">Показати усі</button></div>
        <div class="sortingBlock">
          <div class="cont">
            <label for="sortType">Сортування:</label>
            <div class="custom-select">
              <select id="sortType" name="sortType">
                <option value="default">За замовчанням</option>
                <option value="mostRecent">Найновіші</option>
                <option value="oldest">Найстаріші</option>
              </select>
            </div>
          </div>
        </div>
      </form>
    </div>
    <div class="catalog">
    <#if advertisements??>
    <#list advertisements as advert>
      <div class="catalog-item" data-advertisement-id="${advert.id}">
        <p class="catNameInCatalog">${advert.cat.name}</p>
        <#list coverImages as coverImage>
          <#if coverImage.advertisement.id == advert.id>
            <img src="/dynamicImages/${coverImage.name}" alt="Cover image">
          </#if>
        </#list>
      </div>
    </#list>
    </#if>
    </div>
  </div>
  <#if totalPages??>
  <div class="paginationFlexContainer">
    <div class="pagination">
      <ul>
        <#if currentPage gt 0>
          <li><a href="/adverts?page=0">First</a></li>
        </#if>
        <#if currentPage gt 0>
          <li><a href="/adverts?page=${currentPage - 1}">Previous</a></li>
        </#if>
        <#list 0..<totalPages as pageItem>
          <li><a href="/adverts?page=${pageItem}" class="<#if currentPage == pageItem>active</#if>">${pageItem + 1}</a></li>
        </#list>
        <#if currentPage lt totalPages - 1>
          <li><a href="/adverts?page=${currentPage + 1}">Next</a></li>
        </#if>
        <#if currentPage lt totalPages - 1>
          <li><a href="/adverts?page=${totalPages - 1}">Last</a></li>
        </#if>
      </ul>
    </div>
  </div>
  </#if>
</div>

<footer>
  <div class="footer-content">
    <p>Copyright &copy; 2024 FindACat. All rights reserved.</p>
  </div>
</footer>
</body>
</html>