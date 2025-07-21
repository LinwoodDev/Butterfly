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
  final TextStyle? textStyle;
  final VoidCallback? onTap;
  final String Function(String)? textFormatter;
  final EdgeInsetsGeometry? contentPadding;

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
    this.textStyle,
    this.onTap,
    this.textFormatter,
    this.contentPadding,
  });

  @override
  State<EditableListTile> createState() => _EditableListTileState();
}

class _EditableListTileState extends State<EditableListTile> {
  late final TextEditingController _controller;
  final FocusNode _focusNode = FocusScopeNode();
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
    _focusNode.dispose();
    if (widget.controller == null) _controller.dispose();
  }

  @override
  void didUpdateWidget(covariant EditableListTile oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.controller == oldWidget.controller) {
      return;
    }
    setState(() {
      _controller =
          widget.controller ?? TextEditingController(text: widget.initialValue);
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
      _focusNode.requestFocus();
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
    final currentStyle = widget.textStyle;
    final isEditing = _isEditing;
    return GestureDetector(
      onDoubleTap: _edit,
      child: FocusScope(
        onFocusChange: (value) {
          if (!value) {
            _onSaved();
          }
        },
        child: ListTile(
          onTap: widget.onTap,
          selected: widget.selected,
          leading: widget.leading,
          subtitle: widget.subtitle == null
              ? null
              : Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: widget.subtitle,
                ),
          minVerticalPadding: 0,
          contentPadding: widget.contentPadding,
          title: SizedBox(
            height: 40,
            child: isEditing
                ? TextFormField(
                    controller: _controller,
                    onChanged: widget.onChanged,
                    onSaved: _onSaved,
                    autofocus: true,
                    onFieldSubmitted: _onSaved,
                    style: currentStyle,
                    decoration: InputDecoration(
                      filled: true,
                      border: const OutlineInputBorder(),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 0,
                      ),
                      hintText: AppLocalizations.of(context).enterText,
                    ),
                  )
                : Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: ListenableBuilder(
                        listenable: _controller,
                        builder: (context, _) => Text(
                          widget.textFormatter?.call(_controller.text) ??
                              _controller.text,
                          style: currentStyle,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
          ),
          trailing:
              actionButton ??
              (widget.onSaved == null || !widget.showEditIcon
                  ? null
                  : IconButton(
                      icon: PhosphorIcon(
                        _isEditing
                            ? PhosphorIconsLight.check
                            : PhosphorIconsLight.pencil,
                      ),
                      tooltip: _isEditing
                          ? AppLocalizations.of(context).save
                          : AppLocalizations.of(context).edit,
                      onPressed: () {
                        if (isEditing) {
                          _onSaved();
                        } else {
                          _edit();
                        }
                      },
                    )),
        ),
      ),
    );
  }
}
