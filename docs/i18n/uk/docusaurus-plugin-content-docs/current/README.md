---
title: Вступ
id: intro
slug: /intro
sidebar_position: 1
---

import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';
import { Gear, Plus, FloppyDisk, MagnifyingGlass, ScribbleLoop, Pen, Path, ArrowCounterClockwise, ArrowClockwise, Hand, Wrench, Lock} from "@phosphor-icons/react";

![Стяг](/img/banner.png)

---

> Ласкаво просимо в Butterfly, додаток для нотаток з відкритим початковим кодом.

Метелик та нотатка, який надає можливість отримати доступ до єдиного доступу на всіх платформах. Він надає простий інтерфейс при потужному налаштування.

## Початок роботи

> Ви можете використовувати бічну панель, щоб швидко орієнтуватися в wiki.


Для того, щоб почати роботу над додатком у вас є два варіанти:
1. [Завантаження](/downloads) Версія додатку, яка підходить для вашої платформи (Butterfly може працювати на більшості мобільних пристроїв, настільних комп'ютерах та веб-платформ).
2. Use [web version](https://butterfly.linwood.dev) if you cannot find your platform or if you don't want to install it on it. See [here](storage#web) about file storage on the web version.

> Як тільки ви відкриєте програму, продовжуйте читати.



## Основний вигляд

![Основний вигляд](main.png)

Головний вигляд складається з декількох елементів
<Tabs
    defaultValue = "desktop"
    groupId="platfrom"
        values={[
        {label:"Desktop", value:'desktop'},
 {label:"Mobile", value:'mobile'},
 ]}>
    <TabItem value="desktop">
        ![вітальний екран](/img/welcome_screen_desktop.png)
        Вгорі екрана тримає банер для оновлень, посилання на цю документацію і значок настроювання <Gear/>. Нарешті, праворуч від символу відповідності з <Gear/> у вас спадне меню для контролю, коли цей банер з'явиться (завжди/ніколи/при оновленні).
        Розділ "Файли" на головній ділянці зліва. There, you can do the typical operations:
            - Select the display type (grid or list)
            - Select the [source storage](storage) of the files
            - Sort the display order of the files
            - Add a folder, file, template, or import files by clicking the <Plus/> plus sign
            - Type the direct path to a desired location (the Location field),
            - Search for files
        Finally, to the right, you have the quick start display with the templates available in the current location. Для свіжого встановлення це включає в себе світлий і темний шаблон
    </TabItem>
    <TabItem value="mobile">
        When opening Butterfly on a mobile device you will be presented with a screen as this
        ![Welcome screen first part](/img/welcome_screen_mobile_1.png)   
        The top of the screen holds the banner for updates, and below it you can find the documnentation link, and next to it the <Gear/> config icon. Нарешті, праворуч від символу відповідності з <Gear/> у вас спадне меню для контролю, коли цей банер з'явиться (завжди/ніколи/при оновленні).
        Нижче наведено список, ви можете знайти швидкий старт, що тримає шаблони для вас готові. Охоплюючи захист, шаблони - це світла й темні шаблони. 
        Прокручування вниз, ви побачите інтерфейс файлу:
        \
        ! Вітаю другу частину екрана](/img/welcome_screen_mobile_2. ng)  
        Розділ "Файли" в основній зоні зліва. There, you can do the typical operations:
        - Select the display type (grid or list)
        - Select the [source storage](storage) of the files
        - Sort the display order of the files
        - Add a folder, file, template, or import files by clicking the <Plus/> plus sign
        - Type the direct path to a desired location (the Location field),
        - Search for files
    </TabItem>
</Tabs>

Після відкриття документа обравши шаблон або наявний файл, ви отримаєте **Перегляд документа**

## Документ

Ви можете повернутися з переліку документів до списку документів з зворотною дією вашого пристрою. Як і з основним переглядом, відображені зміни документа на основі вашого пристрою.

<Tabs
    defaultValue = "desktop"
    groupId="platfrom"
        values={[
        {label:"Desktop", value:'desktop'},
 {label:"Mobile", value:'mobile'},
 ]}>
    <TabItem value="desktop">
        In the Desktop view, you'll have at the top left the file bar\
        ![file_bar](/img/document_view_file_bar.png)\
        This holds, from left to right, the 
        [<img alt="logo" src="/img/logo.png" width="16"/>](/img/logo.png)
        butterfly button to open the menu. Далі біля цього поля "Назва" відображається назва нотатки. You can rename the note by typing a new name into that field and saving it using the <FloppyDisk/> save button. Нарешті ви можете <MagnifyingGlass/> шукати елементи всередині нотатки.
        \
        At the top right of the screen you have the toolbar\
        ![toolbar](/img/document_view_toolbar.png)\
        By default this bar has the <ScribbleLoop/> lasso tool; the <Pen/> pen tool; the <Path/> path erase tool; the <ArrowCounterClockwise/> undo and <ArrowClockwise/> redo butons, and the <Hand/> hand tool. Then you have the <Plus/> button to add elements to the tool bar, the <Wrench/> button to configure the document, and finally the <Lock/> tool to look the zoom and/or the position of the screen. 
        ### Important notes
        1. Якщо якийсь елемент на панелі інструментів не видно вам, перетягніть (або плавайте) вліво та вправо для розкриття інших інструментів. 
        2. Після вибору інструменту з'явиться невелике меню. Довге натискання на інструменті знову дозволить перетягнути його на нове положення
        3. Ви можете додати більше інструментів для панелі інструментів, натиснувши <Plus/> плюс знак. 
    </TabItem>
    <TabItem value="mobile">
        In the mobile view, you'll have at the top the file bar\
        ![file_bar](/img/document_view_file_bar.png)\
        This holds, from left to right, the 
        [<img alt="logo" src="/img/logo.png" width="16"/>](/img/logo.png)
        butterfly button to open the menu. Далі біля цього поля "Назва" відображається назва нотатки. You can rename the note by typing a new name into that field and saving it using the <FloppyDisk/> save button. Нарешті ви можете <MagnifyingGlass/> шукати елементи всередині нотатки.
        \
        At the bottom of the screen you have the toolbar\
        ![toolbar](/img/document_view_toolbar.png)\
        By default this bar has the <ScribbleLoop/> lasso tool; the <Pen/> pen tool; the <Path/> path erase tool; the <ArrowCounterClockwise/> undo and <ArrowClockwise/> redo butons, and the <Hand/> hand tool. Then you have the <Plus/> button to add elements to the tool bar, the <Wrench/> button to configure the document, and finally the <Lock/> tool to look the zoom and/or the position of the screen. 
        ### Important notes
        1. Якщо якийсь елемент на панелі інструментів не видно вам або проведіть ліворуч і праворуч, щоб показати подальші елементи. 
        2. Після вибору інструменту дрібне меню з'явиться для налаштування його. Довге натискання на інструменті знову дозволить перетягнути його на нове положення
        3. Ви можете додати більше інструментів для панелі інструментів, натиснувши <Plus/> плюс знак. 
    </TabItem>
</Tabs>
	

