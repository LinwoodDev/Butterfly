# Butterfly is packaged from an already-built Flutter release bundle, so there
# is no useful debug subpackage to generate. RPM 4.20+ uses the boolean macro;
# older RPM releases use the debug_package template.
%global _enable_debug_packages 0
%global debug_package %{nil}

Name:           linwood-butterfly
Version:        1.0.0
Release:        1%{?dist}
Summary:        Take notes, draw freely, and organize ideas across an endless workspace
BuildArch:      %{_target_cpu}
URL:            https://github.com/LinwoodDev/Butterfly
License:        AGPLv3
Source0:        %{name}-%{version}.tar.gz

Requires:       bash

%description
Butterfly is an open-source app for people who think better with space around their ideas. Instead of writing everything from top to bottom on a fixed page, you get an endless workspace where you can place notes, sketches, diagrams, images, and documents wherever they make sense.

Use it for class notes, meeting notes, research, math, worksheets, planning, whiteboarding, storyboards, product sketches, or any project that starts messy and needs room to grow. Write by hand with a stylus, touch, or mouse, type text and Markdown, add shapes and lines, place images and photos, import PDFs, SVGs, and image files, then export your work as PDF, SVG, images, or portable Butterfly files.

Butterfly tries to stay out of your way while you work. Recent files, quick-start templates, search, folders, imports, page navigation, and tool settings are close when you need them, but the document stays at the center. You can begin with a plain page, ruled paper, a grid, dotted paper, music paper, or your own template.

As your document grows, Butterfly gives you ways to keep it understandable. Split work into pages and page folders, use layers, mark important places with areas and waypoints, save reusable parts in packs, and keep palettes and text styles ready for the next document. Almost everything you add remains editable, so you can move, resize, recolor, reorder, and refine your work later instead of starting over.

Your files stay under your control. Work offline, store documents on your device, choose a different data directory, or connect WebDAV and Nextcloud if you want your own sync setup. There is no required account, no required subscription, and no required proprietary cloud.

Butterfly is free, community translated, available on phones, tablets, desktops, and the web, and developed in public under the AGPL-3.0 license.

%prep
%setup -q

%install
rm -rf $RPM_BUILD_ROOT
mkdir -p $RPM_BUILD_ROOT/%{_bindir}
mkdir -p $RPM_BUILD_ROOT/%{_datadir}/%{name}
mkdir -p $RPM_BUILD_ROOT/%{_datadir}/pixmaps

# Copy binaries and architecture-specific files
cp %{name} $RPM_BUILD_ROOT/%{_datadir}/%{name}
cp -R lib $RPM_BUILD_ROOT/%{_datadir}/%{name}
cp -R data $RPM_BUILD_ROOT/%{_datadir}/%{name}

# Create symlink for the binary
ln -s %{_datadir}/%{name}/%{name} $RPM_BUILD_ROOT/%{_bindir}/%{name}

# Install the desktop file
desktop-file-install --dir=$RPM_BUILD_ROOT/usr/share/applications %{name}.desktop

%clean
rm -rf $RPM_BUILD_ROOT

%files
%{_bindir}/%{name}
%{_datadir}/%{name}
/usr/share/applications/

%changelog
