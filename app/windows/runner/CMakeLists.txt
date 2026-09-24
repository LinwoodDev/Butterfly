cmake_minimum_required(VERSION 3.14)
project(runner LANGUAGES CXX)

# Define the application target. To change its name, change BINARY_NAME in the
# top-level CMakeLists.txt, not the value here, or `flutter run` will no longer
# work.
#
# Any new source files that you add to the application should be added here.
add_executable(${BINARY_NAME} WIN32
  "flutter_window.cpp"
  "main.cpp"
  "utils.cpp"
  "win32_window.cpp"
  "${FLUTTER_MANAGED_DIR}/generated_plugin_registrant.cc"
  "Runner.rc"
  "runner.exe.manifest"
)

# Apply the standard set of build settings. This can be removed for applications
# that need different build settings.
apply_standard_settings(${BINARY_NAME})

# Add preprocessor definitions for the build version.
target_compile_definitions(${BINARY_NAME} PRIVATE "FLUTTER_VERSION=\"${FLUTTER_VERSION}\"")
target_compile_definitions(${BINARY_NAME} PRIVATE "FLUTTER_VERSION_MAJOR=${FLUTTER_VERSION_MAJOR}")
target_compile_definitions(${BINARY_NAME} PRIVATE "FLUTTER_VERSION_MINOR=${FLUTTER_VERSION_MINOR}")
target_compile_definitions(${BINARY_NAME} PRIVATE "FLUTTER_VERSION_PATCH=${FLUTTER_VERSION_PATCH}")
target_compile_definitions(${BINARY_NAME} PRIVATE "FLUTTER_VERSION_BUILD=${FLUTTER_VERSION_BUILD}")

# Flutter exposes the value passed to `--flavor` as FLUTTER_APP_FLAVOR. Keep
# native executable metadata in sync with the Dart-side nightly branding.
if(FLUTTER_APP_FLAVOR MATCHES "^(nightly|development|dev)$")
  target_compile_definitions(${BINARY_NAME} PRIVATE "BUTTERFLY_NIGHTLY")
endif()

# Disable Windows macros that collide with C++ standard library functions.
target_compile_definitions(${BINARY_NAME} PRIVATE "NOMINMAX")

# Add dependency libraries and include directories. Add any application-specific
# dependencies here.
target_link_libraries(${BINARY_NAME} PRIVATE flutter flutter_wrapper_app)
target_link_libraries(${BINARY_NAME} PRIVATE "dwmapi.lib")
target_include_directories(${BINARY_NAME} PRIVATE "${CMAKE_SOURCE_DIR}")

# Explorer loads this COM DLL in its thumbnail/preview host. Keep it separate
# from the Flutter runner so Explorer never starts the app to inspect a note.
set(PREVIEW_DIR "${CMAKE_CURRENT_SOURCE_DIR}/note_preview")
add_library(butterfly_note_preview SHARED
  "${PREVIEW_DIR}/shell_preview.cpp"
  # Export the COM entry points without changing their Windows SDK declarations.
  "${PREVIEW_DIR}/shell_preview.def"
)
target_compile_features(butterfly_note_preview PRIVATE cxx_std_17)
target_compile_definitions(butterfly_note_preview PRIVATE UNICODE _UNICODE NOMINMAX)
if(FLUTTER_APP_FLAVOR MATCHES "^(nightly|development|dev)$")
  target_compile_definitions(butterfly_note_preview PRIVATE BUTTERFLY_NIGHTLY)
endif()
target_link_libraries(butterfly_note_preview PRIVATE ole32 windowscodecs gdi32 user32 uuid)
install(TARGETS butterfly_note_preview RUNTIME DESTINATION "${CMAKE_INSTALL_PREFIX}"
  COMPONENT Runtime)

# Run the Flutter tool portions of the build. This must not be removed.
add_dependencies(${BINARY_NAME} flutter_assemble)
