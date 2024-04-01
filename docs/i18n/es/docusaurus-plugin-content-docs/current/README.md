---
title: Introducción
id: intro
slug: /intro
sidebar_position: 1
---

import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';
import { Gear, Plus, FloppyDisk, MagnifyingGlass, ScribbleLoop, Pen, Path, ArrowCounterClockwise, ArrowClockwise, Hand, Wrench, Lock} from "@phosphor-icons/react";

![Estandarte](/img/banner.png)

---

> Bienvenido a Butterfly, la aplicación de notas de código abierto.

Butterfly es una aplicación de toma de notas que apunta a una experiencia unificada en todas las plataformas. Proporciona una interfaz de usuario sencilla con una potente personalización.

## Comenzando

> Puedes usar la barra lateral para navegar rápidamente a través de la wiki.

Para empezar a trabajar en la aplicación, tienes dos opciones:

1. [Descargue](/downloads) la versión de la aplicación que es apropiada para su plataforma (Butterfly puede ejecutarse en la mayoría de plataformas móviles, de escritorio y web).
2. Usa [versión web](https://web.butterfly.linwood.dev) si no encuentras tu plataforma o si no quieres instalarla en ella. Vea [aquí](storage#web) sobre el almacenamiento de archivos en la versión web.

> Una vez que abras la aplicación, sigue leyendo.

## Vista principal

![Vista principal](main.png)

La vista principal se compone de varios elementos
<Tabs
    defaultValue = "desktop"
    groupId="platfrom"
        values={[
        {label:"Desktop", value:'desktop'},
 {label:"Mobile", value:'mobile'},
 ]}>
    <TabItem value="desktop">
        ![Pantalla de Bienvenida](/img/welcome_screen_desktop.png)
        La parte superior de la pantalla contiene el banner para actualizaciones, el enlace a esta documentación y el icono de configuración <Gear/>. Finalmente, a la derecha del símbolo de configuración <Gear/> tienes un menú desplegable para controlar cuándo aparecerá este banner (siempre/nunca/en actualizaciones).
        La sección "Archivos" en el área principal de la izquierda. Eso, puedes hacer las operaciones típicas:
            - Selecciona el tipo de visualización (cuadrícula o lista)
            - Selecciona el [almacenamiento original](storage) de los archivos
            - Ordena el orden de visualización de los archivos
            - Añade una carpeta, archivo, plantilla, o importar archivos haciendo clic en <Plus/> más signo
            - Escriba la ruta directa a la ubicación deseada (el campo Ubicación),
            - Buscar archivos
        Finalmente, a la derecha, tiene la pantalla de inicio rápido con las plantillas disponibles en la ubicación actual. Para una instalación fresca esto incluye la plantilla clara y oscura
    </TabItem>
    <TabItem value="mobile">
        ¡Al abrir la mariposa en un dispositivo móvil, se te presentará una pantalla como esta
        ! Pantalla de bienvenida primero](/img/welcome_screen_mobile_1. ng)   
        La parte superior de la pantalla mantiene el banner para actualizaciones, y debajo de él puedes encontrar el enlace de nentación, y al lado del icono de configuración <Gear/>. Finalmente, a la derecha del símbolo de configuración <Gear/> tienes un menú desplegable para controlar cuándo aparecerá este banner (siempre/nunca/en actualizaciones).
        Debajo de ellas, puede encontrar la sección de inicio rápido sosteniendo las plantillas avialables para usted. Por defecto, las plantillas son las plantillas claras y oscuras. 
        Desplazándose hacia abajo, verás la interfaz de archivos:
        \
        ! Segunda parte de la pantalla de bienvenida](/img/welcome_screen_mobile_2. ng)  
        La sección "Archivos" en el área principal de la izquierda. Eso, puedes hacer las operaciones típicas:
        - Selecciona el tipo de visualización (cuadrícula o lista)
        - Selecciona el [almacenamiento original](storage) de los archivos
        - Ordena el orden de visualización de los archivos
        - Añade una carpeta, archivo, plantilla, o importar archivos haciendo clic en <Plus/> más signo
        - Escriba la ruta directa a la ubicación deseada (el campo Ubicación),
        - Buscar archivos
    </TabItem>
</Tabs>

Una vez que abra un documento seleccionando una plantilla o un archivo existente, obtendrá a la **Vista de documento**

## Vista del documento

Puede volver desde la vista de documento a la lista de documentos con la acción de atrás de su dispositivo. Al igual que con la vista principal, el documento muestra cambios basados en su dispositivo.

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
        butterfly button to open the menu. Junto a él está el campo nombre que muestra el nombre de la nota. Puede cambiar el nombre de la nota escribiendo un nuevo nombre en ese campo y guardándolo usando el botón <FloppyDisk/> guardar. Finally you can <MagnifyingGlass/> search for elements within the note.
        \
        ¡En la parte superior derecha de la pantalla tienes la barra de herramientas/
        ![toolbar](/img/document_view_toolbar. ng)\
        Por defecto esta barra tiene la herramienta <ScribbleLoop/> lasso; la herramienta de pluma <Pen/> la herramienta de borrar ruta <Path/> ; las butonas <ArrowCounterClockwise/> deshacer y <ArrowClockwise/> rehacer, y la herramienta <Hand/>. Luego tienes el botón <Plus/> para añadir elementos a la barra de herramientas, el botón <Wrench/> para configurar el documento, y, finalmente, la herramienta <Lock/> para ver el zoom y/o la posición de la pantalla. 
        ### Notas importantes
        1. Si algunos de los elementos de la barra de herramientas no son visibles para usted, haga clic y arrastre (o deslize) a la izquierda y a la derecha para revelar más herramientas. 
        2. Después de seleccionar una herramienta, aparecerá un pequeño menú. Hacer clic largo en la herramienta de nuevo te permitirá arrastrarlo a una nueva posición
        3. Puede añadir más herramientas a la barra de herramientas haciendo clic en el signo <Plus/>. 
    </TabItem>
    <TabItem value="mobile">
        In the mobile view, you'll have at the top the file bar\
        ![file_bar](/img/document_view_file_bar.png)\
        This holds, from left to right, the 
        [<img alt="logo" src="/img/logo.png" width="16"/>](/img/logo.png)
        butterfly button to open the menu. Junto a él está el campo nombre que muestra el nombre de la nota. Puede cambiar el nombre de la nota escribiendo un nuevo nombre en ese campo y guardándolo usando el botón <FloppyDisk/> guardar. Finally you can <MagnifyingGlass/> search for elements within the note.
        \
        ¡En la parte inferior de la pantalla tienes la barra de herramientas/
        ![toolbar](/img/document_view_toolbar. ng)\
        Por defecto esta barra tiene la herramienta <ScribbleLoop/> lasso; la herramienta de pluma <Pen/> la herramienta de borrar ruta <Path/> ; las butonas <ArrowCounterClockwise/> deshacer y <ArrowClockwise/> rehacer, y la herramienta <Hand/>. Luego tienes el botón <Plus/> para añadir elementos a la barra de herramientas, el botón <Wrench/> para configurar el documento, y, finalmente, la herramienta <Lock/> para ver el zoom y/o la posición de la pantalla. 
        ### Notas importantes
        1. Si algunos de los elementos de la barra de herramientas no son visibles para ti, o desliza hacia la izquierda y la derecha para revelar elementos adicionales. 
        2. Después de seleccionar una herramienta, aparecerá un pequeño menú para configurarla. Hacer clic largo en la herramienta de nuevo te permitirá arrastrarlo a una nueva posición
        3. Puede añadir más herramientas a la barra de herramientas haciendo clic en el signo <Plus/>. 
    </TabItem>
</Tabs>
