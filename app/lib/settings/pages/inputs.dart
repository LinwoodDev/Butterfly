part of '../home.dart';

typedef _InputConfigurationRead<V> = V Function(InputConfiguration config);
typedef _InputConfigurationWrite<V> =
    InputConfiguration Function(InputConfiguration config, V value);

final _inputsSettingsPage = SettingsLeapPage<ButterflySettings>(
  displayName: (context) => AppLocalizations.of(context).inputs,
  icon: PhosphorIconsLight.keyboard,
  appBarBuilder: _butterflyAppBar,
  children: {
    'mouse': _mouseSettingsPage,
    'touch': _touchSettingsPage,
    'keyboard': _keyboardSettingsPage,
    'pen': _penSettingsPage,
  },
  sections: {
    'devices': SettingsLeapSection(
      settings: [
        SettingsLeapActionSetting(
          displayName: (context) => AppLocalizations.of(context).mouse,
          icon: PhosphorIconsLight.mouse,
          onTap: (context) => context.push('/settings/inputs/mouse'),
        ),
        SettingsLeapActionSetting(
          displayName: (context) => AppLocalizations.of(context).touch,
          icon: PhosphorIconsLight.hand,
          onTap: (context) => context.push('/settings/inputs/touch'),
        ),
        SettingsLeapActionSetting(
          displayName: (context) => AppLocalizations.of(context).keyboard,
          icon: PhosphorIconsLight.keyboard,
          onTap: (context) => context.push('/settings/inputs/keyboard'),
        ),
        SettingsLeapActionSetting(
          displayName: (context) => AppLocalizations.of(context).pen,
          icon: PhosphorIconsLight.pen,
          onTap: (context) => context.push('/settings/inputs/pen'),
        ),
      ],
    ),
    'sensitivity': SettingsLeapSection(
      displayName: (context) => AppLocalizations.of(context).sensitivity,
      descriptionBuilder: (context) =>
          AppLocalizations.of(context).sensitivityHint,
      settings: [
        SettingsLeapCustomSetting(
          displayName: (context) => AppLocalizations.of(context).select,
          descriptionBuilder: (context) =>
              AppLocalizations.of(context).selectSensitivityDescription,
          builder: _selectSensitivitySetting,
        ),
        SettingsLeapCustomSetting(
          displayName: (context) => AppLocalizations.of(context).touch,
          descriptionBuilder: (context) =>
              AppLocalizations.of(context).touchSensitivityDescription,
          builder: _touchSensitivitySetting,
        ),
        SettingsLeapCustomSetting(
          displayName: (context) => AppLocalizations.of(context).inputGestures,
          descriptionBuilder: (context) =>
              AppLocalizations.of(context).gestureSensitivityDescription,
          builder: _gestureSensitivitySetting,
        ),
        SettingsLeapCustomSetting(
          displayName: (context) => AppLocalizations.of(context).scroll,
          descriptionBuilder: (context) =>
              AppLocalizations.of(context).scrollSensitivityDescription,
          builder: _scrollSensitivitySetting,
        ),
      ],
    ),
    'pointerTest': SettingsLeapSection(
      displayName: (context) => AppLocalizations.of(context).pointerTest,
      builder: _pointerTestSection,
    ),
  },
);

final _mouseSettingsPage = SettingsLeapPage<ButterflySettings>(
  displayName: (context) => AppLocalizations.of(context).mouse,
  icon: PhosphorIconsLight.mouse,
  appBarBuilder: _butterflyAppBar,
  sections: {
    'behavior': SettingsLeapSection(
      settings: [
        SettingsLeapBoolSetting(
          id: 'hideCursorWhileDrawing',
          displayName: (context) =>
              AppLocalizations.of(context).hideCursorWhileDrawing,
          descriptionBuilder: (context) =>
              AppLocalizations.of(context).hideCursorWhileDrawingDescription,
          icon: PhosphorIconsLight.cursorClick,
          read: (state) => state.hideCursorWhileDrawing,
          write: (context, value) =>
              context.read<SettingsCubit>().changeHideCursorWhileDrawing(value),
        ),
      ],
    ),
    'shortcuts': SettingsLeapSection(
      displayName: (context) => AppLocalizations.of(context).shortcuts,
      headerBuilder: _shortcutsHelpHeader,
      settings: [
        _inputMappingSetting(
          id: 'leftMouse',
          displayName: (context) => AppLocalizations.of(context).left,
          icon: PhosphorIconsLight.mouseLeftClick,
          read: (config) => config.leftMouse,
          write: (config, value) => config.copyWith(leftMouse: value),
        ),
        _inputShortcutSetting(
          id: 'doubleLeftMouseShortcut',
          displayName: (context) =>
              _getDoubleName(context, AppLocalizations.of(context).left),
          icon: PhosphorIconsLight.mouseLeftClick,
          read: (config) => config.doubleLeftMouseShortcut,
          write: (config, value) =>
              config.copyWith(doubleLeftMouseShortcut: value),
        ),
        _inputShortcutSetting(
          id: 'tripleLeftMouseShortcut',
          displayName: (context) =>
              _getTripleName(AppLocalizations.of(context).left),
          icon: PhosphorIconsLight.mouseLeftClick,
          read: (config) => config.tripleLeftMouseShortcut,
          write: (config, value) =>
              config.copyWith(tripleLeftMouseShortcut: value),
        ),
        _inputMappingSetting(
          id: 'middleMouse',
          displayName: (context) => AppLocalizations.of(context).middle,
          icon: PhosphorIconsLight.mouseMiddleClick,
          read: (config) => config.middleMouse,
          write: (config, value) => config.copyWith(middleMouse: value),
        ),
        _inputShortcutSetting(
          id: 'doubleMiddleMouseShortcut',
          displayName: (context) =>
              _getDoubleName(context, AppLocalizations.of(context).middle),
          icon: PhosphorIconsLight.mouseMiddleClick,
          read: (config) => config.doubleMiddleMouseShortcut,
          write: (config, value) =>
              config.copyWith(doubleMiddleMouseShortcut: value),
        ),
        _inputShortcutSetting(
          id: 'tripleMiddleMouseShortcut',
          displayName: (context) =>
              _getTripleName(AppLocalizations.of(context).middle),
          icon: PhosphorIconsLight.mouseMiddleClick,
          read: (config) => config.tripleMiddleMouseShortcut,
          write: (config, value) =>
              config.copyWith(tripleMiddleMouseShortcut: value),
        ),
        _inputMappingSetting(
          id: 'rightMouse',
          displayName: (context) => AppLocalizations.of(context).right,
          icon: PhosphorIconsLight.mouseRightClick,
          read: (config) => config.rightMouse,
          write: (config, value) => config.copyWith(rightMouse: value),
        ),
        _inputShortcutSetting(
          id: 'doubleRightMouseShortcut',
          displayName: (context) =>
              _getDoubleName(context, AppLocalizations.of(context).right),
          icon: PhosphorIconsLight.mouseRightClick,
          read: (config) => config.doubleRightMouseShortcut,
          write: (config, value) =>
              config.copyWith(doubleRightMouseShortcut: value),
        ),
        _inputShortcutSetting(
          id: 'tripleRightMouseShortcut',
          displayName: (context) =>
              _getTripleName(AppLocalizations.of(context).right),
          icon: PhosphorIconsLight.mouseRightClick,
          read: (config) => config.tripleRightMouseShortcut,
          write: (config, value) =>
              config.copyWith(tripleRightMouseShortcut: value),
        ),
      ],
    ),
  },
);

final _touchSettingsPage = SettingsLeapPage<ButterflySettings>(
  displayName: (context) => AppLocalizations.of(context).touch,
  icon: PhosphorIconsLight.hand,
  appBarBuilder: _butterflyAppBar,
  sections: {
    'behavior': SettingsLeapSection(
      settings: [
        SettingsLeapBoolSetting(
          id: 'inputGestures',
          displayName: (context) => AppLocalizations.of(context).inputGestures,
          descriptionBuilder: (context) =>
              AppLocalizations.of(context).inputGesturesDescription,
          icon: PhosphorIconsLight.handTap,
          read: (state) => state.inputGestures,
          write: (context, value) =>
              context.read<SettingsCubit>().changeInputGestures(value),
        ),
        SettingsLeapBoolSetting(
          id: 'moveOnGesture',
          displayName: (context) => AppLocalizations.of(context).moveOnGesture,
          descriptionBuilder: (context) =>
              AppLocalizations.of(context).moveOnGestureDescription,
          icon: PhosphorIconsLight.arrowsOutCardinal,
          read: (state) => state.moveOnGesture,
          write: (context, value) =>
              context.read<SettingsCubit>().changeMoveOnGesture(value),
        ),
      ],
    ),
    'shortcuts': SettingsLeapSection(
      displayName: (context) => AppLocalizations.of(context).shortcuts,
      headerBuilder: _shortcutsHelpHeader,
      settings: [
        _inputMappingSetting(
          id: 'touch',
          displayName: (context) => AppLocalizations.of(context).touch,
          icon: PhosphorIconsLight.handPointing,
          read: (config) => config.touch,
          write: (config, value) => config.copyWith(touch: value),
        ),
        _inputShortcutSetting(
          id: 'doubleTouchShortcut',
          displayName: (context) =>
              AppLocalizations.of(context).doublePressAction,
          icon: PhosphorIconsLight.handTap,
          read: (config) => config.doubleTouchShortcut,
          write: (config, value) => config.copyWith(doubleTouchShortcut: value),
        ),
        _inputShortcutSetting(
          id: 'tripleTouchShortcut',
          displayName: (context) =>
              AppLocalizations.of(context).triplePressAction,
          icon: PhosphorIconsLight.handTap,
          read: (config) => config.tripleTouchShortcut,
          write: (config, value) => config.copyWith(tripleTouchShortcut: value),
        ),
      ],
    ),
  },
);

final _keyboardSettingsPage = SettingsLeapPage<ButterflySettings>(
  displayName: (context) => AppLocalizations.of(context).keyboard,
  icon: PhosphorIconsLight.keyboard,
  appBarBuilder: _butterflyAppBar,
  sections: {
    'help': SettingsLeapSection(
      settings: [
        SettingsLeapActionSetting(
          id: 'shortcuts',
          displayName: (context) => AppLocalizations.of(context).shortcuts,
          icon: PhosphorIconsLight.keyboard,
          onTap: (context) => openHelp(['shortcuts'], 'keyboard'),
        ),
      ],
    ),
    'holdShortcuts': SettingsLeapSection(
      wrapBuilder: false,
      builder: (context, state, child) =>
          _buildHoldShortcutsSection(context, state.inputConfiguration),
    ),
    'general': SettingsLeapSection(
      wrapBuilder: false,
      builder: (context, state, child) => _buildKeyboardShortcutSection(
        context,
        AppLocalizations.of(context).general,
        [
          newShortcut,
          newFromTemplateShortcut,
          exportShortcut,
          exportTextShortcut,
          imageExportShortcut,
          pdfExportShortcut,
          svgExportShortcut,
          packsShortcut,
          settingsShortcut,
          exitShortcut,
        ],
      ),
    ),
    'project': SettingsLeapSection(
      wrapBuilder: false,
      builder: (context, state, child) =>
          _buildKeyboardShortcutSection(context, 'Project', [
            searchShortcut,
            undoShortcut,
            redoShortcut,
            backgroundShortcut,
            saveShortcut,
            changePathShortcut,
            zoomInShortcut,
            zoomOutShortcut,
            fullScreenShortcut,
            hideUIShortcut,
            nextShortcut,
            previousShortcut,
            nextPageShortcut,
            previousPageShortcut,
            togglePresentationShortcut,
            selectAllShortcut,
            pasteShortcut,
            ...changeToolShortcuts,
          ]),
    ),
  },
);

final _penSettingsPage = SettingsLeapPage<ButterflySettings>(
  displayName: (context) => AppLocalizations.of(context).pen,
  icon: PhosphorIconsLight.pen,
  appBarBuilder: _butterflyAppBar,
  sections: {
    'behavior': SettingsLeapSection(
      settings: [
        SettingsLeapListSetting<ButterflySettings, bool?>(
          id: 'penOnlyInput',
          displayName: (context) => AppLocalizations.of(context).penOnlyInput,
          descriptionBuilder: (context) =>
              AppLocalizations.of(context).penOnlyInputDescription,
          icon: PhosphorIconsLight.pencilSimpleLine,
          options: [
            SettingsLeapOption(
              id: 'automatic',
              value: null,
              displayName: (context) => AppLocalizations.of(context).automatic,
              descriptionBuilder: (context) =>
                  AppLocalizations.of(context).penOnlyInputAutoDescription,
            ),
            SettingsLeapOption(
              id: 'alwaysOn',
              value: true,
              displayName: (context) => AppLocalizations.of(context).alwaysOn,
              descriptionBuilder: (context) =>
                  AppLocalizations.of(context).penOnlyInputOnDescription,
            ),
            SettingsLeapOption(
              id: 'alwaysOff',
              value: false,
              displayName: (context) => AppLocalizations.of(context).alwaysOff,
              descriptionBuilder: (context) =>
                  AppLocalizations.of(context).penOnlyInputOffDescription,
            ),
          ],
          read: (state) => state.penOnlyInput,
          write: (context, value) =>
              context.read<SettingsCubit>().changePenOnlyInput(value),
        ),
        SettingsLeapBoolSetting(
          id: 'showPenOnlyToggle',
          displayName: (context) =>
              AppLocalizations.of(context).showPenOnlyToggle,
          descriptionBuilder: (context) =>
              AppLocalizations.of(context).showPenOnlyToggleDescription,
          icon: PhosphorIconsLight.toggleRight,
          read: (state) => state.showPenOnlyToggle,
          write: (context, value) =>
              context.read<SettingsCubit>().changeShowPenOnlyToggle(value),
        ),
        SettingsLeapListSetting<ButterflySettings, IgnorePressure>(
          id: 'ignorePressure',
          displayName: (context) => AppLocalizations.of(context).ignorePressure,
          descriptionBuilder: (context) =>
              AppLocalizations.of(context).ignorePressureDescription,
          icon: PhosphorIconsLight.lineSegments,
          options: [
            for (final value in IgnorePressure.values)
              SettingsLeapOption(
                id: value.name,
                value: value,
                displayName: (context) =>
                    _getIgnorePressureName(value, context),
                descriptionBuilder: (context) => switch (value) {
                  IgnorePressure.never => AppLocalizations.of(
                    context,
                  ).ignorePressureNeverDescription,
                  IgnorePressure.first => AppLocalizations.of(
                    context,
                  ).ignoreFirstPressureDescription,
                  IgnorePressure.always => AppLocalizations.of(
                    context,
                  ).ignorePressureAlwaysDescription,
                },
              ),
          ],
          read: (state) => state.ignorePressure,
          write: (context, value) =>
              context.read<SettingsCubit>().changeIgnorePressure(value),
        ),
      ],
    ),
    'shortcuts': SettingsLeapSection(
      displayName: (context) => AppLocalizations.of(context).shortcuts,
      headerBuilder: _shortcutsHelpHeader,
      settings: [
        _inputMappingSetting(
          id: 'pen',
          displayName: (context) => AppLocalizations.of(context).pen,
          icon: PhosphorIconsLight.pen,
          read: (config) => config.pen,
          write: (config, value) => config.copyWith(pen: value),
        ),
        _inputShortcutSetting(
          id: 'doublePenShortcut',
          displayName: (context) =>
              _getDoubleName(context, AppLocalizations.of(context).pen),
          icon: PhosphorIconsLight.pen,
          read: (config) => config.doublePenShortcut,
          write: (config, value) => config.copyWith(doublePenShortcut: value),
        ),
        _inputShortcutSetting(
          id: 'triplePenShortcut',
          displayName: (context) =>
              _getTripleName(AppLocalizations.of(context).pen),
          icon: PhosphorIconsLight.pen,
          read: (config) => config.triplePenShortcut,
          write: (config, value) => config.copyWith(triplePenShortcut: value),
        ),
        _inputMappingSetting(
          id: 'invertedPen',
          displayName: (context) => AppLocalizations.of(context).invertedPen,
          icon: PhosphorIconsLight.pen,
          read: (config) => config.invertedPen,
          write: (config, value) => config.copyWith(invertedPen: value),
        ),
        _inputShortcutSetting(
          id: 'doubleInvertedPenShortcut',
          displayName: (context) =>
              _getDoubleName(context, AppLocalizations.of(context).invertedPen),
          icon: PhosphorIconsLight.pen,
          read: (config) => config.doubleInvertedPenShortcut,
          write: (config, value) =>
              config.copyWith(doubleInvertedPenShortcut: value),
        ),
        _inputShortcutSetting(
          id: 'tripleInvertedPenShortcut',
          displayName: (context) =>
              _getTripleName(AppLocalizations.of(context).invertedPen),
          icon: PhosphorIconsLight.pen,
          read: (config) => config.tripleInvertedPenShortcut,
          write: (config, value) =>
              config.copyWith(tripleInvertedPenShortcut: value),
        ),
        _inputMappingSetting(
          id: 'firstPenButton',
          displayName: (context) => AppLocalizations.of(context).first,
          icon: PhosphorIconsLight.numberCircleOne,
          read: (config) => config.firstPenButton,
          write: (config, value) => config.copyWith(firstPenButton: value),
        ),
        _inputShortcutSetting(
          id: 'doubleFirstPenButtonShortcut',
          displayName: (context) =>
              _getDoubleName(context, AppLocalizations.of(context).first),
          icon: PhosphorIconsLight.numberCircleOne,
          read: (config) => config.doubleFirstPenButtonShortcut,
          write: (config, value) =>
              config.copyWith(doubleFirstPenButtonShortcut: value),
        ),
        _inputShortcutSetting(
          id: 'tripleFirstPenButtonShortcut',
          displayName: (context) =>
              _getTripleName(AppLocalizations.of(context).first),
          icon: PhosphorIconsLight.numberCircleOne,
          read: (config) => config.tripleFirstPenButtonShortcut,
          write: (config, value) =>
              config.copyWith(tripleFirstPenButtonShortcut: value),
        ),
        _inputMappingSetting(
          id: 'secondPenButton',
          displayName: (context) => AppLocalizations.of(context).second,
          icon: PhosphorIconsLight.numberCircleTwo,
          read: (config) => config.secondPenButton,
          write: (config, value) => config.copyWith(secondPenButton: value),
        ),
        _inputShortcutSetting(
          id: 'doubleSecondPenButtonShortcut',
          displayName: (context) =>
              _getDoubleName(context, AppLocalizations.of(context).second),
          icon: PhosphorIconsLight.numberCircleTwo,
          read: (config) => config.doubleSecondPenButtonShortcut,
          write: (config, value) =>
              config.copyWith(doubleSecondPenButtonShortcut: value),
        ),
        _inputShortcutSetting(
          id: 'tripleSecondPenButtonShortcut',
          displayName: (context) =>
              _getTripleName(AppLocalizations.of(context).second),
          icon: PhosphorIconsLight.numberCircleTwo,
          read: (config) => config.tripleSecondPenButtonShortcut,
          write: (config, value) =>
              config.copyWith(tripleSecondPenButtonShortcut: value),
        ),
      ],
    ),
  },
);

Widget _shortcutsHelpHeader(BuildContext context, ButterflySettings state) {
  return Align(
    alignment: AlignmentDirectional.centerEnd,
    child: IconButton(
      icon: const PhosphorIcon(PhosphorIconsLight.sealQuestion),
      tooltip: AppLocalizations.of(context).help,
      onPressed: () => openHelp(['shortcuts'], 'configure'),
    ),
  );
}

String _getDoubleName(BuildContext context, String inputName) =>
    '${AppLocalizations.of(context).double} $inputName';

String _getTripleName(String inputName) => 'Triple $inputName';

String _getIgnorePressureName(
  IgnorePressure ignorePressure,
  BuildContext context,
) => switch (ignorePressure) {
  IgnorePressure.never => AppLocalizations.of(context).never,
  IgnorePressure.first => AppLocalizations.of(context).first,
  IgnorePressure.always => AppLocalizations.of(context).always,
};

SettingsLeapListSetting<ButterflySettings, InputMapping> _inputMappingSetting({
  required String id,
  required SettingsLeapDisplayName displayName,
  required IconData icon,
  required _InputConfigurationRead<InputMapping> read,
  required _InputConfigurationWrite<InputMapping> write,
}) {
  return SettingsLeapListSetting<ButterflySettings, InputMapping>(
    id: id,
    displayName: displayName,
    icon: icon,
    options: [
      SettingsLeapOption(
        id: 'activeTool',
        value: const InputMapping(InputMapping.activeToolValue),
        displayName: (context) => AppLocalizations.of(context).activeTool,
        descriptionBuilder: (context) =>
            AppLocalizations.of(context).activeToolDescription,
      ),
      SettingsLeapOption(
        id: 'handTool',
        value: const InputMapping(InputMapping.handToolValue),
        displayName: (context) => AppLocalizations.of(context).handTool,
        descriptionBuilder: (context) =>
            AppLocalizations.of(context).handToolDescription,
      ),
      for (var index = 0; index < 99; index++)
        SettingsLeapOption(
          id: 'tool${index + 1}',
          value: InputMapping(index),
          displayName: (context) =>
              AppLocalizations.of(context).toolOnToolbarShort(index + 1),
          descriptionBuilder: (context) =>
              AppLocalizations.of(context).toolOnToolbarDescription,
        ),
    ],
    read: (state) => read(state.inputConfiguration),
    write: (context, value) {
      final cubit = context.read<SettingsCubit>();
      cubit.changeInputConfiguration(
        write(cubit.state.inputConfiguration, value),
      );
    },
  );
}

SettingsLeapListSetting<ButterflySettings, String?> _inputShortcutSetting({
  required String id,
  required SettingsLeapDisplayName displayName,
  required IconData icon,
  required _InputConfigurationRead<String?> read,
  required _InputConfigurationWrite<String?> write,
}) {
  return SettingsLeapListSetting<ButterflySettings, String?>(
    id: id,
    displayName: displayName,
    icon: icon,
    options: [
      SettingsLeapOption<String?>(
        id: 'none',
        value: null,
        displayName: (context) => AppLocalizations.of(context).none,
      ),
      SettingsLeapOption<String?>(
        id: 'long_press',
        value: 'long_press',
        displayName: (context) => AppLocalizations.of(context).longPress,
      ),
      for (final shortcut in _projectInputShortcuts)
        SettingsLeapOption<String?>(
          id: shortcut.id,
          value: shortcut.id,
          displayName: (context) => shortcut.getLocalizedName(context),
        ),
    ],
    read: (state) => read(state.inputConfiguration),
    write: (context, value) {
      final cubit = context.read<SettingsCubit>();
      cubit.changeInputConfiguration(
        write(cubit.state.inputConfiguration, value),
      );
    },
  );
}

final _projectInputShortcuts = [
  searchShortcut,
  undoShortcut,
  redoShortcut,
  backgroundShortcut,
  saveShortcut,
  changePathShortcut,
  zoomInShortcut,
  zoomOutShortcut,
  fullScreenShortcut,
  hideUIShortcut,
  nextPageShortcut,
  previousPageShortcut,
  selectAllShortcut,
  pasteShortcut,
  ...changeToolShortcuts,
];

Widget _buildHoldShortcutsSection(
  BuildContext context,
  InputConfiguration config,
) {
  return Card(
    margin: settingsCardMargin,
    child: Padding(
      padding: settingsCardPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: settingsCardTitlePadding,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context).holdShortcuts,
                        style: TextTheme.of(context).headlineSmall,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        AppLocalizations.of(context).holdShortcutsDescription,
                        style: TextTheme.of(context).bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const PhosphorIcon(PhosphorIconsLight.plus),
                  onPressed: () {
                    context.read<SettingsCubit>().changeInputConfiguration(
                      config.copyWith(
                        holdShortcuts: [
                          ...config.holdShortcuts,
                          const HoldShortcut(
                            keyId: 0,
                            mapping: InputMapping(InputMapping.handToolValue),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ...config.holdShortcuts.asMap().entries.map((entry) {
            final index = entry.key;
            final shortcut = entry.value;
            return Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: Text(shortcut.mapping.getDescription(context)),
                    subtitle: Text(AppLocalizations.of(context).action),
                    onTap: () {
                      openInputMappingModal(
                        context,
                        AppLocalizations.of(context).action,
                        shortcut.mapping,
                        (mapping) {
                          final newShortcuts = List<HoldShortcut>.from(
                            config.holdShortcuts,
                          );
                          newShortcuts[index] = shortcut.copyWith(
                            mapping: mapping,
                          );
                          context
                              .read<SettingsCubit>()
                              .changeInputConfiguration(
                                config.copyWith(holdShortcuts: newShortcuts),
                              );
                        },
                      );
                    },
                  ),
                ),
                Expanded(
                  child: KeyRecorderListTile(
                    title: Text(AppLocalizations.of(context).key),
                    currentActivator: SingleActivator(
                      LogicalKeyboardKey(shortcut.keyId),
                    ),
                    onNewKey: (activator) {
                      final newShortcuts = List<HoldShortcut>.from(
                        config.holdShortcuts,
                      );
                      newShortcuts[index] = shortcut.copyWith(
                        keyId: activator.trigger.keyId,
                      );
                      context.read<SettingsCubit>().changeInputConfiguration(
                        config.copyWith(holdShortcuts: newShortcuts),
                      );
                    },
                  ),
                ),
                IconButton(
                  icon: const PhosphorIcon(PhosphorIconsLight.trash),
                  onPressed: () {
                    final newShortcuts = List<HoldShortcut>.from(
                      config.holdShortcuts,
                    );
                    newShortcuts.removeAt(index);
                    context.read<SettingsCubit>().changeInputConfiguration(
                      config.copyWith(holdShortcuts: newShortcuts),
                    );
                  },
                ),
              ],
            );
          }),
        ],
      ),
    ),
  );
}

Widget _buildKeyboardShortcutSection(
  BuildContext context,
  String title,
  List<ShortcutDefinition> shortcuts,
) {
  return ListenableBuilder(
    listenable: keybinder,
    builder: (context, _) => Card(
      margin: settingsCardMargin,
      child: Padding(
        padding: settingsCardPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: settingsCardTitlePadding,
              child: Text(title, style: TextTheme.of(context).headlineSmall),
            ),
            const SizedBox(height: 16),
            LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;
                final columns = width > 600 ? 2 : 1;
                final itemWidth = width / columns;

                return Wrap(
                  children: shortcuts
                      .map(
                        (shortcut) => SizedBox(
                          width: itemWidth,
                          child: KeyRecorderListTile(
                            title: Text(shortcut.getLocalizedName(context)),
                            currentActivator: keybinder.getActivator(
                              shortcut.id,
                            ),
                            onNewKey: (newKey) =>
                                keybinder.updateBinding(shortcut.id, newKey),
                            onReset:
                                keybinder.getActivator(shortcut.id) !=
                                    shortcut.defaultActivator
                                ? () => keybinder.resetBinding(shortcut.id)
                                : null,
                          ),
                        ),
                      )
                      .toList(),
                );
              },
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _selectSensitivitySetting(
  BuildContext context,
  ButterflySettings state,
) {
  return _sensitivitySlider(
    context,
    label: AppLocalizations.of(context).select,
    value: state.selectSensitivity,
    onChangeEnd: (value) =>
        context.read<SettingsCubit>().changeSelectSensitivity(value),
  );
}

Widget _touchSensitivitySetting(BuildContext context, ButterflySettings state) {
  return _sensitivitySlider(
    context,
    label: AppLocalizations.of(context).touch,
    value: state.touchSensitivity,
    onChangeEnd: (value) =>
        context.read<SettingsCubit>().changeTouchSensitivity(value),
  );
}

Widget _gestureSensitivitySetting(
  BuildContext context,
  ButterflySettings state,
) {
  return _sensitivitySlider(
    context,
    label: AppLocalizations.of(context).inputGestures,
    value: state.gestureSensitivity,
    onChangeEnd: (value) =>
        context.read<SettingsCubit>().changeGestureSensitivity(value),
  );
}

Widget _scrollSensitivitySetting(
  BuildContext context,
  ButterflySettings state,
) {
  return _sensitivitySlider(
    context,
    label: AppLocalizations.of(context).scroll,
    value: state.scrollSensitivity,
    onChangeEnd: (value) =>
        context.read<SettingsCubit>().changeScrollSensitivity(value),
  );
}

Widget _sensitivitySlider(
  BuildContext context, {
  required String label,
  required double value,
  required ValueChanged<double> onChangeEnd,
}) {
  return ExactSlider(
    min: 10,
    max: 1000,
    defaultValue: 100,
    fractionDigits: 0,
    value: value * 100,
    header: Text(label),
    onChangeEnd: (value) => onChangeEnd(value / 100),
  );
}

Widget _pointerTestSection(
  BuildContext context,
  ButterflySettings state,
  Widget child,
) {
  return const _PointerTest();
}

void _changeFlag(BuildContext context, String flag, bool enabled) {
  final cubit = context.read<SettingsCubit>();
  if (enabled) {
    cubit.addFlag(flag);
  } else {
    cubit.removeFlag(flag);
  }
}

class _PointerTest extends StatefulWidget {
  const _PointerTest();

  @override
  State<_PointerTest> createState() => __PointerTestState();
}

class __PointerTestState extends State<_PointerTest> {
  PointerDeviceKind? _kind;
  int _buttons = 0;
  double? _pressure, _pressureMin, _pressureMax;
  Color? _pressed;

  void Function(PointerEvent event) _changeInputTest(Color? color) {
    return (PointerEvent event) {
      setState(() {
        _kind = event.kind;
        _buttons = event.buttons;
        _pressure = event.pressure;
        _pressureMin = event.pressureMin;
        _pressureMax = event.pressureMax;
        _pressed = color;
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: settingsCardTitlePadding,
          child: Text(
            AppLocalizations.of(context).pointerTest,
            style: TextTheme.of(context).headlineSmall,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 150,
          child: Listener(
            onPointerMove: _changeInputTest(Colors.blue),
            onPointerDown: _changeInputTest(Colors.green),
            onPointerUp: _changeInputTest(null),
            onPointerCancel: _changeInputTest(Colors.red),
            onPointerPanZoomStart: _changeInputTest(Colors.purple),
            onPointerPanZoomUpdate: _changeInputTest(Colors.purple[700]),
            onPointerPanZoomEnd: _changeInputTest(Colors.purple[900]),
            child: Material(color: _pressed),
          ),
        ),
        const SizedBox(height: 8),
        ListTile(
          title: Text(AppLocalizations.of(context).type),
          subtitle: Text(switch (_kind) {
            PointerDeviceKind.touch => AppLocalizations.of(context).touch,
            PointerDeviceKind.mouse => AppLocalizations.of(context).mouse,
            PointerDeviceKind.stylus => AppLocalizations.of(context).pen,
            PointerDeviceKind.invertedStylus => AppLocalizations.of(
              context,
            ).invert,
            PointerDeviceKind.unknown => AppLocalizations.of(context).error,
            _ => AppLocalizations.of(context).none,
          }),
        ),
        ListTile(
          title: Text(AppLocalizations.of(context).input),
          subtitle: Text('$_buttons (${_buttons.toRadixString(2)})'),
        ),
        ListTile(
          title: Text(AppLocalizations.of(context).pressure),
          subtitle: Text(
            '${_pressure ?? '?'} (${_pressureMin ?? '?'} - ${_pressureMax ?? '?'})',
          ),
        ),
      ],
    );
  }
}
