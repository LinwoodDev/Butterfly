---
title: "Создайте свой собственный"
---

1. Install git and the Flutter version specified in `app/pubspec.yaml`
2. Клонировать репозиторий
3. Перейдите в каталог приложения
4. Используйте инструмент flutter для компиляции приложения
   - `flutter build apk`
   - `flutter build appbundle`
   - `flutter build web --wasm --release --no-web-resources-cdn`, then
     `dart pub get -C ../tools` and `dart run ../tools/build_web_service_worker.dart` to enable offline loading
   - `flutter build linux`
   - `flutter build windows`
   - `flutter build ios --release --no-codesign`\
     after that, create a folder named "Payload", copy Runner.app into it and zip the payload folder. Then rename ".zip" to ".ipa".
5. Скомпилированные файлы находятся в каталоге сборки

## Offline builds

The packaging helper separates preparing dependencies online from building with
local dependencies. It supports Android, Linux, Windows, macOS, iOS, and web from
one Dart command. Install the Flutter version specified in `app/pubspec.yaml` and
[rustup](https://rustup.rs), plus the tools for your target:

| `--platform` | Build host               | Additional prerequisites                                                          | Output under `app/build/`                                             |
| ------------ | ------------------------ | --------------------------------------------------------------------------------- | --------------------------------------------------------------------- |
| `android`    | Linux, Windows, or macOS | Java and Android SDK with accepted licenses                                       | `app/outputs/flutter-apk/app-<flavor>-release.apk`                    |
| `linux`      | Linux                    | Flutter's Linux development libraries, CMake, Ninja, Clang, and libsecret headers | `linux/<arch>/<flavor>/release/bundle/`                               |
| `windows`    | Окна                     | Visual Studio's Flutter desktop build tools                                       | `windows/<arch>/<flavor>/runner/Release/`                             |
| `macos`      | macOS                    | Xcode and the project's Apple dependency tooling                                  | `macos/Build/Products/Release/butterfly.app`                          |
| `ios`        | macOS                    | Xcode and the project's Apple dependency tooling                                  | `ios/iphoneos/Runner.app` (unsigned)               |
| `web`        | Linux, Windows, or macOS | `wasm-pack` on PATH                                                               | `web/`, including the OneNote Wasm library and offline service worker |

Run these commands from the repository root, choosing the same platform for both
steps. If omitted, `--platform` defaults to the host OS:

```sh
# Network access is needed for this step, including an initial release build.
dart pub get -C tools --enforce-lockfile
dart tools/build_offline.dart prepare --platform android --flavor production

# Disconnect networking. This step uses the prepared local dependencies.
dart tools/build_offline.dart build --platform android
```

For example, use `--platform linux` for a Linux desktop bundle or `--platform web`
for the web app. Use `--flavor nightly` for the nightly app; production is the
default. The build command remembers the prepared flavor and architectures;
changing them requires preparing again.

Additional `--dart-define=KEY=VALUE` options are remembered too. The build command
also accepts `--analyze-size` and `--code-size-directory` for size reports.

Android includes ARMv7, ARM64, and x86_64 by default. Pass
`--target-platform android-arm64` to prepare a smaller APK. Linux and Windows
default to the host architecture. Linux also accepts an explicit matching target,
such as `--target-platform linux-arm64` on an ARM64 host. Windows uses the host
architecture selected by Flutter. macOS prepares both Intel and Apple Silicon
libraries, and iOS builds for ARM64 devices without code signing. The web build
also prepares Rust nightly with `rust-src` for the OneNote Wasm compilation.

Dependencies are stored in `.offline-build/<platform>`, including a private Pub
cache, Cargo cache, PDFium archives where used, and Android's Gradle cache.
Use `--cache-dir /path/to/cache` on both commands to choose another location.
Flutter and native SDK components, installed Rust toolchains, and native build
tool caches remain in their installed locations. Keep these, the prepared cache,
checkout, and platform build directories on the same machine between the two
steps. Apple builds also need their prepared CocoaPods/Swift package dependencies;
web builds need the prepared `wasm-pack` tools and their cache.
Keep `tools/.dart_tool` and the helper's installed Pub dependencies available too.
Invoke the script directly as shown above so Dart does not resolve dependencies
automatically during the offline step.

The helper replaces the PDFium download hook only in its private Pub cache. It
supports the Android, Linux, Windows, and macOS archive layouts; iOS retains its
existing Core Graphics implementation, and web uses its packaged Wasm assets.
During the offline build, Pub uses `--offline --enforce-lockfile`, Android's Gradle
uses offline dependency resolution, and Cargo uses offline mode and a locked
dependency graph.
Changed lockfiles, build configuration, or PDFium archives require preparing again.
Missing dependencies cause the build to fail. To verify that SDKs and other build
tools also make no unexpected network requests, run the build with networking
disabled while allowing loopback for local build tool processes.

The existing Android, Linux, Windows, macOS, iOS, and web CI jobs run the helper's
prepare and build steps. Android reuses its legacy-packaging build for the offline
check, and the x86_64 desktop jobs reuse their size-analysis builds. Other targets
perform an incremental offline rebuild in the same job. Android, Linux, and web
checks run with only loopback networking; Windows and Apple builds use the helper's
offline dependency resolution with their prepared native tool caches.

### Locally built PDFium

Packagers can supply their own PDFium archives instead of downloading upstream
binaries:

```sh
dart tools/build_offline.dart prepare --platform android \
  --pdfium-dir /path/to/pdfium/archives
dart tools/build_offline.dart build --platform android
```

`PDFIUM_ARCHIVE_DIR` is an alternative to `--pdfium-dir`. The directory must contain
the selected target's gzip-compressed tar archives:

| Platform | Archive names                        | Library inside each archive |
| -------- | ------------------------------------ | --------------------------- |
| Android  | `pdfium-android-{arm,arm64,x64}.tgz` | `lib/libpdfium.so`          |
| Linux    | `pdfium-linux-{arm64,x64}.tgz`       | `lib/libpdfium.so`          |
| Окна     | `pdfium-win-{arm64,x64}.tgz`         | `bin/pdfium.dll`            |
| macOS    | `pdfium-mac-{arm64,x64}.tgz`         | `lib/libpdfium.dylib`       |

Only selected architectures are required. Each library must be a regular file
for the corresponding ABI. iOS and web do not need these native archives. Build
PDFium from the Chromium branch specified by `_pdfiumRelease` in the locked
`pdfium_dart` package's `hook/build.dart`; currently this is `chromium/7811`.

The helper checks archive contents and records SHA-256 hashes during preparation.
These hashes detect changes between the two steps; they do not establish the
provenance of supplied binaries. F-Droid's separate steps for building PDFium from
source still apply. The helper expects those archives to exist during preparation.

After using the helper, running `flutter pub get` in `app` restores the normal
dependency configuration for development. Run the helper's build command again to
select its private cache.
