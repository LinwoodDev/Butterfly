part of '../selection.dart';

class AreaToolSelection extends ToolSelection<AreaTool> {
  AreaToolSelection(super.selected);

  @override
  List<Widget> buildProperties(BuildContext context) {
    final tool = selected.first;
    AreaTool setAspectRatio(AreaTool tool, double aspectRatio) {
      if (aspectRatio == 0) {
        return tool.copyWith(constrainedAspectRatio: aspectRatio);
      }
      if (tool.constrainedWidth != 0) {
        return tool.copyWith(
          constrainedHeight: 0,
          constrainedAspectRatio: aspectRatio,
        );
      }
      if (tool.constrainedHeight != 0) {
        return tool.copyWith(
          constrainedWidth: 0,
          constrainedAspectRatio: aspectRatio,
        );
      }
      return tool.copyWith(constrainedAspectRatio: aspectRatio);
    }

    return [
      ...super.buildProperties(context),
      CheckboxListTile(
        title: Text(AppLocalizations.of(context).askForName),
        value: tool.askForName,
        onChanged: (value) => update(
          context,
          selected.map((e) => e.copyWith(askForName: value ?? false)).toList(),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: AreaSizePicker(
          width: tool.constrainedWidth,
          height: tool.constrainedHeight,
          allowUnconstrainedDimensions: true,
          onChanged: (size) => update(
            context,
            selected
                .map(
                  (e) => e.copyWith(
                    constrainedWidth: size.width,
                    constrainedHeight: size.height,
                    constrainedAspectRatio:
                        (size.width != e.constrainedWidth ||
                                size.height != e.constrainedHeight) &&
                            size.width > 0 &&
                            size.height > 0
                        ? 0
                        : e.constrainedAspectRatio, // Reset to allow exact dimensions
                  ),
                )
                .toList(),
          ),
        ),
      ),
      const SizedBox(height: 8),
      ListTile(
        title: Text(AppLocalizations.of(context).aspectRatio),
        trailing: SegmentedButton<double>(
          emptySelectionAllowed: true,
          showSelectedIcon: false,
          segments: AspectRatioPreset.values
              .map(
                (preset) => ButtonSegment<double>(
                  value: preset.ratio,
                  icon: PhosphorIcon(preset.icon(PhosphorIconsStyle.light)),
                  tooltip: preset.getLocalizedName(context),
                ),
              )
              .toList(),
          selected: tool.constrainedAspectRatio == 0
              ? <double>{}
              : {
                      AspectRatioPreset.values
                          .firstWhere(
                            (p) =>
                                (p.ratio - tool.constrainedAspectRatio).abs() <
                                0.01,
                            orElse: () => AspectRatioPreset.square,
                          )
                          .ratio,
                    }
                    .where(
                      (r) => (r - tool.constrainedAspectRatio).abs() < 0.01,
                    )
                    .toSet(),
          onSelectionChanged: (selection) {
            final newRatio = selection.isEmpty ? 0.0 : selection.first;
            update(
              context,
              selected.map((e) => setAspectRatio(e, newRatio)).toList(),
            );
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: AspectRatioInput(
          aspectRatio: tool.constrainedAspectRatio,
          onChanged: (value) => update(
            context,
            selected.map((e) => setAspectRatio(e, value)).toList(),
          ),
        ),
      ),
      const SizedBox(height: 8),
    ];
  }

  @override
  Selection insert(dynamic element) {
    if (element is AreaTool) {
      return AreaToolSelection([...selected, element]);
    }
    return super.insert(element);
  }
}
