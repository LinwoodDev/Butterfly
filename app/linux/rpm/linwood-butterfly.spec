Name:           linwood-butterfly
Version:        1.0.0
Release:        1%{?dist}
Summary:        Powerful, minimalistic, cross-platform, opensource note-taking app
BuildArch:      %{_target_cpu}
URL:            https://github.com/LinwoodDev/Butterfly
License:        AGPLv3
Source0:        %{name}-%{version}.tar.gz

Requires:       bash

%description
Butterfly is a note app where your ideas come first. You can paint, add texts and export them easily on every device. This app works on Android, Windows, Linux, and in the web.

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
