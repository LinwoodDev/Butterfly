---
title: Importing from Microsoft OneNote
---

:::note
This feature is only available in Butterfly 2.6.0-beta.1 and later.
:::

Butterfly can convert Microsoft OneNote sections and packaged notebooks into
Butterfly documents.

## Supported file types

Butterfly supports these OneNote formats:

- `.one` — a single OneNote section
- `.onepkg` — a packaged OneNote notebook containing multiple sections and
  section groups

For transferring an entire notebook, `.onepkg` is usually the most convenient
format. Use `.one` when you only want to transfer one section.

Butterfly does not currently import loose `.onetoc2` files or a ZIP file
downloaded from OneNote for the web directly.

:::note
Keep the original OneNote files until you have reviewed the imported document.
Importing is a conversion, and some OneNote features cannot be represented
exactly in Butterfly.
:::

## Exporting from the OneNote desktop app

The instructions below apply to the OneNote desktop application on Windows,
as included with Microsoft 365 and recent desktop versions of Microsoft
Office.

Before exporting, allow OneNote to finish synchronizing the notebook. This is
especially important for notebooks stored in OneDrive or SharePoint.

### Exporting an entire notebook

1. Open the notebook in the OneNote desktop application.
2. Select **File** in the upper-left corner.
3. Select **Export**.
4. Under **Export Current**, select **Notebook**.
5. Under **Select Format**, select **OneNote Package (`*.onepkg`)**.
6. Select **Export**.
7. Choose a local folder and enter a name for the exported file.
8. Select **Save**.

You can now import the resulting `.onepkg` file into Butterfly.

The package contains the notebook's sections and section groups. Butterfly
uses this structure when naming and organizing the imported pages.

:::note
The available formats can differ between OneNote versions. If **OneNote
Package (`*.onepkg`)** is not shown, export the sections separately as `.one`
files using the instructions below.
:::

### Exporting a single section

1. Open the notebook in the OneNote desktop application.

2. Select the section that you want to export.

3. Select **File**.

4. Select **Export**.

5. Under **Export Current**, select **Section**.

6. Under **Select Format**, select **OneNote Section (`*.one`)**.

   Depending on your OneNote version, this option may be named
   **OneNote 2010–2016 Section (`*.one`)**.

7. Select **Export**.

8. Choose a local folder and enter a name for the section.

9. Select **Save**.

Repeat these steps for every section that you want to move to Butterfly.

Exporting sections individually does not preserve the complete notebook
hierarchy in one file. Each `.one` file is imported separately.

### Do not export as PDF for a OneNote import

The OneNote export screen also offers formats such as PDF and XPS. These
formats contain a rendered copy of the pages rather than their original
OneNote structure.

Choose `.one` or `.onepkg` when you want Butterfly to convert editable content
such as text, handwriting, images, tables, and attachments.

Use PDF import only when a visual, non-editable representation of the OneNote
pages is sufficient.

## Alternative: downloading a notebook from OneNote for the web

Microsoft also provides a notebook download through OneNote for the web.

This method is currently limited to notebooks stored in a personal OneDrive
account. It is not available for notebooks stored in a work or school
OneDrive account or in SharePoint.

1. Open OneNote for the web in a browser.
2. Find the notebook in the notebook list.
3. Right-click the notebook.
4. Select **Export notebook**.
5. Confirm the export.
6. Wait for the notebook to be downloaded.
7. Extract the downloaded ZIP archive.

The extracted notebook usually contains individual `.one` section files and
an `.onetoc2` table-of-contents file.

Butterfly cannot currently import the downloaded ZIP archive or the
`.onetoc2` file directly. Import the contained `.one` section files one at a
time.

For a complete notebook import that preserves more of its hierarchy, prefer a
`.onepkg` export from the Windows desktop application when that option is
available.

## Importing the file into Butterfly

1. Open Butterfly.
2. Open an existing Butterfly document or create a new one.
3. Open the **Add** dialog.
4. Select **OneNote**.
5. Choose the exported `.one` or `.onepkg` file.
6. Wait while Butterfly reads and converts the file.
7. Complete any dialogs concerning embedded XPS printouts.
8. Review the imported pages.

A `.one` file imports one section. A `.onepkg` file can contain multiple
sections and section groups.

Butterfly creates a page for each supported OneNote page and attempts to
preserve supported content, including:

- Text and basic rich-text formatting
- Handwriting and ink strokes
- Images
- Tables
- Attached files
- Printed document pages, when their XPS data can be converted to PDF

Section and section-group names are used as part of the imported Butterfly
page paths.

## Import limitations

OneNote and Butterfly use different document models. The importer therefore
cannot guarantee a pixel-perfect or fully editable copy of every page.

After importing, check in particular:

- Text positioning and wrapping
- Fonts that are not installed on the current device
- Complex formatting
- Tables and nested content
- Equations and uncommon OneNote objects
- Embedded files
- Page backgrounds
- Printed documents
- Internal links between OneNote pages
- Password-protected or encrypted sections

Unsupported or unknown OneNote objects may be omitted. Parser warnings may
also be stored with the imported document or page.

For large notebooks, importing can take some time. Notebooks containing many
images, attachments, or printed documents also require more memory and disk
space.

## Printed documents and XPS files

OneNote may store inserted file printouts as XPS files. Butterfly displays
these printouts as PDF elements, so the XPS data must first be converted to
PDF.

### Automatic conversion

On native desktop platforms, Butterfly first tries to run the following
command:

```text
xpstopdf
```

Automatic conversion only works when `xpstopdf` is installed and available
through the system's `PATH`.

When the command is missing or conversion fails, Butterfly opens the manual
conversion workflow.

Automatic XPS conversion is unavailable in the web version of Butterfly.

### Manual conversion

When Butterfly asks you to convert an XPS printout manually:

1. Select **Convert manually**.
2. Select **Export XPS**.
3. Save the exported `.xps` file somewhere you can find it.
4. Convert the XPS file to PDF using an external application.
5. Return to Butterfly.
6. Select **Select converted PDF**.
7. Select the corresponding PDF file.

Butterfly verifies that the selected file appears to be a valid PDF before
continuing the import.

Canceling the file picker returns to the conversion dialog and does not cancel
the complete OneNote import.

You can also choose:

- **Skip this file** — omit only the current printout
- **Skip all XPS files** — omit all remaining XPS printouts while importing
  the rest of the notebook
- **Export XPS again** — save another copy of the current XPS file

Skipping an XPS printout does not skip the OneNote page or cancel the remaining
notebook import. Only the affected printed document is omitted.

:::caution[MuPDF and OneNote XPS files]
MuPDF cannot handle the XPS files produced or embedded by OneNote correctly.

Do not use MuPDF-based tools, including `mutool`, to convert these files.
Use a different XPS-to-PDF converter.
:::

When several OneNote printout pages refer to the same XPS document, Butterfly
reuses the converted PDF instead of asking for the same conversion repeatedly.

## Troubleshooting

### The OneNote option is missing in Butterfly

Make sure you are using a Butterfly version that includes OneNote import
support. The importer accepts files ending in `.one` and `.onepkg`.

### OneNote does not offer a `.onepkg` format

The available export formats depend on the OneNote edition and account
configuration.

Export each section as a `.one` file instead. For personal OneDrive notebooks,
you can also download the notebook through OneNote for the web, extract the
archive, and import its `.one` files separately.

### Butterfly asks for `xpstopdf`

The notebook contains one or more printed documents stored as XPS.

Install `xpstopdf` and ensure that it is available through `PATH`, or use the
manual conversion workflow.

### The converted PDF is rejected

Make sure you selected the actual converted PDF rather than the original XPS
file or a renamed file.

Changing a filename from `.xps` to `.pdf` does not convert the document.

### A printout is missing after import

The XPS conversion may have failed or the file may have been skipped. Import
the notebook again and provide a converted PDF when Butterfly displays the
conversion dialog.

### Some content is missing or formatted differently

The object may not yet be supported by the OneNote parser or by Butterfly's
document model. Keep the original OneNote notebook and compare it with the
imported result.

## Подяки

Butterfly's OneNote import uses Dart and Flutter bindings based on
[onenote.rs](https://github.com/msiemens/onenote.rs), an open-source Microsoft
OneNote file parser implemented in Rust.

Special thanks to Matthias Siemens and all contributors to `onenote.rs` for
their work on understanding and implementing the OneNote file formats.
Without their project, native OneNote file import in Butterfly would not be
possible.

`onenote.rs` is an independent open-source project and is not affiliated with
or endorsed by Microsoft.
