import 'package:butterfly/settings/home.dart';
import 'package:butterfly/settings/personalization.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SettingsModule extends Module {
  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const SettingsPage()),
    ChildRoute('/personalization', child: (_, args) => const PersonalizationSettingsPage())
  ];
}
