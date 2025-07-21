import 'package:flutter/material.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

@immutable
class NoteDialogCallback {
  final List<String> pages, packs;

  const NoteDialogCallback(this.pages, this.packs);
}

class NoteImportDialog extends StatefulWidget {
  final List<String> pages, packs;
  const NoteImportDialog({super.key, required this.pages, required this.packs});

  @override
  State<NoteImportDialog> createState() => _NoteImportDialogState();
}

class _NoteImportDialogState extends State<NoteImportDialog> {
  late final List<String> _selectedPages;
  final List<String> _selectedPacks = const [];

  @override
  void initState() {
    super.initState();
    _selectedPages = widget.pages.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: DefaultTabController(
          length: 2,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Header(title: Text(AppLocalizations.of(context).import)),
              TabBar(
                tabs: [
                  HorizontalTab(
                    label: Text(AppLocalizations.of(context).pages),
                    icon: const PhosphorIcon(PhosphorIconsLight.book),
                  ),
                  HorizontalTab(
                    label: Text(AppLocalizations.of(context).packs),
                    icon: const PhosphorIcon(PhosphorIconsLight.package),
                  ),
                ],
              ),
              Flexible(
                child: TabBarView(
                  children: [
                    ListView.builder(
                      itemCount: widget.pages.length,
                      itemBuilder: (context, index) {
                        var page = widget.pages[index];
                        return CheckboxListTile(
                          value: _selectedPages.contains(page),
                          onChanged: (value) {
                            setState(() {
                              if (value == true) {
                                _selectedPages.add(page);
                              } else {
                                _selectedPages.remove(page);
                              }
                            });
                          },
                          title: Text(page),
                        );
                      },
                    ),
                    ListView.builder(
                      itemCount: widget.packs.length,
                      itemBuilder: (context, index) {
                        var pack = widget.packs[index];
                        return CheckboxListTile(
                          value: _selectedPacks.contains(pack),
                          onChanged: (value) {
                            setState(() {
                              if (value == true) {
                                _selectedPacks.add(pack);
                              } else {
                                _selectedPacks.remove(pack);
                              }
                            });
                          },
                          title: Text(pack),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      child: Text(
                        MaterialLocalizations.of(context).cancelButtonLabel,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    ElevatedButton(
                      child: Text(
                        MaterialLocalizations.of(context).okButtonLabel,
                      ),
                      onPressed: () => Navigator.of(
                        context,
                      ).pop(NoteDialogCallback(_selectedPages, _selectedPacks)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
