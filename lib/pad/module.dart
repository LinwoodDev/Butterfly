import 'package:butterfly/models/document.dart';
import 'package:butterfly/pad/main.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PadModule extends ChildModule {
  // Provide a list of dependencies to inject into your project
  @override
  final List<Bind> binds = [
    Bind.singleton((i) => AppDocument(name: 'example')),
  ];
  @override
  final List<ModularRoute> routes = [
    ChildRoute('/:id',
        child: (_, args) => ProjectPage(id: args.params != null ? args.params['id'] : null)),
    ChildRoute('/:id/:path',
        child: (_, args) => ProjectPage(id: args.params['id'], path: args.params['path']))
  ];
}
