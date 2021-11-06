import 'package:flutter_modular/flutter_modular.dart';

import 'settings/module.dart';
import 'views/main.dart';

class AppModule extends Module {
  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, __) => const ProjectPage()),
    ChildRoute('/:id', child: (_, args) => ProjectPage(id: args.params['id'])),
    ModuleRoute('/settings', module: SettingsModule()),
  ];
}
