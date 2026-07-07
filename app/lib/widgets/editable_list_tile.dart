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
  final VoidCallback? onLongPress;
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
    this.onLongPress,
    this.textFormatter,
    this.contentPadding,
  });

  @override
  State<EditableListTile> createState() => _EditableListTileState();
}

class _EditableListTileState extends State<EditableListTile> {
  TextEditingController? _internalController;
  final FocusNode _focusNode = FocusNode();
  bool _isEditing = false;

  TextEditingController get _controller =>
      widget.controller ?? _internalController!;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _internalController = TextEditingController(text: widget.initialValue);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
    _internalController?.dispose();
  }

  void _saveAndClose([String? value]) {
    if (!_isEditing) return;
    widget.onSaved?.call(value ?? _controller.text);
    setState(() {
      _isEditing = false;
    });
  }

  void _startEditing() {
    if (widget.onSaved == null) return;
    setState(() {
      _isEditing = true;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.actions != null) {
      return ContextRegion(
        tooltip: AppLocalizations.of(context).actions,
        builder: (context, button, controller) => _buildWidget(context, button),
        menuChildren: [
          if (widget.onSaved != null)
            MenuItemButton(
              leadingIcon: const PhosphorIcon(PhosphorIconsLight.textT),
              onPressed: _startEditing,
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
    final title = SizedBox(
      height: 40,
      child: _isEditing
          ? TextField(
              controller: _controller,
              focusNode: _focusNode,
              autofocus: true,
              onChanged: widget.onChanged,
              onSubmitted: _saveAndClose,
              onEditingComplete: _saveAndClose,
              onTapOutside: (_) {
                _saveAndClose();
                _focusNode.unfocus();
              },
              textInputAction: TextInputAction.done,
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
          : Padding(
              padding: const EdgeInsets.only(left: 4),
              child: ListenableBuilder(
                listenable: _controller,
                builder: (context, _) {
                  final text =
                      widget.textFormatter?.call(_controller.text) ??
                      _controller.text;
                  return Tooltip(
                    message: text,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          text,
                          style: currentStyle,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
    );

    final tile = ListTile(
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
      title: title,
      trailing:
          actionButton ??
          (widget.onSaved == null || !widget.showEditIcon
              ? null
              : IconButton(
                  icon: PhosphorIcon(
                    _isEditing
                        ? PhosphorIconsLight.check
                        : PhosphorIconsLight.pencil,
                    textDirection: TextDirection.ltr,
                  ),
                  tooltip: _isEditing
                      ? AppLocalizations.of(context).save
                      : AppLocalizations.of(context).edit,
                  onPressed: () {
                    if (_isEditing) {
                      _saveAndClose();
                    } else {
                      _startEditing();
                    }
                  },
                )),
    );

    if (_isEditing) {
      return tile;
    }

    return GestureDetector(
      onDoubleTap: _startEditing,
      onLongPress: widget.onLongPress,
      child: tile,
    );
  }
}
