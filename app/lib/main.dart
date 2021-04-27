import 'package:butterfly/module.dart';
import 'package:butterfly/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main() => runApp(ModularApp(module: AppModule(), child: ButterflyApp()));

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
          dividerColor: Colors.grey[800],
          dividerTheme: DividerThemeData(thickness: 0.75),
          primarySwatch: Colors.green,
          accentColor: Colors.orange),
      darkTheme: ThemeData(
          brightness: Brightness.dark, primarySwatch: Colors.green, accentColor: Colors.orange),
      home: HomePage(),
    ).modular();
  }
}
