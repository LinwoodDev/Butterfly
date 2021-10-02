import 'package:butterfly/models/document.dart';
import 'package:butterfly/home.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'views/main.dart';

class PadModule extends Module {
  // Provide a list of dependencies to inject into your project
  @override
  final List<Bind> binds = [
    Bind.singleton((i) => const AppDocument(name: 'example')),
  ];
  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, __) => const HomePage()),
    ChildRoute('/:id', child: (_, args) => ProjectPage(id: args.params['id']))
  ];
}
