---
title: Introduction
id: intro
slug: /intro
sidebar_position: 1
---
import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';
import { Gear, Plus } from "@phosphor-icons/react";


![Banner](/img/banner.png)

---

> Welcome to Butterfly, the opensource note app.

Butterfly is a note taking up that is aiming for unified experience across devices. Butterfly's approach is for minimalistic view of the drawing canvas while maximizing the user's control over the app.

## Getting started
> You can use the sidebar to navigate quicly through the wiki.

To start working on the app you have two options:
1. [Downloads](/downloads) the app version that is appropriate for your platform (Butterfly can run on most mobile, desktop, and web platfroms). 
2. Use [web version](https://butterfly.linwood.dev) if you cannot find your platform or if you don't want to install it on it. See [here](storage#web) about file storage on the web version.

>Once you open the app, continue reading. 


## Main view

![Main view](main.png)

The main view is composed of several elements
<Tabs
    defaultValue = "desktop"
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
	

## The main document view. 
With the top left button you can go back to the document list. The document name will be displayed on the right of it. Undo, redo and file options are in the top right corner.

Below it, you can find the toolbar. Left, you can switch between view and edit mode. Right to it, there you find the zoom options. In the top right corner there are the tool options.

- The view toolbar options are background, export and save.
- The edit toolbar options are the tools. You can find [here](background) more.
