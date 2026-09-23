---
title: Area tool
---

The area tool allows you to create, edit and remove areas.

For an overview of how areas work, see [Areas](../../areas).

## क्रियाएँ

|         माउस        |      टच      |       Action      |
| :-----------------: | :----------: | :---------------: |
| Left click and drag | Tap and drag | Create a new area |
|     Middle click    |  Two fingers |    Move canvas    |
|     Right click     |   Long tap   |     Edit area     |

## Configuration {#configuration}

|    Property |   Default   | विवरण                                                                                                                                                                                                                                                                                                                                                                                                            |
| ----------: | :---------: | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|   नाम पूछें |    false    | Whether a name prompt will appear before creation.                                                                                                                                                                                                                                                                                                                                               |
|       Color | सेट नहीं है | Optional color used to display the area.                                                                                                                                                                                                                                                                                                                                                         |
|     प्रीसेट |     none    | Size and aspect ratio presets in the area size controls.                                                                                                                                                                                                                                                                                                                                         |
|      चौड़ाई |     `0`     | The fixed width for new areas. If set to `0`, this setting will be ignored.                                                                                                                                                                                                                                                                                                      |
|       ऊंचाई |     `0`     | The fixed height for new areas. If set to `0`, this setting will be ignored.                                                                                                                                                                                                                                                                                                     |
| पहलू अनुपात |     `0`     | The fixed aspect ratio for new areas. Select a preset from the segmented control or enter a custom value in the input field. An aspect ratio is defined as width / height, so values less than `1` will be taller than they are wide, and values greater than `1` will be wider than they are tall. If set to `0`, this setting will be ignored. |

There are three aspect ratio presets:

- Square (1:1)
- Page portrait (1/sqrt(2)) - This is the default aspect ratio of an A4 page in portrait mode.
- Page landscape (sqrt(2)) - This is the default aspect ratio of an A4 page in landscape mode.
