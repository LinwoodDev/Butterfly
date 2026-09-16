import 'package:butterfly_api/butterfly_api.dart';
import 'package:material_ui/material_ui.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';

extension DocumentPageHelper on DocumentPage {
  String? createAreaName(BuildContext context, [bool askForName = false]) {
    var count = areas.length + 1;
    var name = '';
    while (name.isEmpty || getAreaByName(name) != null) {
      name = AppLocalizations.of(context).areaIndex(count);
      count++;
    }
    return name;
  }
}
