part of 'painter.dart';

const double _kSquareRatio = 1.0;
const double _kAPortraitRatio = sqrt2;
const double _kLandscapeRatio = 1 / sqrt2;

enum AreaRatioPreset {
  square,
  portrait,
  landscape,
}

extension AreaRatioPresetExtension on AreaRatioPreset {
  double get ratio {
    switch (this) {
      case AreaRatioPreset.square:
        return _kSquareRatio;
      case AreaRatioPreset.portrait:
        return _kAPortraitRatio;
      case AreaRatioPreset.landscape:
        return _kLandscapeRatio;
    }
  }

  String getLocalized(BuildContext context) {
    switch (this) {
      case AreaRatioPreset.square:
        return AppLocalizations.of(context)!.square;
      case AreaRatioPreset.portrait:
        return AppLocalizations.of(context)!.pagePortrait;
      case AreaRatioPreset.landscape:
        return AppLocalizations.of(context)!.pageLandscape;
    }
  }
}

class AreaPainter extends Painter {
  final double constrainedWidth, constrainedHeight, constrainedAspectRatio;
  const AreaPainter({
    String name = '',
    this.constrainedWidth = 0,
    this.constrainedHeight = 0,
    this.constrainedAspectRatio = 0,
  }) : super(name: name);
  AreaPainter.fromJson(Map<String, dynamic> json, [int? fileVersion])
      : constrainedWidth = json['constrainedWidth'] ?? 0,
        constrainedHeight = json['constrainedHeight'] ?? 0,
        constrainedAspectRatio = json['constrainedAspectRatio'] ?? 0,
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() => super.toJson()
    ..addAll({
      'type': 'area',
      'constrainedWidth': constrainedWidth,
      'constrainedHeight': constrainedHeight,
      'constrainedAspectRatio': constrainedAspectRatio
    });

  AreaPainter copyWith({
    String? name,
    double? constrainedWidth,
    double? constrainedHeight,
    double? constrainedAspectRatio,
  }) =>
      AreaPainter(
        name: name ?? this.name,
        constrainedWidth: constrainedWidth ?? this.constrainedWidth,
        constrainedHeight: constrainedHeight ?? this.constrainedHeight,
        constrainedAspectRatio:
            constrainedAspectRatio ?? this.constrainedAspectRatio,
      );
}
