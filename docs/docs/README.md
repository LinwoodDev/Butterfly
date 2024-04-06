---
title: Introduction
id: intro
slug: /intro
sidebar_position: 1
---
import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';
import { Gear, 
	Plus, 
	FloppyDisk, 
	MagnifyingGlass,
	ScribbleLoop,
	Pen,
	Path,
	ArrowCounterClockwise,
	ArrowClockwise,
	Hand,
	Wrench,
	Lock} from "@phosphor-icons/react";

![Banner](/img/banner.png)

---

> Welcome to Butterfly, the opensource note app.

Butterfly is a note taking app that is aiming for unified experience across all platforms. It provides simple UI with powerful customization.

## Getting started

> You can use the sidebar to navigate quickly through the wiki.

To start working on the app you have two options:

1. [Downloads](/downloads) the app version that is appropriate for your platform (Butterfly can run on most mobile, desktop, and web platfroms).
2. Use [web version](https://web.butterfly.linwood.dev) if you cannot find your platform or if you don't want to install it on it. See [here](storage#web) about file storage on the web version.

> Once you open the app, continue reading.

## Main view

![Main view](main.png)

The main view is composed of several elements
<Tabs
    defaultValue = "desktop"
	groupId="platfrom"
	    values={[
	    {label:"Desktop", value:'desktop'},
	    {label:"Mobile", value:'mobile'},
	    ]}>
    <TabItem value="desktop">
        ![Welcome screen](/img/welcome_screen_desktop.png)
        The top of the screen holds the banner for updates, the link to this documentations, and the <Gear/> config icon. Finally, to the right of the <Gear/> config symbol you have a drop down menu for controlling when this banner will appear (always/never/on updates).
		The "Files" section in the major area of the left. There, you can do the typical operations:
		    - Select the display type (grid or list)
		    - Select the [source storage](storage) of the files
		    - Sort the display order of the files
		    - Add a folder, file, template, or import files by clicking the <Plus/> plus sign
		    - Type the direct path to a desired location (the Location field),
		    - Search for files
        Finally, to the right, you have the quick start display with the templates available in the current location. For a fresh install this includes the light and dark template
    </TabItem>
    <TabItem value="mobile">
        When opening Butterfly on a mobile device you will be presented with a screen as this
        ![Welcome screen first part](/img/welcome_screen_mobile_1.png)   
        The top of the screen holds the banner for updates, and below it you can find the documnentation link, and next to it the <Gear/> config icon. Finally, to the right of the <Gear/> config symbol you have a drop down menu for controlling when this banner will appear (always/never/on updates).
        Below those, you can find the quick start section holding the templates avialable to you. By defaule, the templates are the light and dark templates. 
        Scrolling down, you will see the file interface:
        \
        ![Welcome screen second part](/img/welcome_screen_mobile_2.png)  
		The "Files" section in the major area of the left. There, you can do the typical operations:
		- Select the display type (grid or list)
		- Select the [source storage](storage) of the files
		- Sort the display order of the files
		- Add a folder, file, template, or import files by clicking the <Plus/> plus sign
		- Type the direct path to a desired location (the Location field),
		- Search for files
	</TabItem>
</Tabs>

Once opening a document by selecting a template or an existing file, you will get to the **Document View**

## The Document View

You can return from the document view to the document list with the back action of your device. As with the main view, the document display changes based on your device.

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
		butterfly button to open the menu. Next to it there is the name field that displays the name of the note. You can rename the note by typing a new name into that field and saving it using the <FloppyDisk/> save button. Finally you can <MagnifyingGlass/> search for elements within the note.
		\
		At the top right of the screen you have the toolbar\
		![toolbar](/img/document_view_toolbar.png)\
		By default this bar has the <ScribbleLoop/> lasso tool; the <Pen/> pen tool; the <Path/> path erase tool; the <ArrowCounterClockwise/> undo and <ArrowClockwise/> redo butons, and the <Hand/> hand tool. Then you have the <Plus/> button to add elements to the tool bar, the <Wrench/> button to configure the document, and finally the <Lock/> tool to look the zoom and/or the position of the screen. 
		### Important notes
		1. If some of the element on the toolbar are not visible to you, click and drag (or swipe) left and right to reveal further tools. 
		2. After selecting a tool, a small menu will appear. Long clicking the tool again will allow you to drag it to a new position
		3. You can add more tools to the toolbar by clicking the <Plus/> plus sign. 
	</TabItem>
	<TabItem value="mobile">
		In the mobile view, you'll have at the top the file bar\
	    ![file_bar](/img/document_view_file_bar.png)\
		This holds, from left to right, the 
		[<img alt="logo" src="/img/logo.png" width="16"/>](/img/logo.png)
		butterfly button to open the menu. Next to it there is the name field that displays the name of the note. You can rename the note by typing a new name into that field and saving it using the <FloppyDisk/> save button. Finally you can <MagnifyingGlass/> search for elements within the note.
		\
		At the bottom of the screen you have the toolbar\
		![toolbar](/img/document_view_toolbar.png)\
		By default this bar has the <ScribbleLoop/> lasso tool; the <Pen/> pen tool; the <Path/> path erase tool; the <ArrowCounterClockwise/> undo and <ArrowClockwise/> redo butons, and the <Hand/> hand tool. Then you have the <Plus/> button to add elements to the tool bar, the <Wrench/> button to configure the document, and finally the <Lock/> tool to look the zoom and/or the position of the screen. 
		### Important notes
		1. If some of the element on the toolbar are not visible to you, or swipe left and right to reveal further elements. 
		2. After selecting a tool, a small menu will appear to configure the it. Long clicking the tool again will allow you to drag it to a new position
		3. You can add more tools to the toolbar by clicking the <Plus/> plus sign. 
	</TabItem>
</Tabs>
