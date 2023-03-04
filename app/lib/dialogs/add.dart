import 'dart:io';

import 'package:butterfly/services/import.dart';
import 'package:butterfly/visualizer/painter.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../api/open.dart';
import '../bloc/document_bloc.dart';
import '../widgets/box_tile.dart';
import 'camera.dart';

class AddDialog extends StatelessWidget {
  const AddDialog({super.key});

  @override
  Widget build(BuildContext context) {
    void addPainter(Painter painter) {
      context.read<DocumentBloc>().add(PainterCreated(painter));
      Navigator.of(context).pop();
    }

    void importAsset(AssetFileType type, Uint8List bytes) {
      context.read<ImportService>().import(type, bytes, meta: false);
      Navigator.of(context).pop();
    }

    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(AppLocalizations.of(context).add),
          IconButton(
            onPressed: () => openHelp(['painters']),
            icon: const Icon(PhosphorIcons.circleWavyQuestionLight),
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
                    icon: const Icon(PhosphorIcons.imageLight),
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
                      icon: const Icon(PhosphorIcons.cameraLight),
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
                    icon: const Icon(PhosphorIcons.sunLight),
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
                    icon: const Icon(PhosphorIcons.filePdfLight),
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
                      icon: const Icon(PhosphorIcons.fileTextLight),
                      onTap: () async {
                        final files = await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowedExtensions: ['bfly', 'json'],
                            allowMultiple: false,
                            withData: true);
                        if (files?.files.isEmpty ?? true) return;
                        var e = files!.files.first;
                        var content = e.bytes ?? Uint8List(0);
                        if (!kIsWeb) {
                          content = await File(e.path ?? '').readAsBytes();
                        }
                        importAsset(AssetFileType.note, content);
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
                  Painter.shape,
                  Painter.stamp,
                  Painter.laser,
                  Painter.pathEraser,
                  Painter.label,
                  Painter.eraser,
                  Painter.layer,
                  Painter.waypoint,
                  Painter.area,
                  Painter.presentation,
                ].map(
                  (e) {
                    final painter = e();
                    return BoxTile(
                      title: Text(
                        painter.getLocalizedName(context),
                        textAlign: TextAlign.center,
                      ),
                      icon: Icon(painter.getIcon()),
                      onTap: () => addPainter(painter),
                    );
                  },
                ).toList(),
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
                ].map(
                  (e) {
                    final painter = e();
                    return BoxTile(
                      title: Text(
                        painter.getLocalizedName(context),
                        textAlign: TextAlign.center,
                      ),
                      icon: Icon(painter.getIcon()),
                      onTap: () => addPainter(painter),
                    );
                  },
                ).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
