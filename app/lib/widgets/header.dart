import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../api/open_help.dart';

class Header extends StatelessWidget {
  final Widget leading;
  final Widget title;
  final List<String>? help;
  const Header(
      {Key? key, required this.leading, required this.title, this.help})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(children: [
        IconTheme(data: const IconThemeData(size: 28), child: leading),
        const SizedBox(width: 8),
        Expanded(
          child: DefaultTextStyle(
              style: Theme.of(context).textTheme.headline6 ??
                  const TextStyle(fontSize: 20),
              child: title),
        ),
        if (help != null)
          IconButton(
              tooltip: AppLocalizations.of(context)!.help,
              icon: const Icon(PhosphorIcons.circleWavyQuestionLight),
              onPressed: () => openHelp(help!)),
      ]),
    );
  }
}
