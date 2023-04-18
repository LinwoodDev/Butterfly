<div align="center">

<img src="https://raw.githubusercontent.com/LinwoodDev/butterfly/develop/app/images/logo.png" width="350px" />

# Butterfly

> 🎨 Powerful, minimalistic, cross-platform, opensource note-taking app 🎨

[![Latest release)](https://img.shields.io/github/v/release/LinwoodDev/butterfly?color=EBB733&style=for-the-badge&logo=github&logoColor=EBB733)](https://github.com/LinwoodDev/butterfly/releases)
[![GitHub License badge](https://img.shields.io/github/license/LinwoodDev/dev_doctor?color=EBB733&style=for-the-badge&logo=data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxOTIiIGhlaWdodD0iMTkyIiBmaWxsPSIjZWJiNzMzIiB2aWV3Qm94PSIwIDAgMjU2IDI1NiI%2BPHJlY3Qgd2lkdGg9IjI1NiIgaGVpZ2h0PSIyNTYiIGZpbGw9Im5vbmUiPjwvcmVjdD48cmVjdCB4PSIzMiIgeT0iNDgiIHdpZHRoPSIxOTIiIGhlaWdodD0iMTYwIiByeD0iOCIgc3Ryb2tlLXdpZHRoPSIxNiIgc3Ryb2tlPSIjZWJiNzMzIiBzdHJva2UtbGluZWNhcD0icm91bmQiIHN0cm9rZS1saW5lam9pbj0icm91bmQiIGZpbGw9Im5vbmUiPjwvcmVjdD48bGluZSB4MT0iNzYiIHkxPSI5NiIgeDI9IjE4MCIgeTI9Ijk2IiBmaWxsPSJub25lIiBzdHJva2U9IiNlYmI3MzMiIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCIgc3Ryb2tlLXdpZHRoPSIxNiI%2BPC9saW5lPjxsaW5lIHgxPSI3NiIgeTE9IjEyOCIgeDI9IjE4MCIgeTI9IjEyOCIgZmlsbD0ibm9uZSIgc3Ryb2tlPSIjZWJiNzMzIiBzdHJva2UtbGluZWNhcD0icm91bmQiIHN0cm9rZS1saW5lam9pbj0icm91bmQiIHN0cm9rZS13aWR0aD0iMTYiPjwvbGluZT48bGluZSB4MT0iNzYiIHkxPSIxNjAiIHgyPSIxODAiIHkyPSIxNjAiIGZpbGw9Im5vbmUiIHN0cm9rZT0iI2ViYjczMyIgc3Ryb2tlLWxpbmVjYXA9InJvdW5kIiBzdHJva2UtbGluZWpvaW49InJvdW5kIiBzdHJva2Utd2lkdGg9IjE2Ij48L2xpbmU%2BPC9zdmc%2B)](https://github.com/LinwoodDev/butterfly/blob/main/LICENSE)
[![GitHub Repo stars](https://img.shields.io/github/stars/LinwoodDev/butterfly?color=EBB733&logo=github&logoColor=EBB733&style=for-the-badge)](https://github.com/LinwoodDev/butterfly)
[![Matrix badge](https://img.shields.io/matrix/linwood:matrix.org?style=for-the-badge&color=EBB733&logo=matrix&logoColor=EBB733&label=Matrix)](https://linwood.dev/matrix)
[![Discord badge](https://img.shields.io/discord/735424757142519848?style=for-the-badge&color=EBB733&logo=discord&logoColor=EBB733&label=Discord)](https://discord.linwood.dev)
[![Download](https://img.shields.io/github/downloads/LinwoodDev/butterfly/total?color=EBB733&style=for-the-badge&logo=data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxOTIiIGhlaWdodD0iMTkyIiBmaWxsPSIjZWJiNzMzIiB2aWV3Qm94PSIwIDAgMjU2IDI1NiI+PHJlY3Qgd2lkdGg9IjI1NiIgaGVpZ2h0PSIyNTYiIGZpbGw9Im5vbmUiPjwvcmVjdD48cG9seWxpbmUgcG9pbnRzPSI4NiAxMTAuMDExIDEyOCAxNTIgMTcwIDExMC4wMTEiIGZpbGw9Im5vbmUiIHN0cm9rZT0iI2ViYjczMyIgc3Ryb2tlLWxpbmVjYXA9InJvdW5kIiBzdHJva2UtbGluZWpvaW49InJvdW5kIiBzdHJva2Utd2lkdGg9IjE2Ij48L3BvbHlsaW5lPjxsaW5lIHgxPSIxMjgiIHkxPSI0MCIgeDI9IjEyOCIgeTI9IjE1MS45NzA1NyIgZmlsbD0ibm9uZSIgc3Ryb2tlPSIjZWJiNzMzIiBzdHJva2UtbGluZWNhcD0icm91bmQiIHN0cm9rZS1saW5lam9pbj0icm91bmQiIHN0cm9rZS13aWR0aD0iMTYiPjwvbGluZT48cGF0aCBkPSJNMjE2LDE1MnY1NmE4LDgsMCwwLDEtOCw4SDQ4YTgsOCwwLDAsMS04LThWMTUyIiBmaWxsPSJub25lIiBzdHJva2U9IiNlYmI3MzMiIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCIgc3Ryb2tlLXdpZHRoPSIxNiI+PC9wYXRoPjwvc3ZnPg==)](https://docs.butterfly.linwood.dev/downloads)
</div>

<p align="center">
    <a href="http://docs.butterfly.linwood.dev"><b>Website</b></a> •
    <a href="http://docs.butterfly.linwood.dev/downloads"><b>Download</b></a> •
    <a href="https://linwood.dev/matrix"><b>Matrix</b></a> •
    <a href="https://go.linwood.dev/discord"><b>Discord</b></a> •
    <a href="https://twitter.com/LinwoodDev"><b>Twitter</b></a> •
    <a href="CONTRIBUTING.md"><b>Contribute</b></a>
</p>  

---

**2.0 will be released soon...**
**It would be nice if you help me translating the app: <https://linwood.crowdin.com/butterfly>**

Butterfly is a note taking app where your ideas come first. You can paint, add texts, and export them easily on every device. This app works on android, windows, linux, and in the web.

## Features

* **⚡ Simple and intuitive** Every tool is in the right place. Open the app and start drawing. Change your tools by clicking on it.
* **🎨 Customizable:** Change everything to your needs. Choose your custom color, create a palette, and add your pages to the paper. The paper has an infinite size, perfect for your ideas and notes.
* **📝 Support your favorite formats:** Import and export are supported for images, pdf and svg. Register the app to open these files to edit them.
* **📱 Works on every device:** The app is available for android, windows, linux, and in the web. You can use it on your phone, tablet, or computer.
* **💻 Choose where your data is stored:** You can choose to store your data locally or in your favorite cloud (webdav). You can also export your data to a file and import it again.
* **🌐 Available in many languages:** The app is available in many languages. Help us to translate this app to your language.
* **📚 FOSS:** The app is open source and free. You can contribute to the project and help to make it better.
* **🔋 Use it offline:** You can use the app offline. You can draw, paint, and export your notes without an internet connection.
* **🖊️ Use your favorite stylus:** The app supports stylus and touch devices. You can draw and paint with your favorite stylus.
* **📜 Write text:** You can write text on your notes. You can change the font, size, and color.
* **📸 Take photos:** You can take photos and add them to your notes. You can also import photos from your gallery.
* **⚙️ Editable:** You can change the size, color, and position of every element after you added it to your note.
* **🟦 Add shapes:** You can add shapes to your notes. You can choose between a rectangle, circle and line.
* **🔳 Structure your notes:** Add areas and waypoints to your notes to keep them organized.

Try it [now](http://docs.butterfly.linwood.dev/downloads)!

---

## Contributing

We are happy to see that you are interested in contributing to Butterfly.
To get started, visit [the contributing guide](CONTRIBUTING.md).

## License

The code is open source and licensed under the [AGPL-3.0](./LICENSE) license.
All images in `app/images/` except `powered-by-vercel.svg` and all images in `docs/` are licensed under the [CC-BY-4.0](./BRANDING_LICENSE) license.
The files in `api` are licensed under the [Apache-2.0](./api/LICENSE) license instead of the AGPL-3.0 license to allow the use of the API without the need to open source the code (for example for extensions or other external services).
