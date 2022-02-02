import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/views/edit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../cubits/transform.dart';

class ToolSelection extends StatelessWidget {
  final bool isMobile;
  final GlobalKey viewportKey;
  final TextEditingController _scaleController =
      TextEditingController(text: '100');
  ToolSelection({Key? key, this.isMobile = false, required this.viewportKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    void bake() {
      var size = viewportKey.currentContext?.size;
      var transform = context.read<TransformCubit>();
      if (size != null) {
        context.read<DocumentBloc>().add(ImageBaked(
            size, MediaQuery.of(context).devicePixelRatio, transform.state));
      }
    }

    return Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            BlocBuilder<TransformCubit, CameraTransform>(
                builder: (context, transform) {
              _scaleController.text = (transform.size * 100).toStringAsFixed(2);
              const zoomConstant = 1 + 0.1;

              return Row(
                children: [
                  IconButton(
                      icon: const Icon(PhosphorIcons.magnifyingGlassMinusLight),
                      tooltip: AppLocalizations.of(context)!.zoomOut,
                      onPressed: () {
                        var viewportSize = viewportKey.currentContext?.size ??
                            MediaQuery.of(context).size;
                        context.read<TransformCubit>().zoom(
                            1 / zoomConstant,
                            Offset(viewportSize.width / 2,
                                viewportSize.height / 2));
                        bake();
                      }),
                  IconButton(
                      icon: const Icon(PhosphorIcons.magnifyingGlassLight),
                      tooltip: AppLocalizations.of(context)!.resetZoom,
                      onPressed: () {
                        var cubit = context.read<TransformCubit>();
                        var viewportSize = viewportKey.currentContext?.size ??
                            MediaQuery.of(context).size;
                        cubit.size(
                            1,
                            Offset(viewportSize.width / 2,
                                viewportSize.height / 2));
                        bake();
                      }),
                  IconButton(
                      icon: const Icon(PhosphorIcons.magnifyingGlassPlusLight),
                      tooltip: AppLocalizations.of(context)!.zoomIn,
                      onPressed: () {
                        var viewportSize = viewportKey.currentContext?.size ??
                            MediaQuery.of(context).size;
                        context.read<TransformCubit>().zoom(
                            zoomConstant,
                            Offset(viewportSize.width / 2,
                                viewportSize.height / 2));
                        bake();
                      }),
                  const SizedBox(width: 10),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 100),
                    child: TextField(
                      controller: _scaleController,
                      onSubmitted: (value) {
                        var viewportSize = viewportKey.currentContext?.size ??
                            MediaQuery.of(context).size;
                        var cubit = context.read<TransformCubit>();
                        var scale = double.tryParse(value) ?? 100;
                        scale /= 100;
                        cubit.size(
                            scale,
                            Offset(viewportSize.width / 2,
                                viewportSize.height / 2));
                      },
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          filled: true,
                          labelText: AppLocalizations.of(context)!.zoom),
                    ),
                  ),
                  if (!isMobile) const VerticalDivider()
                ],
              );
            }),
          ]),
          if (!isMobile)
            const Flexible(
              child: EditToolbar(),
            )
        ]);
  }
}
