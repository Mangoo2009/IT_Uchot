# Campus IT Asset Tracker

Юренков С.

Сайт для учёта оборудования в кабинетах разных учреждений

## Уже работает

- вход по логину и паролю
- список кабинетов на главной странице
- добавление нового кабинета
- просмотр оборудования в кабинетах
- добавление оборудования в кабинет

##  Технологии

- Python и FastAPI: сам сайт и адреса страниц
- PostgreSQL: база данных
- SQLAlchemy: чтобы работать с базой из Python
- Jinja2: чтобы вставлять данные из базы в HTML-страницы
- HTML и CSS: внешний вид страниц
- AuthX: вход в систему 

## Использованная документация

- [FastAPI](https://fastapi.tiangolo.com/)
- [Starlette](https://www.starlette.io/)
- [Jinja2](https://jinja.palletsprojects.com/)
- [SQLAlchemy 2.0](https://docs.sqlalchemy.org/en/20/)
- [AuthX](https://authx.yezz.me/)
- [Uvicorn](https://uvicorn.dev)
- [Pydantic](https://docs.pydantic.dev/)
- [psycopg2](https://www.psycopg.org/docs/)
- [PostgreSQL](https://www.postgresql.org/docs/)
- [python-multipart](https://fastapi.tiangolo.com/tutorial/request-forms/#import-form)
- [CSS](https://developer.mozilla.org/ru/docs/Web/CSS/Reference)
- [HTML](https://developer.mozilla.org/ru/docs/Web/HTML/Reference)
- [Как оформлять README](https://docs.github.com/ru/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax)

## Какие файлы в проекте

```
main.py        страницы сайта и что на них происходит
DataBase.py    подключение к базе и описание таблиц
model.py       заготовка для проверки данных (пока не используется)
database.sql   копия базы: таблицы и тестовые данные
templates/     HTML-страницы
static/        CSS-файлы
```

## База данных

Три таблицы:

- `users` — пользователи (имя, фамилия, роль, логин, пароль)
- `cabinets` — кабинеты (название, кто за него отвечает)
- `equpment` — оборудование (название, тип, инвентарный номер, статус, в каком кабинете стоит)

Связи: у одного пользователя может быть несколько кабинетов, в одном кабинете может быть много оборудования.

## Запуск:

1. Установить библиотеки:
   ```
   pip install -r requirements.txt
   ```
2. Создать в PostgreSQL базу `It_inventori` и загрузить в неё данные из файла:
   ```
   psql -U postgres -d It_inventori -f database.sql
   ```
3. Создать в папке проекта файл `.env` и написать в нём:
   ```
   DB_URL=postgresql+psycopg2://postgres:Пароль@localhost:5432/It_inventori
   ```
4. Запустить

Тестовый логин `Mango123`, пароль `admin`


![кот](/NO.jpg)
## Еще будет в проекте:

- редактирование и удаление кабинетов и оборудования
- выход из системы
- разные права для разных ролей
- поиск и фильтр по оборудованию
- улучшить внешний вид
- хранить пароли в зашифрованном виде
