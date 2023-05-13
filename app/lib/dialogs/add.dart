import 'dart:io';

import 'package:butterfly/helpers/color_helper.dart';
import 'package:butterfly/services/import.dart';
import 'package:butterfly/visualizer/painter.dart';
import 'package:butterfly/visualizer/property.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../api/open.dart';
import '../bloc/document_bloc.dart';
import 'camera.dart';

class AddDialog extends StatelessWidget {
  const AddDialog({super.key});

  @override
  Widget build(BuildContext context) {
    void addPainter(Painter painter) {
      final bloc = context.read<DocumentBloc>();
      final state = bloc.state;
      if (state is! DocumentLoaded) return;
      final background = state.page.background.defaultColor;
      final defaultPainter = updatePainterDefaultColor(painter, background);
      bloc.add(PainterCreated(defaultPainter));
      Navigator.of(context).pop();
    }

    void importAsset(AssetFileType type, Uint8List bytes) {
      context.read<ImportService>().import(type, bytes);
      Navigator.of(context).pop();
    }

    Widget buildPainter(Painter Function() e) {
      final painter = e();
      return BoxTile(
        title: Text(
          painter.getLocalizedName(context),
          textAlign: TextAlign.center,
        ),
        icon: PhosphorIcon(painter.icon(PhosphorIconsStyle.light)),
        onTap: () => addPainter(painter),
      );
    }

    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(AppLocalizations.of(context).add),
          IconButton(
            onPressed: () => openHelp(['painters']),
            icon: const PhosphorIcon(PhosphorIconsLight.sealQuestion),
          ),
        ],
      ),
      scrollable: true,
      actions: [
        TextButton(
          child: Text(AppLocalizations.of(context).cancel),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
      content: SizedBox(
        width: 800,
        child: Material(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context).import,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),
              Wrap(
                alignment: WrapAlignment.start,
                children: [
                  BoxTile(
                    title: Text(
                      AppLocalizations.of(context).image,
                      textAlign: TextAlign.center,
                    ),
                    icon: const PhosphorIcon(PhosphorIconsLight.image),
                    onTap: () async {
                      var files = await FilePicker.platform.pickFiles(
                          type: FileType.image,
                          allowMultiple: false,
                          withData: true);
                      if (files?.files.isEmpty ?? true) return;
                      var e = files!.files.first;
                      var content = e.bytes ?? Uint8List(0);
                      if (!kIsWeb) {
                        content = await File(e.path ?? '').readAsBytes();
                      }
                      importAsset(AssetFileType.image, content);
                    },
                  ),
                  if (kIsWeb ||
                      Platform.isWindows ||
                      Platform.isAndroid ||
                      Platform.isIOS)
                    BoxTile(
                      title: Text(
                        AppLocalizations.of(context).camera,
                        textAlign: TextAlign.center,
                      ),
                      icon: const PhosphorIcon(PhosphorIconsLight.camera),
                      onTap: () async {
                        var content = await showDialog<Uint8List>(
                          context: context,
                          builder: (context) => const CameraDialog(),
                        );
                        if (content == null) return;
                        importAsset(AssetFileType.image, content);
                      },
                    ),
                  BoxTile(
                    title: Text(
                      AppLocalizations.of(context).svg,
                      textAlign: TextAlign.center,
                    ),
                    icon: const PhosphorIcon(PhosphorIconsLight.sun),
                    onTap: () async {
                      final files = await FilePicker.platform.pickFiles(
                          type: FileType.custom,
                          allowedExtensions: ['svg'],
                          allowMultiple: false,
                          withData: true);
                      if (files?.files.isEmpty ?? true) return;
                      final e = files!.files.first;
                      var content = e.bytes ?? Uint8List(0);
                      if (!kIsWeb) {
                        content = await File(e.path ?? '').readAsBytes();
                      }
                      importAsset(AssetFileType.svg, content);
                    },
                  ),
                  BoxTile(
                    title: Text(
                      AppLocalizations.of(context).pdf,
                      textAlign: TextAlign.center,
                    ),
                    icon: const PhosphorIcon(PhosphorIconsLight.filePdf),
                    onTap: () async {
                      final files = await FilePicker.platform.pickFiles(
                          type: FileType.custom,
                          allowedExtensions: ['pdf'],
                          allowMultiple: false,
                          withData: true);
                      if (files?.files.isEmpty ?? true) return;
                      final e = files!.files.first;
                      var content = e.bytes ?? Uint8List(0);
                      if (!kIsWeb) {
                        content = await File(e.path ?? '').readAsBytes();
                      }
                      importAsset(AssetFileType.pdf, content);
                    },
                  ),
                  BoxTile(
                      title: Text(
                        AppLocalizations.of(context).document,
                        textAlign: TextAlign.center,
                      ),
                      icon: const PhosphorIcon(PhosphorIconsLight.fileText),
                      onTap: () async {
                        final data = await openBfly();
                        if (data == null) return;
                        importAsset(AssetFileType.note, data);
                      }),
                ],
              ),
              const SizedBox(height: 32),
              Text(
                AppLocalizations.of(context).painters,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),
              Wrap(
                alignment: WrapAlignment.start,
                children: [
                  Painter.hand,
                  Painter.pen,
                  Painter.stamp,
                  Painter.laser,
                  Painter.pathEraser,
                  Painter.label,
                  Painter.eraser,
                  Painter.layer,
                  Painter.waypoint,
                  Painter.area,
                  Painter.presentation,
                ].map(buildPainter).toList(),
              ),
              const SizedBox(height: 32),
              Text(
                AppLocalizations.of(context).shape,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),
              Wrap(
                alignment: WrapAlignment.start,
                children: [
                  PathShape.circle,
                  PathShape.rectangle,
                  PathShape.line,
                ].map((e) {
                  final shape = e();
                  return BoxTile(
                    title: Text(
                      shape.getLocalizedName(context),
                      textAlign: TextAlign.center,
                    ),
                    icon: Icon(shape.icon(PhosphorIconsStyle.light)),
                    onTap: () => addPainter(
                        ShapePainter(property: ShapeProperty(shape: shape))),
                  );
                }).toList(),
              ),
              const SizedBox(height: 32),
              Text(
                AppLocalizations.of(context).actions,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),
              Wrap(
                alignment: WrapAlignment.start,
                children: [
                  Painter.undo,
                  Painter.redo,
                ].map(buildPainter).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
