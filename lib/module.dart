// app_module.dart
import 'package:butterfly/main.dart';
import 'package:butterfly/pad/module.dart';
import 'package:butterfly/pages/home.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends MainModule {
  // Provide a list of dependencies to inject into your project
  @override
  final List<Bind> binds = [];

  // Provide all the routes for your module
  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => HomePage()),
    ModuleRoute('/pad', module: PadModule())
  ];

  // Provide the root widget associated with your module
  // In this case, it's the widget you created in the first step
  @override
  final Widget bootstrap = ButterflyApp();
}
