part of 'selection.dart';

class DocumentSelection extends Selection<EditorController> {
  DocumentSelection(EditorController cubit) : super([cubit]);

  @override
  IconGetter get icon => PhosphorIcons.wrench;

  @override
  String getLocalizedName(BuildContext context) =>
      AppLocalizations.of(context).document;

  @override
  List<String> get help => ['utilities'];

  @override
  List<Widget> buildProperties(BuildContext context) {
    final cubit = selected.first;
    final viewState = cubit.viewCubit.state;
    return [
      ...super.buildProperties(context),
      _UtilitiesView(
        state: viewState.locks,
        onStateChanged: (state) => cubit.viewCubit.updateLocks(locks: state),
      ),
    ];
  }
}

class _UtilitiesView extends StatefulWidget {
  final PersistentLockState state;
  final ValueChanged<PersistentLockState> onStateChanged;

  const _UtilitiesView({required this.state, required this.onStateChanged});

  @override
  State<_UtilitiesView> createState() => _UtilitiesViewState();
}

class _UtilitiesViewState extends State<_UtilitiesView>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  final TextEditingController _descriptionController = TextEditingController();
  final FocusNode _descriptionFocusNode = FocusNode();

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);

    _tabController.addListener(_onTabChange);

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _descriptionController.dispose();
    _descriptionFocusNode.dispose();

    super.dispose();
  }

  @override
  void didUpdateWidget(covariant _UtilitiesView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.state != widget.state) {
      setState(() {});
    }
  }

  void _onTabChange() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DocumentBloc>();
    final state = bloc.state;
    if (state is! DocumentLoadSuccess) return const SizedBox.shrink();
    final metadata = state.metadata;
    if (!_descriptionFocusNode.hasFocus &&
        _descriptionController.text != metadata.description) {
      _descriptionController.text = metadata.description;
    }
    void submitDescription(String? value) {
      value ??= _descriptionController.text;
      if (metadata.description == value) return;
      bloc.add(DocumentDescriptionChanged(description: value));
      bloc.save();
    }

    return Column(
      children: [
        TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs:
              [
                    (
                      PhosphorIconsLight.file,
                      AppLocalizations.of(context).file,
                    ),
                    (
                      PhosphorIconsLight.toolbox,
                      AppLocalizations.of(context).toolbars,
                    ),
                    (
                      PhosphorIconsLight.camera,
                      AppLocalizations.of(context).camera,
                    ),
                  ]
                  .map(
                    (e) => HorizontalTab(
                      icon: PhosphorIcon(
                        e.$1,
                        textDirection: TextDirection.ltr,
                      ),
                      label: Text(e.$2),
                    ),
                  )
                  .toList(),
        ),
        const SizedBox(height: 8),
        Builder(
          builder: (context) => [
            Column(
              children: [
                Focus(
                  onFocusChange: (hasFocus) {
                    if (!hasFocus) submitDescription(null);
                  },
                  child: TextFormField(
                    minLines: 3,
                    maxLines: 5,
                    controller: _descriptionController,
                    focusNode: _descriptionFocusNode,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context).description,
                      border: const OutlineInputBorder(),
                    ),
                    onTapOutside: (_) => submitDescription(null),
                    onFieldSubmitted: submitDescription,
                    onSaved: submitDescription,
                  ),
                ),
                const SizedBox(height: 8),
                ListTile(
                  leading: const PhosphorIcon(PhosphorIconsLight.camera),
                  onTap: () async {
                    final cubit = context.read<DocumentBloc>().editorController;
                    final viewport = cubit.rendererCubit.state.cameraViewport;
                    final rect = viewport.toRealRect();
                    final targetAspectRatio =
                        kThumbnailWidth / kThumbnailHeight;
                    var captureWidth = rect.width;
                    var captureHeight = captureWidth / targetAspectRatio;
                    if (captureHeight > rect.height) {
                      captureHeight = rect.height;
                      captureWidth = captureHeight * targetAspectRatio;
                    }
                    final widthOffset = (rect.width - captureWidth) / 2;
                    final heightOffset = (rect.height - captureHeight) / 2;
                    final quality =
                        kThumbnailWidth / (captureWidth * viewport.scale);
                    final thumbnail = await cubit.rendererCubit.render(
                      cubit,
                      state.data,
                      state.page,
                      state.info,
                      ImageExportOptions(
                        width: captureWidth * viewport.scale,
                        height: captureHeight * viewport.scale,
                        quality: quality,
                        scale: viewport.scale,
                        x: rect.left + widthOffset,
                        y: rect.top + heightOffset,
                      ),
                      docState: state,
                    );
                    if (thumbnail == null) return;
                    final bytes = thumbnail.buffer.asUint8List();
                    context.read<DocumentBloc>().add(ThumbnailCaptured(bytes));
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          content: Row(
                            mainAxisSize: MainAxisSize.min,
                            spacing: 8,
                            children: [
                              Image.memory(bytes, height: 42),
                              Flexible(
                                child: Text(
                                  AppLocalizations.of(
                                    context,
                                  ).capturedThumbnail,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                  title: Text(AppLocalizations.of(context).captureThumbnail),
                  trailing: IconButton(
                    icon: const PhosphorIcon(PhosphorIconsLight.crop),
                    tooltip: AppLocalizations.of(context).captureThumbnail,
                    onPressed: () {
                      showDialog<void>(
                        context: context,
                        builder: (context) => BlocProvider.value(
                          value: bloc,
                          child: ThumbnailCaptureDialog(state: state),
                        ),
                      );
                    },
                  ),
                ),
                BlocSelector<DocumentBloc, DocumentState, bool>(
                  selector: (state) =>
                      state is DocumentLoadSuccess && state.data.isEncrypted,
                  builder: (context, isEncrypted) => ListTile(
                    leading: Icon(
                      isEncrypted
                          ? PhosphorIconsLight.lock
                          : PhosphorIconsLight.lockOpen,
                    ),
                    subtitle: Text(
                      isEncrypted
                          ? AppLocalizations.of(context).encrypted
                          : AppLocalizations.of(context).unencrypted,
                    ),
                    title: Text(
                      isEncrypted
                          ? AppLocalizations.of(context).unencrypt
                          : AppLocalizations.of(context).encrypt,
                    ),
                    onTap: () async {
                      if (isEncrypted) {
                        final result = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(AppLocalizations.of(context).unencrypt),
                            content: Text(
                              AppLocalizations.of(context).unencryptWarning,
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: Text(
                                  MaterialLocalizations.of(
                                    context,
                                  ).cancelButtonLabel,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: Text(
                                  MaterialLocalizations.of(
                                    context,
                                  ).okButtonLabel,
                                ),
                              ),
                            ],
                          ),
                        );
                        if (result != true || !context.mounted) return;
                        context.read<DocumentBloc>().add(
                          EncryptionChanged(null),
                        );
                      } else {
                        final localizations = AppLocalizations.of(context);
                        final password = await showPasswordDialog(
                          context,
                          title: localizations.encrypt,
                          passwordLabel: localizations.password,
                          confirm: true,
                          warning: localizations.encryptWarning,
                        );
                        if (password == null || !context.mounted) return;
                        context.read<DocumentBloc>().add(
                          EncryptionChanged(password),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
            const ToolbarsView(),
            BlocSelector<
              TransformCubit,
              CameraTransform,
              ({Offset position, double size, double rotation})
            >(
              selector: (state) => (
                position: state.position,
                size: state.size,
                rotation: state.rotation,
              ),
              builder: (context, transformState) => Column(
                children: [
                  OffsetListTile(
                    title: Text(AppLocalizations.of(context).position),
                    value: transformState.position,
                    onChanged: (value) =>
                        context.read<TransformCubit>().teleport(value),
                  ),
                  ExactSlider(
                    header: Text(AppLocalizations.of(context).zoom),
                    value: transformState.size * 100,
                    defaultValue: 100,
                    min: kMinZoom * 100,
                    max: kMaxZoom * 100,
                    onChangeEnd: (value) {
                      final size = context
                          .read<EditorController>()
                          .rendererCubit
                          .state
                          .cameraViewport
                          .toSize();
                      final editorController = context.read<EditorController>();
                      editorController.transformCubit.sizeConstrained(
                        value / 100,
                        cursor: Offset(size.width / 2, size.height / 2),
                        runtime: editorController,
                      );
                      context.read<DocumentBloc>().bake();
                    },
                  ),
                  ExactSlider(
                    header: Text(AppLocalizations.of(context).rotation),
                    value: transformState.rotation * 180 / pi,
                    defaultValue: 0,
                    min: -180,
                    max: 180,
                    fractionDigits: 0,
                    onChanged: (value) {
                      final editorController = context.read<EditorController>();
                      final size = editorController
                          .rendererCubit
                          .state
                          .cameraViewport
                          .toSize();
                      final transform = editorController.transformCubit;
                      transform.rotateConstrained(
                        value * pi / 180 - transform.state.rotation,
                        cursor: size.center(Offset.zero),
                        runtime: editorController,
                      );
                    },
                  ),
                ],
              ),
            ),
          ][_tabController.index],
        ),
      ],
    );
  }
}
