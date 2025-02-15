import 'package:flutter/material.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
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
  final String Function(String)? textFormatter;

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
    this.textFormatter,
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
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void didUpdateWidget(covariant EditableListTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      if (widget.controller != oldWidget.controller) {
        _controller = widget.controller ?? TextEditingController();
      }
      final initialValue = widget.initialValue;
      if (initialValue != oldWidget.initialValue && initialValue != null) {
        _controller.text = initialValue;
      }
    });
  }

  void _onSaved([String? value]) {
    widget.onSaved?.call(value ?? _controller.text);
    setState(() {
      _isEditing = false;
    });
  }

  void _edit() {
    if (widget.onSaved != null) {
      setState(() {
        _isEditing = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.actions != null) {
      return ContextRegion(
        tooltip: AppLocalizations.of(context).actions,
        builder: (context, button, controller) => _buildWidget(context, button),
        menuChildren: [
          MenuItemButton(
            leadingIcon: const PhosphorIcon(PhosphorIconsLight.textT),
            onPressed: _edit,
            child: Text(AppLocalizations.of(context).rename),
          ),
          ...widget.actions!,
        ],
      );
    }
    return _buildWidget(context, null);
  }

  Widget _buildWidget(BuildContext context, Widget? actionButton) {
    return GestureDetector(
      onDoubleTap: _edit,
      child: ListTile(
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
                        onSaved: _onSaved,
                        autofocus: true,
                        onFieldSubmitted: _onSaved,
                        onTapOutside: (_) => _onSaved(),
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
                      ),
                    )
                  : ListenableBuilder(
                      listenable: _controller,
                      builder: (context, _) => Text(
                        widget.textFormatter?.call(_controller.text) ??
                            _controller.text,
                      ),
                    ),
            ),
          ),
          trailing: actionButton ??
              (widget.onSaved == null
                  ? null
                  : IconButton(
                      icon: const PhosphorIcon(PhosphorIconsLight.pencil),
                      tooltip: AppLocalizations.of(context).rename,
                      onPressed: _edit,
                    ))),
    );
  }
}
