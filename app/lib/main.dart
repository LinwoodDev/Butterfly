import 'package:butterfly/module.dart';
import 'package:butterfly/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'setup.dart' if (dart.library.html) 'setup_web.dart';
import 'theme.dart';

void main() async {
  setup();
  var prefs = await SharedPreferences.getInstance();
  runApp(ModularApp(
      module: AppModule(), child: ButterflyApp(themeController: ThemeController(prefs))));
}

class ButterflyApp extends StatelessWidget {
  final ThemeController? themeController;

  const ButterflyApp({Key? key, this.themeController}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (themeController != null) {
      return AnimatedBuilder(
          animation: themeController!,
          builder: (context, _) {
            // wrap app in inherited widget to provide the ThemeController to all pages
            return ThemeControllerProvider(controller: themeController!, child: _buildApp());
          });
    }
    return _buildApp();
  }

  Widget _buildApp() {
    var primaryColor = const Color(0xFFF2B138);
    var primarySwatch = createMaterialColor(primaryColor);
    var accentColor = const Color(0xFF00469E);
    return MaterialApp(
      title: 'Butterfly',
      // set your initial route
      initialRoute: "/",
      theme: ThemeData(
          fontFamily: "Roboto",
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: primarySwatch,
          colorScheme: ColorScheme.light(primary: primaryColor, secondary: accentColor)),
      themeMode: themeController?.currentTheme,
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: primarySwatch,
          colorScheme: ColorScheme.dark(
              primary: primaryColor,
              primaryVariant: primaryColor,
              secondary: accentColor,
              secondaryVariant: accentColor)),
      home: const HomePage(),
    ).modular();
  }

  MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }
}
