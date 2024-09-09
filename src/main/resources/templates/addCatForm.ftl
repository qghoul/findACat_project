<#ftl encoding='UTF-8'>
<html>
<head>
  <link href="/static/css/style.css" rel="stylesheet">
  <title>Додати оголошення</title>
  <script>
    document.addEventListener('DOMContentLoaded', function() {
      document.querySelector('.addForm').addEventListener('submit', function (e) {
        //e.preventDefault(); // Предотвращаем стандартное поведение отправки формы
        var isValid = true;
        var formElements = this.elements;

        console.log(formElements);

        for (var i = 0; i < formElements.length; i++) {
          var element = formElements[i];

          if (element.type === 'radio') {
            // Проверяем, если хотя бы одна радио-кнопка в группе выбрана
            var radioGroupName = element.name;
            var radios = this.querySelectorAll('input[name="' + radioGroupName + '"]');
            var radioChecked = Array.prototype.some.call(radios, function(radio) {
              return radio.checked;
            });
            if (!radioChecked) {
              isValid = false;
              break;
            }
          }
          if (element.required && !element.value.trim()) {
            isValid = false;
            break;
          }
        }
        if (!isValid) {
          e.preventDefault();
          alert('Помилка. Будь-ласка, оберіть значення для кожного поля форми');
          return;
        }
      });
      })
    function checkFileCount(input) {
      if (input.files.length > 5) {
        alert("Вы можете обрати не більше 5 файлів.");
        input.value = ''; // очищаем значение поля input, чтобы пользователь мог выбрать файлы заново
      } else {
        previewImages(input);
      }
    }
    // Функция для проверки, выбрано ли хотя бы одно значение в радио-поле
    function isChecked(element) {
      var radios = document.getElementsByName(element.name);
      for (var k = 0; k < radios.length; k++) {
        if (radios[k].checked) {
          return true;
        }
      }
      return false;
    }
    function previewImages(input) {
      var files = input.files;
      var preview = document.querySelector('.image-preview');
      preview.innerHTML = '';

      for (var i = 0; i < files.length; i++) {
        var file = files[i];
        var reader = new FileReader();
        reader.onload = (function(file, index) {
          return function(e) {
            var image = document.createElement('img');
            image.src = e.target.result;
            image.classList.add('preview-image');
            preview.appendChild(image);

            var removeButton = document.createElement('button');
            removeButton.textContent = 'X';
            removeButton.classList.add('remove-button');
            removeButton.onclick = function() {
              preview.removeChild(image);
              preview.removeChild(removeButton);
              // Удаляем файл из выбранных файлов
              var updatedFiles = removeFile(input.files, index);
              input.files = updatedFiles;
              // Обновляем индексы
              previewImages(input);
            };
            preview.appendChild(removeButton);
          };
        })(file, i);
        reader.readAsDataURL(file);
      }
    }

    // Функция для удаления файла из списка файлов по индексу
    function removeFile(files, index) {
      var newFiles = new DataTransfer();
      for (var i = 0; i < files.length; i++) {
        if (i !== index) {
          newFiles.items.add(files[i]);
        }
      }
      return newFiles.files;
    }
    function setupCharacterCounter() {
      const ta = document.querySelector('#details');
      const counter = document.querySelector('.counter-text__current');

      ta.addEventListener('input', () => counter.textContent = ta.value.length);
    }

    // Вызов функции при загрузке DOM
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
      <form class="addForm" action="/user/add" enctype="multipart/form-data" method="post">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <div class="infoInAddForm">Ваші контактні дані, що будуть відображатися у оголошені:</div>
        <div class="infoInAddForm">
          <#if currentUser.contactInfo.phoneNumber??>
            Номер телефону: ${currentUser.contactInfo.phoneNumber} &
          </#if>
          <#if currentUser.contactInfo.telegramUsername??>
            Телеграм: ${currentUser.contactInfo.telegramUsername}
          </#if>
        </div>
        <div class="infoInAddForm"><a href="/user/changeContactInfo">Змінити?</a></div>
        <div class="text-field">
          <label class="text-field__label" for="name">Ім'я кота:</label>
          <input class="text-field__input" type="text" id="name" name="name" required>
        </div>
        <div class="text-field">
          <label class="text-field__label" for="age">Вік:</label>
          <input class="text-field__input" type="number" id="age" name="age" maxlength = "2"
                 oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);" required>
        </div>
        <div class="text-field">
          <label class="text-field__label" for="weight">Вага (кг):</label>
          <input class="text-field__input" type="number" id="weight" name="weight" maxlength = "2" oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);" required>
        </div>
        <div class="cont"><label class="filter" for="region">Область</label>
          <div class="custom-select">
            <select id="region" name="region">
              <option value="Vinnytsia">Вінницька</option>
              <option value="Volyn">Волинська</option>
              <option value="Dnipropetrovsk">Дніпропетровська</option>
              <option value="Donetsk">Донецька</option>
              <option value="Zhytomyr">Житомирська</option>
              <option value="Zakarpattia">Закарпатська</option>
              <option value="Zaporizhzhia">Запорізька</option>
              <option value="IvanoFrankivsk">Івано-Франківська</option>
              <option value="Kyiv">Київська</option>
              <option value="Kirovohrad">Кіровоградська</option>
              <option value="Luhansk">Луганська</option>
              <option value="Lviv">Львівська</option>
              <option value="Mykolaiv">Миколаївська</option>
              <option value="Odesa">Одеська</option>
              <option value="Poltava">Полтавська</option>
              <option value="Rivne">Рівненська</option>
              <option value="Sumy">Сумська</option>
              <option value="Ternopil">Тернопільська</option>
              <option value="Kharkiv">Харківська</option>
              <option value="Kherson">Херсонська</option>
              <option value="Khmelnytskyi">Хмельницька</option>
              <option value="Cherkasy">Черкаська</option>
              <option value="Chernivtsi">Чернівецька</option>
              <option value="Chernihiv">Чернігівська</option>
            </select></div></div>
        <div class="cont">
          <label class="filter">Активність</label>
          <div class="radioContainer">
            <label class="radioLabelActivity">
              <input type="radio" class="option-input radio" name="activity" value="active">Активний</label></div>
          <div class="radioContainer">
            <label class="radioLabelActivity">
              <input type="radio" class="option-input radio" name="activity" value="calm">Спокійний</label></div>
        </div>
        <div class="cont">
          <label class="filter">Характер</label>
          <div class="radioContainer">
            <label class="radioLabelCharacter">
              <input type="radio" class="option-input radio" name="character" value="independent">Незалежний</label></div>
          <div class="radioContainer">
            <label class="radioLabelCharacter">
              <input type="radio" class="option-input radio" name="character" value="sociable">Товариський</label></div>
        </div>
        <div class="cont">
          <label class="filter">Стать</label>
          <div class="radioContainer">
            <label class="radioLabelGender">
              <input type="radio" class="option-input radio" name="gender" value="female">Дівчинка</label></div>
          <div class="radioContainer">
            <label class="radioLabelGender">
              <input type="radio" class="option-input radio" name="gender" value="male">Хлопчик</label></div>
          <div class="radioContainer">
            <label class="radioLabelGender">
              <input type="radio" class="option-input radio" name="gender" value="unknown">Невідомо</label></div>
        </div>
        <div class="cont">
          <label class="filter">Стерилізація</label>
          <div class="radioContainer">
            <label class="radioLabelSterilized">
              <input type="radio" class="option-input radio" name="sterilized" value="true">Так</label></div>
          <div class="radioContainer">
            <label class="radioLabelSterilized">
              <input type="radio" class="option-input radio" name="sterilized" value="false">Ні</label></div>
        </div>
        <div class="cont">
          <label class="filter">
            Вакцинація</label>
          <div class="radioContainer">
            <label class="radioLabelVaccinated">
              <input type="radio" class="option-input radio" name="vaccinated" value="true"/>Так</label></div>
          <div class="radioContainer">
            <label class="radioLabelVaccinated">
              <input type="radio" class="option-input radio" name="vaccinated" value="false"/>Ні</label></div>
        </div>
        <div class="cont">
          <label class="filter">Досвід спілкування з дітьми</label>
          <div class="radioContainer">
            <label class="radioLabelCF">
              <input type="radio" class="option-input radio" name="childFriendly" value="false"/>Немає</label></div>
          <div class="radioContainer">
            <label class="radioLabelCF">
              <input type="radio" class="option-input radio" name="childFriendly" value="true"/>Є</label></div>
        </div>
        <div class="cont">
          <label class="filter" for="images">Додати фотографію</label>
          <input type="file" id="images" name="images" accept="image/*" onchange="checkFileCount(this)" multiple required>
        </div>
        <div class="image-preview"></div>
        <div class="contForDescribe">
          <label for="details">Опис</label>
          <textarea rows='7' cols="30" name="details" id="details" spellcheck="false" maxlength = "700" oninput="javascript:
            if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);"></textarea>
          <span class="counter-text">
                <span class="counter-text__current">0</span>/<span class="counter-text__total">700</span>
            </span>
        </div>
        <!--<div class="infoInAddForm">Створюючи оголошення ви погоджуєтесь з нашими <a href="#">Terms & Privacy</a>.</div>-->
        <button type="submit" name="submit" class="submit-form">Опублікувати оголошення</button>
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