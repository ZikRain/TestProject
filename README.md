# TestProject

Чтобы запустить проект необходимо:

- Создать локальный сервер SQLEXPRESS
- Подключить к нему БД (Через файл Бэкапа, или запустив на сервере файл ResetDB.sql)
- в проекте API, в файде appsettings.json изменить строку подключения на свою
- в роекте MVC, в файле BaseWrapper.cs изменить поле сервера на свой локалхост

Порядок запуска проектов:
- SQL
- API
- MVC