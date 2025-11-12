part of '../dialog.dart';

class _ImageBackgroundPropertiesView extends StatelessWidget {
  final ImageBackground value;
  final ValueChanged<ImageBackground> onChanged;

  const _ImageBackgroundPropertiesView({
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        OffsetListTile(
          title: Text(AppLocalizations.of(context).scale),
          value: Offset(value.scaleX, value.scaleY),
          onChanged: (value) => onChanged(
            this.value.copyWith(scaleX: value.dx, scaleY: value.dy),
          ),
        ),
      ],
    );
  }
}
