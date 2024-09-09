<#ftl encoding='UTF-8'>
<html>
<head>
    <link href="/static/css/style.css" rel="stylesheet">
    <meta name="csrf-token" content="${_csrf.token}">
    <meta name="_csrf_header" content="${_csrf.headerName}">
    <title>Мої оголошення</title>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const advertisementContainers = document.querySelectorAll('.catalog-item-myAdverts');
            advertisementContainers.forEach(container => {
                container.addEventListener('click', function() {
                    const advertisementId = container.getAttribute('data-advertisement-id');
                    window.location.href = `/adverts/advert/` + advertisementId;
                });
            });
        });
        function editAd(adId) {
            event.stopPropagation();
            // Переход к форме редактирования с идентификатором объявления
            window.location.href = `/user/myAdverts/edit/`+ adId;
        }

        function confirmDelete(adId) {
            if (confirm("Ви впенені, що хочете видалити оголошення?")) {
                deleteAd(adId);
            }
        }

        function deleteAd(adId) {
            fetch(`/user/myAdverts/delete/`+ adId, {
                method: 'DELETE',
                headers: {
                    'Content-Type': 'application/json',
                    [getCsrfHeaderName()]: getCsrfToken()
                }
            })
                .then(response => {
                    if (response.ok) {
                        window.location.href = "/user/myAdverts";
                    } else {
                        alert('Помилка при видалені оголошення');
                    }
                })
                .catch(error => {
                    console.error('Ошибка:', error);
                    alert('Помилка при видалені оголошення');
                });
        }
        function getCsrfHeaderName() {
            return document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
        }
        function getCsrfToken() {
            return document.querySelector('meta[name="csrf-token"]').getAttribute('content');
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
    <div class="main-content">
        <div class="pageNameCont">
            <p>Ваші активні оголошення</p>
        </div>
        <#if successMessage??>
            <p>${successMessage}</p>
        </#if>
        <div class="catalog-myAdverts">
            <#if advertisements??>
                <#list advertisements as advert>
                    <div class="catalog-item-myAdverts" data-advertisement-id="${advert.id}">
                        <div class="advertData"><p class="catNameInCatalog">${advert.cat.name}</p>
                        <#list coverImages as coverImage>
                            <#if coverImage.advertisement.id == advert.id>
                                <img src="/dynamicImages/${coverImage.name}" alt="Cover image">
                            </#if>
                        </#list>
                        </div>
                        <div class="advertButtons">
                            <button class="edit-btn" onclick="editAd(${advert.id})" title="Редагувати">✏️</button>
                            <button class="delete-btn" onclick="confirmDelete(${advert.id})" title="Видалити">
                                <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                                    <path stroke-linecap="round" stroke-linejoin="round" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
                                </svg>
                            </button>
                        </div>
                    </div>
                </#list>
            </#if>
        </div>
    </div>
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
</div>
<footer>
    <div class="footer-content">
        <p>Copyright &copy; 2024 FindACat. All rights reserved.</p>
    </div>
</footer>
</body>
</html>