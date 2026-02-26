import 'package:butterfly/cubits/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lw_file_system/lw_file_system.dart';

class FileNameDisplay extends StatelessWidget {
  final FileSystemEntity<dynamic> entity;
  final TextStyle? style;

  const FileNameDisplay({super.key, required this.entity, this.style});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, ButterflySettings>(
      buildWhen: (previous, current) =>
          previous.hideExtension != current.hideExtension,
      builder: (context, state) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                entity.fileNameWithoutExtension,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: style,
              ),
            ),
            if (!state.hideExtension && entity.fileExtension.isNotEmpty)
              Text('.${entity.fileExtension}', maxLines: 1, style: style),
          ],
        );
      },
    );
  }
}
