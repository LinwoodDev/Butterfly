import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class EditableListTile extends StatefulWidget {
  final TextEditingController? controller;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSaved;
  final bool showEditIcon, selected;
  final List<Widget>? actions;
  final Widget? leading, subtitle;
  final VoidCallback? onTap;

  const EditableListTile({
    super.key,
    this.controller,
    this.initialValue,
    this.onChanged,
    required this.onSaved,
    this.showEditIcon = true,
    this.selected = false,
    this.actions,
    this.leading,
    this.subtitle,
    this.onTap,
  });

  @override
  State<EditableListTile> createState() => _EditableListTileState();
}

class _EditableListTileState extends State<EditableListTile> {
  late final TextEditingController _controller;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _controller =
        widget.controller ?? TextEditingController(text: widget.initialValue);
  }

  @override
  Widget build(BuildContext context) {
    void onSaved([String? value]) {
      widget.onSaved?.call(value ?? _controller.text);
      setState(() {
        _isEditing = false;
      });
    }

    void edit() {
      if (widget.onSaved != null) {
        setState(() {
          _isEditing = true;
        });
      }
    }

    return ListTile(
      onTap: widget.onTap,
      selected: widget.selected,
      leading: widget.leading,
      subtitle: widget.subtitle,
      title: SizedBox(
        height: 48,
        child: Align(
          alignment: Alignment.centerLeft,
          child: _isEditing
              ? Builder(
                  builder: (context) => TextFormField(
                        controller: _controller,
                        onChanged: widget.onChanged,
                        onSaved: onSaved,
                        autofocus: true,
                        onFieldSubmitted: onSaved,
                        onTapOutside: (_) => onSaved(),
                        style: DefaultTextStyle.of(context).style,
                        decoration: InputDecoration(
                          filled: true,
                          border: const OutlineInputBorder(),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 10,
                          ),
                          hintText: AppLocalizations.of(context).enterText,
                        ),
                      ))
              : GestureDetector(
                  onDoubleTap: edit,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 13,
                    ),
                    child: Text(
                      widget.initialValue ?? '',
                    ),
                  ),
                ),
        ),
      ),
      trailing: widget.actions != null
          ? MenuAnchor(
              builder: defaultMenuButton(
                tooltip: AppLocalizations.of(context).actions,
              ),
              menuChildren: [
                MenuItemButton(
                  leadingIcon: const PhosphorIcon(PhosphorIconsLight.textT),
                  onPressed: edit,
                  child: Text(AppLocalizations.of(context).rename),
                ),
                ...widget.actions!,
              ],
            )
          : widget.onSaved == null
              ? null
              : IconButton(
                  icon: const PhosphorIcon(PhosphorIconsLight.pencil),
                  tooltip: AppLocalizations.of(context).rename,
                  onPressed: edit,
                ),
    );
  }
}
