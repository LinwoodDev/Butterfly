---
title: Сховище
sidebar_position: 2
---

## Каталог даних

Каталог даних є каталогом, де зберігаються документи, шаблони і пакети.
На комп'ютері ви можете знайти його в `~/Documents/Linwood/Butterfly`.
На мобільному телефоні він (getExternalFilesDir(null)/Linwood/Butterfly\`.
Ви також можете змінити його в налаштуваннях в розділі "Data".

У цьому каталозі ви знайдете папку `Documents`, `Templates` і `Packs`.

## Веб

Дані додатку зберігаються в вашому браузері. Він зберігається у локальному сховищі.
Відкрийте інструменти розробника в браузері і ви побачите дані.

## Самородні платформи

Як за замовчуванням програма зберігає дані у папці ваших документів у підпапці під назвою "Linwood/Butterfly". Ця папка створюється під час збереження перших даних. Цю папку можна змінити в налаштуваннях.

## Віддалене сховище {#remote}

:::note

Ця функція недоступна в Інтернеті.

:::

Програму можна зберегти на віддаленому сервері. Це корисно, якщо ви хочете поділитись даними з іншими людьми або якщо у вас є декілька комп'ютерів. На даний момент підтримується тільки протокол WebDAV.

Щоб додати віддалений сервер, перейдіть до налаштувань та натисніть `Remotes`. Потім натисніть "Додати пульт".
Додайте URL-адресу віддаленого сервера, ім'я користувача і пароль. Після цього ви можете вказати папку, де зберігаються дані.

Щоб отримати адресу webdav url, будь ласка, відвідайте документацію:

- [Nextcloud](https://docs.nextcloud.com/server/latest/user_manual/en/files/access_webdav.html) (це має виглядати так: `https://nextcloud.example.com/remote.php/dav/files/username/`, замінити `username` і `nextcloud.example.com` з правильними значеннями)

### Оффлайн синхронізація {#offline}

Ця функція дозволяє редагувати файли на віддалених серверах у автономному режимі.
Відкрийте спливаюче меню для файлу чи папки та натисніть кнопку "Синхронізація". Це завантажить файл або папку і збереже їх локально. Щоб синхронізувати весь кореневий каталог, клікніть на галочку у діалоговому вікні «Створити» або клацніть на віддаленому екрані в розділі «Керувати».

Є кілька обмежень:

- Ви можете синхронізувати лише найвищий рівень каталогу. Наприклад, якщо у вас є каталог `a/b/test.bfly` , цей файл не буде синхронізований.
- Ви не можете видалити файл або папку поки ви не в мережі.
- Ви не можете додавати, редагувати або видаляти шаблони поки ви в автономному режимі.

## Інші методи зберігання

Якщо ви на рідному пристрої, ви також можете синхронізувати каталог програми з вашою улюбленою платформою.
У Google drive [офіційний додаток](https://www.google.com/drive/download/) у вікнах, і в магазині ігор є неофіційні.
На linux ви також можете використовувати систему віддаленого сховища та змінити ваш каталог даних на це або додати нове зовнішнє сховище, якщо натиснути кнопку додавання підключення.
