part of 'selection.dart';

class FileSelection extends Selection<CurrentIndexCubit> {
  FileSelection(CurrentIndexCubit cubit) : super([cubit]);

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
    final currentIndex = cubit.state;
    return [
      ...super.buildProperties(context),
      _UtilitiesView(
        state: currentIndex.utilities,
        option: currentIndex.viewOption,
        onStateChanged: (state) => cubit.updateUtilities(utilities: state),
        onToolChanged: (option) => cubit.updateUtilities(view: option),
      )
    ];
  }
}

class _UtilitiesView extends StatefulWidget {
  final UtilitiesState state;
  final ViewOption option;
  final ValueChanged<UtilitiesState> onStateChanged;
  final ValueChanged<ViewOption> onToolChanged;

  const _UtilitiesView(
      {required this.state,
      required this.option,
      required this.onStateChanged,
      required this.onToolChanged});

  @override
  State<_UtilitiesView> createState() => _UtilitiesViewState();
}

class _UtilitiesViewState extends State<_UtilitiesView>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  final TextEditingController _nameController = TextEditingController(),
      _descriptionController = TextEditingController();

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);

    _tabController.addListener(_onTabChange);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    _tabController.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
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
    if (_nameController.text != metadata.name) {
      _nameController.text = metadata.name;
    }
    if (_descriptionController.text != metadata.description) {
      _descriptionController.text = metadata.description;
    }
    return Column(children: [
      TabBar(
        controller: _tabController,
        isScrollable: true,
        tabs: <List<dynamic>>[
          [PhosphorIconsLight.file, AppLocalizations.of(context).file],
          [PhosphorIconsLight.book, AppLocalizations.of(context).page],
          [PhosphorIconsLight.camera, AppLocalizations.of(context).camera],
        ]
            .map((e) =>
                HorizontalTab(icon: PhosphorIcon(e[0]), label: Text(e[1])))
            .toList(),
      ),
      const SizedBox(height: 8),
      Builder(
          builder: (context) => [
                Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: LeapLocalizations.of(context).name,
                        filled: true,
                      ),
                      onChanged: (value) {
                        bloc.add(DocumentDescriptionChanged(name: value));
                        state.save();
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      minLines: 3,
                      maxLines: 5,
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context).description,
                        border: const OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        bloc.add(
                            DocumentDescriptionChanged(description: value));
                        state.save();
                      },
                    ),
                    const SizedBox(height: 8),
                    MenuItemButton(
                      leadingIcon:
                          const PhosphorIcon(PhosphorIconsLight.camera),
                      onPressed: () async {
                        final viewport =
                            state.currentIndexCubit.state.cameraViewport;
                        final width = viewport.width?.toDouble() ??
                            kThumbnailWidth.toDouble();
                        final realHeight = viewport.height?.toDouble() ??
                            kThumbnailHeight.toDouble();
                        final height =
                            width * kThumbnailHeight / kThumbnailWidth;
                        final heightOffset = (realHeight - height) / 2;
                        final quality = kThumbnailWidth / width;
                        final thumbnail = await state.currentIndexCubit.render(
                          state.data,
                          state.page,
                          state.info,
                          ImageExportOptions(
                            width: width,
                            height: height,
                            quality: quality,
                            scale: viewport.scale,
                            x: viewport.x,
                            y: viewport.y + heightOffset,
                          ),
                        );
                        if (thumbnail == null) return;
                        final bytes = thumbnail.buffer.asUint8List();
                        context
                            .read<DocumentBloc>()
                            .add(ThumbnailCaptured(bytes));
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(AppLocalizations.of(context)
                                  .capturedThumbnail),
                            ),
                          );
                        }
                      },
                      child:
                          Text(AppLocalizations.of(context).captureThumbnail),
                    ),
                    MenuItemButton(
                      leadingIcon: Tooltip(
                        message: state.data.isEncrypted
                            ? AppLocalizations.of(context).encrypted
                            : AppLocalizations.of(context).unencrypted,
                        child: Icon(
                          state.data.isEncrypted
                              ? PhosphorIconsLight.lock
                              : PhosphorIconsLight.lockOpen,
                        ),
                      ),
                      child: Text(
                        state.data.isEncrypted
                            ? AppLocalizations.of(context).unencrypt
                            : AppLocalizations.of(context).encrypt,
                      ),
                      onPressed: () async {
                        if (state.data.isEncrypted) {
                          final result = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title:
                                  Text(AppLocalizations.of(context).unencrypt),
                              content: Text(AppLocalizations.of(context)
                                  .unencryptWarning),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, false),
                                  child: Text(MaterialLocalizations.of(context)
                                      .cancelButtonLabel),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  child: Text(MaterialLocalizations.of(context)
                                      .okButtonLabel),
                                ),
                              ],
                            ),
                          );
                          if (result != true) return;
                          context
                              .read<DocumentBloc>()
                              .add(EncryptionChanged(null));
                        } else {
                          String password = '';
                          bool showPassword = false,
                              showConfirmPassword = false;
                          final formKey = GlobalKey<FormState>();
                          final result = await showDialog<bool>(
                            context: context,
                            builder: (context) => StatefulBuilder(
                              builder: (context, setState) => Form(
                                key: formKey,
                                child: AlertDialog(
                                  scrollable: true,
                                  title: Text(
                                      AppLocalizations.of(context).encrypt),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(children: [
                                        Icon(PhosphorIconsLight.warning),
                                        const SizedBox(width: 8),
                                        Flexible(
                                          child: Text(
                                              AppLocalizations.of(context)
                                                  .encryptWarning),
                                        ),
                                      ]),
                                      const SizedBox(height: 16),
                                      TextFormField(
                                        decoration: InputDecoration(
                                          labelText:
                                              AppLocalizations.of(context)
                                                  .password,
                                          filled: true,
                                          suffixIcon: IconButton(
                                            icon: Icon(showPassword
                                                ? PhosphorIconsLight.eye
                                                : PhosphorIconsLight.eyeSlash),
                                            onPressed: () => setState(
                                              () =>
                                                  showPassword = !showPassword,
                                            ),
                                          ),
                                        ),
                                        obscureText: !showPassword,
                                        autofocus: true,
                                        onChanged: (value) => password = value,
                                        validator: (value) =>
                                            value?.isEmpty ?? true
                                                ? LeapLocalizations.of(context)
                                                    .shouldNotEmpty
                                                : null,
                                      ),
                                      const SizedBox(height: 8),
                                      TextFormField(
                                        decoration: InputDecoration(
                                          labelText:
                                              AppLocalizations.of(context)
                                                  .confirmPassword,
                                          filled: true,
                                          suffixIcon: IconButton(
                                            icon: Icon(showConfirmPassword
                                                ? PhosphorIconsLight.eye
                                                : PhosphorIconsLight.eyeSlash),
                                            onPressed: () => setState(
                                              () => showConfirmPassword =
                                                  !showConfirmPassword,
                                            ),
                                          ),
                                        ),
                                        obscureText: !showConfirmPassword,
                                        validator: (value) => value != password
                                            ? AppLocalizations.of(context)
                                                .passwordMismatch
                                            : null,
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, false),
                                      child: Text(
                                          MaterialLocalizations.of(context)
                                              .cancelButtonLabel),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        if (formKey.currentState?.validate() ??
                                            false) {
                                          Navigator.pop(context, true);
                                        }
                                      },
                                      child: Text(
                                          MaterialLocalizations.of(context)
                                              .okButtonLabel),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                          if (result != true) return;
                          context
                              .read<DocumentBloc>()
                              .add(EncryptionChanged(password));
                        }
                      },
                    )
                  ],
                ),
                Column(children: [
                  MenuItemButton(
                    leadingIcon: const PhosphorIcon(PhosphorIconsLight.image),
                    shortcut: const SingleActivator(LogicalKeyboardKey.keyB,
                        control: true),
                    onPressed: () {
                      Actions.maybeInvoke<BackgroundIntent>(
                          context, BackgroundIntent(context));
                    },
                    child: Text(AppLocalizations.of(context).background),
                  ),
                ]),
                Column(
                  children: [
                    OffsetPropertyView(
                      title: Text(AppLocalizations.of(context).position),
                      value: context.read<TransformCubit>().state.position,
                      round: 2,
                      onChanged: (value) =>
                          context.read<TransformCubit>().teleport(value),
                    ),
                    const SizedBox(height: 8),
                    ExactSlider(
                      header: Text(AppLocalizations.of(context).zoom),
                      value: context.read<TransformCubit>().state.size * 100,
                      defaultValue: 100,
                      min: kMinZoom * 100,
                      max: kMaxZoom * 100,
                      onChangeEnd: (value) {
                        final size = context
                            .read<CurrentIndexCubit>()
                            .state
                            .cameraViewport
                            .toSize();
                        context.read<TransformCubit>().size(value / 100,
                            Offset(size.width / 2, size.height / 2));
                        context.read<DocumentBloc>().bake();
                      },
                    ),
                    const SizedBox(height: 8),
                    CheckboxListTile(
                      value: widget.state.fullSelection,
                      onChanged: (value) => widget.onStateChanged(
                          widget.state.copyWith(fullSelection: value ?? false)),
                      title: Text(AppLocalizations.of(context).fullSelection),
                      subtitle: Text(AppLocalizations.of(context)
                          .fullSelectionDescription),
                    ),
                  ],
                ),
              ][_tabController.index]),
    ]);
  }
}
