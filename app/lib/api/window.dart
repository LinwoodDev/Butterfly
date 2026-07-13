import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:window_manager/window_manager.dart';

const _windowChannel = MethodChannel('linwood.dev/butterfly/window');

Future<void> applyNativeTitleBar(bool nativeTitleBar) async {
  if (kIsWeb) return;

  // This still handles GtkHeaderBar on GNOME and the regular desktop
  // implementations on Windows, macOS and X11.
  await windowManager.setTitleBarStyle(
    nativeTitleBar ? TitleBarStyle.normal : TitleBarStyle.hidden,
    windowButtonVisibility: nativeTitleBar,
  );

  if (defaultTargetPlatform == TargetPlatform.linux) {
    // gtk_window_set_decorated() is ineffective in GTK 3's Wayland backend.
    // Ask GDK to negotiate KDE's server/client decoration mode directly.
    await _windowChannel.invokeMethod<void>(
      'setNativeTitleBar',
      nativeTitleBar,
    );
  }
}
