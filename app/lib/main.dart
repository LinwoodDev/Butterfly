import 'package:butterfly/module.dart';
import 'package:butterfly/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'setup.dart' if (dart.library.html) 'setup_web.dart';

void main() {
  setup();
  runApp(ModularApp(module: AppModule(), child: ButterflyApp()));
}

class ButterflyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
          primarySwatch: createMaterialColor(Color(0xFFF2B138)),
          accentColor: Color(0xFF6FADFC)),
      darkTheme: ThemeData(
          brightness: Brightness.dark, primarySwatch: Colors.green, accentColor: Colors.orange),
      home: HomePage(),
    ).modular();
  }

  MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }
}
