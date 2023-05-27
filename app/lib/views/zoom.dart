import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/current_index.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    _controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOutExpo);
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
    return Positioned(
      bottom: 25,
      right: 25,
      width: widget.isMobile ? 100 : 400,
      child: BlocBuilder<SettingsCubit, ButterflySettings>(
        buildWhen: (previous, current) =>
            previous.zoomEnabled != current.zoomEnabled,
        builder: (context, settings) =>
            BlocBuilder<TransformCubit, CameraTransform>(
          buildWhen: (previous, current) => previous.size != current.size,
          builder: (context, transform) {
            var scale = transform.size;
            final currentIndexCubit = context.read<CurrentIndexCubit>();
            void zoom(double value) {
              final state = context.read<DocumentBloc>().state;
              if (state is! DocumentLoaded) {
                return;
              }
              final viewport =
                  context.read<CurrentIndexCubit>().state.cameraViewport;
              final center = Offset(
                (viewport.width ?? 0) / 2,
                (viewport.height ?? 0) / 2,
              );
              context.read<TransformCubit>().size(value, center);
              currentIndexCubit.bake(state.data, state.page, state.info);
              if (!_focusNode.hasFocus &&
                  widget.isMobile &&
                  !_controller.isAnimating &&
                  _controller.value == 1) {
                _controller.reverse(from: 1);
              }
            }

            if (widget.isMobile && !_focusNode.hasFocus) {
              _controller.reverse(from: 1);
            } else {
              if (_controller.status != AnimationStatus.completed) {
                _controller.forward(from: 0);
              }
            }
            return AnimatedBuilder(
              animation: _animation,
              builder: (context, child) => Opacity(
                opacity: _animation.value,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: StatefulBuilder(
                      builder: (context, setState) {
                        final text = (scale * 100).toStringAsFixed(0);
                        if (text != _zoomController.text) {
                          _zoomController.text = text;
                        }
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
                                    setState(() => scale =
                                        (double.tryParse(value) ??
                                                (scale * 100)) /
                                            100);
                                  },
                                  onEditingComplete: () => zoom(scale),
                                  onTapOutside: (event) {
                                    zoom(scale);
                                    _focusNode.unfocus();
                                  },
                                  onFieldSubmitted: (value) => zoom(scale),
                                ),
                              ),
                              if (!widget.isMobile)
                                Expanded(
                                  child: Slider(
                                    value: scale.clamp(kMinZoom, 10),
                                    min: kMinZoom,
                                    max: 10,
                                    onChanged: (value) =>
                                        setState(() => scale = value),
                                    onChangeEnd: zoom,
                                  ),
                                ),
                            ]);
                      },
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
