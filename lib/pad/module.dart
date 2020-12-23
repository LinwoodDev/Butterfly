import 'package:butterfly/pad/main.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PadModule extends ChildModule {
  // Provide a list of dependencies to inject into your project
  @override
  List<Bind> get binds => [];

  // Provide all the routes for your module
  @override
  List<ModularRouter> get routers => [
        ModularRouter('/:id', child: (_, args) => ProjectPage(id: args.params['id'])),
        /*ModularRouter('/:id/:path',
            child: (_, args) => ProjectPage(id: args.params['id'], path: args.params['path']))*/
      ];
}
