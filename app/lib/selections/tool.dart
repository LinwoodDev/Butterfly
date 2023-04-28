part of 'selection.dart';

class ToolSelection extends Selection<ToolState> {
  ToolSelection(super.selected);

  @override
  IconGetter get icon => PhosphorIcons.wrench;

  @override
  String getLocalizedName(BuildContext context) =>
      AppLocalizations.of(context).tools;

  @override
  List<Widget> buildProperties(BuildContext context) {
    final state = context.read<DocumentBloc>().state;
    if (state is! DocumentLoadSuccess) return [];
    return [
      ...super.buildProperties(context),
      _ToolView(
        state: selected.first,
        option: state.data.tool,
        onStateChanged: (state) => updateState(context, state),
        onToolChanged: (option) =>
            context.read<DocumentBloc>().add(ToolChanged.option(option)),
      )
    ];
  }

  void updateState(BuildContext context, ToolState selected) {
    update(context, [selected]);

    context.read<DocumentBloc>().add(ToolChanged.state(selected));
  }
}

class _ToolView extends StatefulWidget {
  final ToolState state;
  final ToolOption option;
  final ValueChanged<ToolState> onStateChanged;
  final ValueChanged<ToolOption> onToolChanged;

  const _ToolView(
      {required this.state,
      required this.option,
      required this.onStateChanged,
      required this.onToolChanged});

  @override
  State<_ToolView> createState() => _ToolViewState();
}

class _ToolViewState extends State<_ToolView> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);

    _tabController.addListener(_onTabChange);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    _tabController.dispose();
  }

  void _onTabChange() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final state = context.read<DocumentBloc>().state;
    if (state is! DocumentLoadSuccess) return const SizedBox.shrink();
    return Column(children: [
      TabBar(
        controller: _tabController,
        isScrollable: true,
        tabs: <List<dynamic>>[
          [PhosphorIconsLight.gear, AppLocalizations.of(context).project],
          [PhosphorIconsLight.gridFour, AppLocalizations.of(context).grid],
          [PhosphorIconsLight.ruler, AppLocalizations.of(context).ruler],
          [PhosphorIconsLight.camera, AppLocalizations.of(context).camera],
        ]
            .map((e) => Tab(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                      PhosphorIcon(e[0]),
                      const SizedBox(width: 4),
                      Text(e[1])
                    ])))
            .toList(),
      ),
      Builder(
          builder: (context) => [
                Column(
                  children: [
                    const SizedBox(height: 16),
                    TextFormField(
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return AppLocalizations.of(context).shouldNotEmpty;
                        }
                        return null;
                      },
                      initialValue: state.data.name,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context).name,
                        filled: true,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      minLines: 3,
                      maxLines: 5,
                      initialValue: state.data.description,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context).description,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Divider(),
                    const SizedBox(height: 8),
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
                  ],
                ),
                Column(children: [
                  CheckboxListTile(
                    title: Text(AppLocalizations.of(context).showGrid),
                    value: widget.state.gridEnabled,
                    onChanged: (value) => widget.onStateChanged(
                      widget.state.copyWith(gridEnabled: value ?? false),
                    ),
                  ),
                  const SizedBox(height: 8),
                  OffsetPropertyView(
                    value: Offset(
                        widget.option.gridXSize, widget.option.gridYSize),
                    title: Text(AppLocalizations.of(context).size),
                    onChanged: (value) => widget.onToolChanged(
                      widget.option
                          .copyWith(gridXSize: value.dx, gridYSize: value.dy),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ColorField(
                    title: Text(AppLocalizations.of(context).color),
                    value: Color(widget.option.gridColor),
                    onChanged: (value) => widget.onToolChanged(
                      widget.option.copyWith(gridColor: value.value),
                    ),
                  ),
                ]),
                Column(children: [
                  CheckboxListTile(
                    title: Text(AppLocalizations.of(context).ruler),
                    value: widget.state.rulerEnabled,
                    onChanged: (value) => widget.onStateChanged(
                        widget.state.copyWith(rulerEnabled: value ?? false)),
                  ),
                  const SizedBox(height: 8),
                  OffsetPropertyView(
                    title: Text(AppLocalizations.of(context).position),
                    onChanged: (value) => widget.onStateChanged(
                        widget.state.copyWith(rulerPosition: value.toPoint())),
                    value: widget.state.rulerPosition.toOffset(),
                  ),
                  const SizedBox(height: 8),
                  ExactSlider(
                    header: Text(AppLocalizations.of(context).angle),
                    value: widget.state.rulerAngle,
                    defaultValue: 0,
                    min: 0,
                    max: 360,
                    onChangeEnd: (value) => widget.onStateChanged(
                        widget.state.copyWith(rulerAngle: value)),
                  ),
                ]),
                Column(children: [
                  const SizedBox(height: 16),
                  OffsetPropertyView(
                    title: Text(AppLocalizations.of(context).position),
                    value: context.read<TransformCubit>().state.position,
                    round: 2,
                    onChanged: (value) =>
                        context.read<TransformCubit>().setPosition(value),
                  ),
                  const SizedBox(height: 8),
                  ExactSlider(
                    header: Text(AppLocalizations.of(context).zoom),
                    value: context.read<TransformCubit>().state.size,
                    defaultValue: 1,
                    min: 0.1,
                    max: 10,
                    onChangeEnd: (value) {
                      final size = context
                          .read<CurrentIndexCubit>()
                          .state
                          .cameraViewport
                          .toSize();
                      context
                          .read<TransformCubit>()
                          .size(value, Offset(size.width / 2, size.height / 2));
                      context.read<DocumentBloc>().bake();
                    },
                  ),
                ]),
              ][_tabController.index]),
    ]);
  }
}
