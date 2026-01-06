import 'dart:typed_data';

import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AssetCard extends StatelessWidget {
  const AssetCard({
    super.key,
    required this.metadata,
    required this.thumbnail,
    required this.onTap,
    this.name,
    this.tooltip,
    this.height = 128,
  });
  final String? name;
  final String? tooltip;
  final FileMetadata? metadata;
  final Uint8List? thumbnail;
  final VoidCallback onTap;
  final double height;

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final textStyle = TextTheme.of(
      context,
    ).bodyLarge?.copyWith(color: colorScheme.onSurface);
    return Tooltip(
      message: tooltip ?? name ?? metadata?.name,
      waitDuration: const Duration(seconds: 1),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: height),
        child: AspectRatio(
          aspectRatio: kThumbnailRatio,
          child: Card(
            elevation: 5,
            clipBehavior: Clip.hardEdge,
            child: Stack(
              children: [
                if (thumbnail?.isNotEmpty ?? false)
                  Align(
                    child: Image.memory(
                      thumbnail!,
                      fit: BoxFit.cover,
                      width: 640,
                      alignment: Alignment.center,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Icon(
                            PhosphorIconsLight.warningCircle,
                            color: colorScheme.onSurface,
                          ),
                        );
                      },
                    ),
                  ),
                if ((metadata?.name.isNotEmpty ?? false) ||
                    (name?.isNotEmpty ?? false))
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: colorScheme.primaryContainer.withAlpha(200),
                      ),
                      child: Text(
                        (metadata?.name.isNotEmpty ?? false)
                            ? metadata!.name
                            : name!,
                        style: textStyle,
                      ),
                    ),
                  ),
                Positioned.fill(
                  child: Material(
                    type: MaterialType.transparency,
                    child: InkWell(onTap: onTap),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
