part of '../dialog.dart';

class _SvgBackgroundPropertiesView extends StatelessWidget {
  final SvgBackground value;
  final ValueChanged<SvgBackground> onChanged;

  const _SvgBackgroundPropertiesView({
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
