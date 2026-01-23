import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/current_index.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';

class ZoomView extends StatefulWidget {
  final bool isMobile;

  const ZoomView({super.key, this.isMobile = false});

  @override
  State<ZoomView> createState() => _ZoomViewState();
}

class _ZoomViewState extends State<ZoomView> with TickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _controller;
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _zoomController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutExpo,
    );
    _focusNode.addListener(_onFocus);
  }

  void _onFocus() {
    if (_focusNode.hasFocus) {
      // Reset animation to 100%
      _controller.stop();
      _controller.value = 1;
    } else if (_controller.status != AnimationStatus.completed) {
      _controller.reverse(from: 1);
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _zoomController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ZoomView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isMobile != widget.isMobile) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 400),
      child: BlocBuilder<DocumentBloc, DocumentState>(
        buildWhen: (previous, current) =>
            previous.runtimeType != current.runtimeType,
        builder: (context, state) => BlocBuilder<WindowCubit, WindowState>(
          builder: (context, windowState) =>
              BlocBuilder<SettingsCubit, ButterflySettings>(
                buildWhen: (previous, current) =>
                    previous.zoomEnabled != current.zoomEnabled,
                builder: (context, settings) =>
                    BlocBuilder<TransformCubit, CameraTransform>(
                      buildWhen: (previous, current) =>
                          previous.size != current.size,
                      builder: (context, transform) {
                        var scale = transform.size;
                        final currentIndexCubit = context
                            .read<CurrentIndexCubit>();
                        final hideZoom =
                            !settings.zoomEnabled ||
                            windowState.fullScreen ||
                            currentIndexCubit.state.hideUi != HideState.visible;
                        void zoom(double value, [bool bake = true]) {
                          final state = context.read<DocumentBloc>().state;
                          final currentIndex = context
                              .read<CurrentIndexCubit>()
                              .state;
                          if (state is! DocumentLoaded) {
                            return;
                          }
                          final size = currentIndex.cameraViewport.toRealSize();
                          final center = Offset(
                            size.width / 2,
                            size.height / 2,
                          );
                          currentIndex.transformCubit.size(value, center);
                          if (bake) {
                            currentIndexCubit.bake(state);
                          }
                          if ((!_focusNode.hasFocus && widget.isMobile) ||
                              hideZoom) {
                            _controller.reverse();
                          }
                        }

                        final body = StatefulBuilder(
                          builder: (context, setState) {
                            final text = (scale * 100).toStringAsFixed(0);
                            if (text != _zoomController.text) {
                              _zoomController.text = text;
                            }
                            return LayoutBuilder(
                              builder: (context, constraints) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 75,
                                      child: TextFormField(
                                        textAlign: TextAlign.center,
                                        controller: _zoomController,
                                        keyboardType: TextInputType.number,
                                        focusNode: _focusNode,
                                        onChanged: (value) {
                                          setState(
                                            () => scale =
                                                (double.tryParse(value) ??
                                                    (scale * 100)) /
                                                100,
                                          );
                                        },
                                        onEditingComplete: () => zoom(scale),
                                        onTapOutside: (event) {
                                          if (!_focusNode.hasFocus) return;
                                          zoom(scale);
                                          _focusNode.unfocus();
                                        },
                                        onFieldSubmitted: (value) =>
                                            zoom(scale),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Tooltip(
                                      message: AppLocalizations.of(
                                        context,
                                      ).resetZoom,
                                      child: IconButton(
                                        icon: const Icon(
                                          PhosphorIconsLight
                                              .clockCounterClockwise,
                                        ),
                                        onPressed: () {
                                          zoom(1.0);
                                        },
                                      ),
                                    ),
                                    if (!widget.isMobile) ...[
                                      if (constraints.maxWidth > 200)
                                        Flexible(
                                          child: Slider(
                                            value: scale.clamp(kMinZoom, 10),
                                            min: kMinZoom,
                                            max: 10,
                                            onChanged: (value) =>
                                                zoom(value, false),
                                            onChangeEnd: zoom,
                                          ),
                                        ),
                                    ],
                                  ],
                                );
                              },
                            );
                          },
                        );

                        if ((!_focusNode.hasFocus && widget.isMobile) ||
                            hideZoom) {
                          _controller.reverse();
                        } else {
                          _controller.forward();
                        }
                        return AnimatedBuilder(
                          animation: _animation,
                          child: body,
                          builder: (context, child) {
                            if (_animation.value == 0 ||
                                state is! DocumentLoadSuccess) {
                              return const SizedBox();
                            }
                            return Opacity(
                              opacity: _animation.value,
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: child,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
              ),
        ),
      ),
    );
  }
}
