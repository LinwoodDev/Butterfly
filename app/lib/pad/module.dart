import 'package:butterfly/home.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'views/main.dart';

class PadModule extends Module {
  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, __) => const HomePage()),
    ChildRoute('/:id', child: (_, args) => ProjectPage(id: args.params['id']))
  ];
}
