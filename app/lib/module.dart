import 'package:flutter_modular/flutter_modular.dart';

import 'settings/module.dart';
import 'views/main.dart';

class AppModule extends Module {
  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, __) => const ProjectPage()),
    ChildRoute('/',
        child: (_, args) => ProjectPage(path: args.queryParams['path'])),
    ModuleRoute('/settings', module: SettingsModule()),
  ];
}
