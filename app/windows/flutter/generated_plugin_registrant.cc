//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <camera_windows/camera_windows.h>
#include <connectivity_plus/connectivity_plus_windows_plugin.h>
#include <dynamic_color/dynamic_color_plugin_c_api.h>
#include <flutter_secure_storage_windows/flutter_secure_storage_windows_plugin.h>
#include <screen_retriever_windows/screen_retriever_windows_plugin_c_api.h>
#include <share_plus/share_plus_windows_plugin_c_api.h>
#include <url_launcher_windows/url_launcher_windows.h>
#include <window_manager/window_manager_plugin.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  CameraWindowsRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("CameraWindows"));
  ConnectivityPlusWindowsPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("ConnectivityPlusWindowsPlugin"));
  DynamicColorPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("DynamicColorPluginCApi"));
  FlutterSecureStorageWindowsPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("FlutterSecureStorageWindowsPlugin"));
  ScreenRetrieverWindowsPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("ScreenRetrieverWindowsPluginCApi"));
  SharePlusWindowsPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("SharePlusWindowsPluginCApi"));
  UrlLauncherWindowsRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("UrlLauncherWindows"));
  WindowManagerPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("WindowManagerPlugin"));
}
