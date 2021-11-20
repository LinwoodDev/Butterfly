import 'package:flutter_modular/flutter_modular.dart';

import 'settings/module.dart';
import 'views/main.dart';

class AppModule extends Module {
  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, __) => const ProjectPage()),
    ChildRoute('/:path',
        child: (_, args) => ProjectPage(path: args.params['path'])),
    ModuleRoute('/settings', module: SettingsModule()),
  ];
}
