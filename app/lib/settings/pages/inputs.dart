part of '../home.dart';

typedef _InputConfigurationRead<V> = V Function(InputConfiguration config);
typedef _InputConfigurationWrite<V> = InputConfiguration Function(
  InputConfiguration config,
  V value,
);

final _inputsSettingsPage = SettingsLeapPage<ButterflySettings>(
  displayName: (context) => AppLocalizations.of(context).inputs,
  icon: PhosphorIconsLight.keyboard,
  appBarBuilder: _butterflyAppBar,
  onReset: (context, state) => _resetSettingsPage(
    context,
    (current, defaults) => current.copyWith(
      selectSensitivity: defaults.selectSensitivity,
      touchSensitivity: defaults.touchSensitivity,
      panGestureSensitivity: defaults.panGestureSensitivity,
      zoomGestureSensitivity: defaults.zoomGestureSensitivity,
      rotationGestureSensitivity: defaults.rotationGestureSensitivity,
      scrollPanSensitivity: defaults.scrollPanSensitivity,
    ),
  ),
  children: {
    'mouse': _mouseSettingsPage,
    'touch': _touchSettingsPage,
    'keyboard': _keyboardSettingsPage,
    'stylus': _stylusSettingsPage,
  },
  sections: {
    'devices': SettingsLeapSection(
      settings: [
        SettingsLeapActionSetting(
          displayName: (context) => AppLocalizations.of(context).mouse,
          icon: PhosphorIconsLight.mouse,
          onTap: (context) => openSettingsPage(context, 'inputs.mouse'),
        ),
        SettingsLeapActionSetting(
          displayName: (context) => AppLocalizations.of(context).touch,
          icon: PhosphorIconsLight.hand,
          onTap: (context) => openSettingsPage(context, 'inputs.touch'),
        ),
        SettingsLeapActionSetting(
          displayName: (context) => AppLocalizations.of(context).keyboard,
          icon: PhosphorIconsLight.keyboard,
          onTap: (context) => openSettingsPage(context, 'inputs.keyboard'),
        ),
        SettingsLeapActionSetting(
          displayName: (context) => AppLocalizations.of(context).stylus,
          icon: PhosphorIconsLight.pen,
          onTap: (context) => openSettingsPage(context, 'inputs.stylus'),
        ),
      ],
    ),
    'sensitivity': SettingsLeapSection(
      displayName: (context) => AppLocalizations.of(context).sensitivity,
      settings: [
        _sensitivitySetting(
          id: 'selectSensitivity',
          displayName: (context) =>
              AppLocalizations.of(context).selectionTolerance,
          hintBuilder: (context) =>
              AppLocalizations.of(context).selectionToleranceDescription,
          read: (state) => state.selectSensitivity,
          write: (context, value) =>
              context.read<SettingsCubit>().changeSelectSensitivity(value),
        ),
        _sensitivitySetting(
          id: 'touchSensitivity',
          displayName: (context) =>
              AppLocalizations.of(context).selectionHandleSensitivity,
          hintBuilder: (context) =>
              AppLocalizations.of(context)
                  .selectionHandleSensitivityDescription,
          read: (state) => state.touchSensitivity,
          write: (context, value) =>
              context.read<SettingsCubit>().changeTouchSensitivity(value),
        ),
        _sensitivitySetting(
          id: 'panGestureSensitivity',
          displayName: (context) =>
              AppLocalizations.of(context).panGestureSensitivity,
          hintBuilder: (context) =>
              AppLocalizations.of(context).panGestureSensitivityDescription,
          read: (state) => state.panGestureSensitivity,
          write: (context, value) =>
              context.read<SettingsCubit>().changePanGestureSensitivity(value),
        ),
        _sensitivitySetting(
          id: 'zoomGestureSensitivity',
          displayName: (context) =>
              AppLocalizations.of(context).zoomGestureSensitivity,
          hintBuilder: (context) =>
              AppLocalizations.of(context).zoomGestureSensitivityDescription,
          read: (state) => state.zoomGestureSensitivity,
          write: (context, value) =>
              context.read<SettingsCubit>().changeZoomGestureSensitivity(value),
        ),
        _sensitivitySetting(
          id: 'rotationGestureSensitivity',
          displayName: (context) =>
              AppLocalizations.of(context).rotationGestureSensitivity,
          hintBuilder: (context) =>
              AppLocalizations.of(context)
                  .rotationGestureSensitivityDescription,
          read: (state) => state.rotationGestureSensitivity,
          write: (context, value) => context
              .read<SettingsCubit>()
              .changeRotationGestureSensitivity(value),
        ),
        _sensitivitySetting(
          id: 'scrollPanSensitivity',
          displayName: (context) =>
              AppLocalizations.of(context).scrollPanSensitivity,
          hintBuilder: (context) =>
              AppLocalizations.of(context).scrollPanSensitivityDescription,
          read: (state) => state.scrollPanSensitivity,
          write: (context, value) =>
              context.read<SettingsCubit>().changeScrollPanSensitivity(value),
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
  onReset: (context, state) => _resetSettingsPage(
    context,
    (current, defaults) => current.copyWith(
      hideCursorWhileDrawing: defaults.hideCursorWhileDrawing,
      inputConfiguration: current.inputConfiguration.copyWith(
        leftMouse: defaults.inputConfiguration.leftMouse,
        doubleLeftMouseShortcut:
            defaults.inputConfiguration.doubleLeftMouseShortcut,
        tripleLeftMouseShortcut:
            defaults.inputConfiguration.tripleLeftMouseShortcut,
        middleMouse: defaults.inputConfiguration.middleMouse,
        doubleMiddleMouseShortcut:
            defaults.inputConfiguration.doubleMiddleMouseShortcut,
        tripleMiddleMouseShortcut:
            defaults.inputConfiguration.tripleMiddleMouseShortcut,
        rightMouse: defaults.inputConfiguration.rightMouse,
        doubleRightMouseShortcut:
            defaults.inputConfiguration.doubleRightMouseShortcut,
        tripleRightMouseShortcut:
            defaults.inputConfiguration.tripleRightMouseShortcut,
        backMouse: defaults.inputConfiguration.backMouse,
        doubleBackMouseShortcut:
            defaults.inputConfiguration.doubleBackMouseShortcut,
        tripleBackMouseShortcut:
            defaults.inputConfiguration.tripleBackMouseShortcut,
        forwardMouse: defaults.inputConfiguration.forwardMouse,
        doubleForwardMouseShortcut:
            defaults.inputConfiguration.doubleForwardMouseShortcut,
        tripleForwardMouseShortcut:
            defaults.inputConfiguration.tripleForwardMouseShortcut,
      ),
    ),
  ),
  sections: {
    'behavior': SettingsLeapSection(
      settings: [
        SettingsLeapBoolSetting(
          id: 'hideCursorWhileDrawing',
          displayName: (context) =>
              AppLocalizations.of(context).hideCursorWhileDrawing,
          hintBuilder: (context) =>
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
        _inputMappingSetting(
          id: 'middleMouse',
          displayName: (context) => AppLocalizations.of(context).middle,
          icon: PhosphorIconsLight.mouseMiddleClick,
          read: (config) => config.middleMouse,
          write: (config, value) => config.copyWith(middleMouse: value),
        ),
        _inputMappingSetting(
          id: 'rightMouse',
          displayName: (context) => AppLocalizations.of(context).right,
          icon: PhosphorIconsLight.mouseRightClick,
          read: (config) => config.rightMouse,
          write: (config, value) => config.copyWith(rightMouse: value),
        ),
        _optionalInputMappingSetting(
          id: 'backMouse',
          displayName: (context) => AppLocalizations.of(context).back,
          icon: PhosphorIconsLight.mouse,
          read: (config) => config.backMouse,
          write: (config, value) => config.copyWith(backMouse: value),
        ),
        _optionalInputMappingSetting(
          id: 'forwardMouse',
          displayName: (context) => AppLocalizations.of(context).forward,
          icon: PhosphorIconsLight.mouse,
          read: (config) => config.forwardMouse,
          write: (config, value) => config.copyWith(forwardMouse: value),
        ),
      ],
    ),
    'repeatedTapShortcuts': SettingsLeapSection(
      displayName: (context) =>
          AppLocalizations.of(context).repeatedTapShortcuts,
      settings: [
        _repeatedTapShortcutsNote,
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
        _inputShortcutSetting(
          id: 'doubleBackMouseShortcut',
          displayName: (context) =>
              _getDoubleName(context, AppLocalizations.of(context).back),
          icon: PhosphorIconsLight.mouse,
          read: (config) => config.doubleBackMouseShortcut,
          write: (config, value) =>
              config.copyWith(doubleBackMouseShortcut: value),
        ),
        _inputShortcutSetting(
          id: 'tripleBackMouseShortcut',
          displayName: (context) =>
              _getTripleName(AppLocalizations.of(context).back),
          icon: PhosphorIconsLight.mouse,
          read: (config) => config.tripleBackMouseShortcut,
          write: (config, value) =>
              config.copyWith(tripleBackMouseShortcut: value),
        ),
        _inputShortcutSetting(
          id: 'doubleForwardMouseShortcut',
          displayName: (context) =>
              _getDoubleName(context, AppLocalizations.of(context).forward),
          icon: PhosphorIconsLight.mouse,
          read: (config) => config.doubleForwardMouseShortcut,
          write: (config, value) =>
              config.copyWith(doubleForwardMouseShortcut: value),
        ),
        _inputShortcutSetting(
          id: 'tripleForwardMouseShortcut',
          displayName: (context) =>
              _getTripleName(AppLocalizations.of(context).forward),
          icon: PhosphorIconsLight.mouse,
          read: (config) => config.tripleForwardMouseShortcut,
          write: (config, value) =>
              config.copyWith(tripleForwardMouseShortcut: value),
        ),
      ],
    ),
  },
);

final _touchSettingsPage = SettingsLeapPage<ButterflySettings>(
  displayName: (context) => AppLocalizations.of(context).touch,
  icon: PhosphorIconsLight.hand,
  appBarBuilder: _butterflyAppBar,
  onReset: (context, state) => _resetSettingsPage(
    context,
    (current, defaults) => current.copyWith(
      inputGestures: defaults.inputGestures,
      moveOnGesture: defaults.moveOnGesture,
      rotateOnGesture: defaults.rotateOnGesture,
      inputConfiguration: current.inputConfiguration.copyWith(
        touch: defaults.inputConfiguration.touch,
        doubleTouchShortcut: defaults.inputConfiguration.doubleTouchShortcut,
        tripleTouchShortcut: defaults.inputConfiguration.tripleTouchShortcut,
        twoFingerTouchShortcut:
            defaults.inputConfiguration.twoFingerTouchShortcut,
        threeFingerTouchShortcut:
            defaults.inputConfiguration.threeFingerTouchShortcut,
      ),
    ),
  ),
  sections: {
    'behavior': SettingsLeapSection(
      settings: [
        SettingsLeapBoolSetting(
          id: 'inputGestures',
          displayName: (context) => AppLocalizations.of(context).inputGestures,
          hintBuilder: (context) =>
              AppLocalizations.of(context).inputGesturesDescription,
          icon: PhosphorIconsLight.handTap,
          read: (state) => state.inputGestures,
          write: (context, value) =>
              context.read<SettingsCubit>().changeInputGestures(value),
        ),
        SettingsLeapBoolSetting(
          id: 'moveOnGesture',
          displayName: (context) => AppLocalizations.of(context).moveOnGesture,
          hintBuilder: (context) =>
              AppLocalizations.of(context).moveOnGestureDescription,
          icon: PhosphorIconsLight.arrowsOutCardinal,
          read: (state) => state.moveOnGesture,
          write: (context, value) =>
              context.read<SettingsCubit>().changeMoveOnGesture(value),
        ),
        SettingsLeapBoolSetting(
          id: 'rotateOnGesture',
          displayName: (context) => AppLocalizations.of(context).rotation,
          icon: PhosphorIconsLight.arrowClockwise,
          read: (state) => state.rotateOnGesture,
          write: (context, value) =>
              context.read<SettingsCubit>().changeRotateOnGesture(value),
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
          id: 'twoFingerTouchShortcut',
          displayName: (context) => AppLocalizations.of(context).twoFingerTap,
          icon: PhosphorIconsLight.handTap,
          read: (config) => config.twoFingerTouchShortcut,
          write: (config, value) =>
              config.copyWith(twoFingerTouchShortcut: value),
        ),
        _inputShortcutSetting(
          id: 'threeFingerTouchShortcut',
          displayName: (context) => AppLocalizations.of(context).threeFingerTap,
          icon: PhosphorIconsLight.handTap,
          read: (config) => config.threeFingerTouchShortcut,
          write: (config, value) =>
              config.copyWith(threeFingerTouchShortcut: value),
        ),
      ],
    ),
    'repeatedTapShortcuts': SettingsLeapSection(
      displayName: (context) =>
          AppLocalizations.of(context).repeatedTapShortcuts,
      settings: [
        _repeatedTapShortcutsNote,
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
  onReset: (context, state) async {
    await Future.wait([
      context.read<SettingsCubit>().resetSettings(
        (current, defaults) => current.copyWith(
          inputConfiguration: current.inputConfiguration.copyWith(
            holdShortcuts: defaults.inputConfiguration.holdShortcuts,
          ),
        ),
      ),
      keybinder.resetToDefaults(),
    ]);
  },
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
            resetZoomShortcut,
            rotateLeftShortcut,
            rotateRightShortcut,
            rotateDragShortcut,
            fullScreenShortcut,
            hideUIShortcut,
            nextShortcut,
            previousShortcut,
            nextPageShortcut,
            previousPageShortcut,
            togglePresentationShortcut,
            selectAllShortcut,
            pasteShortcut,
            contextMenuShortcut,
            ...changeToolShortcuts,
          ]),
    ),
  },
);

final _stylusSettingsPage = SettingsLeapPage<ButterflySettings>(
  displayName: (context) => AppLocalizations.of(context).stylus,
  icon: PhosphorIconsLight.pen,
  appBarBuilder: _butterflyAppBar,
  onReset: (context, state) => _resetSettingsPage(
    context,
    (current, defaults) => current.copyWith(
      penOnlyInput: defaults.penOnlyInput,
      showPenOnlyToggle: defaults.showPenOnlyToggle,
      ignorePressure: defaults.ignorePressure,
      inputConfiguration: current.inputConfiguration.copyWith(
        pen: defaults.inputConfiguration.pen,
        doublePenShortcut: defaults.inputConfiguration.doublePenShortcut,
        triplePenShortcut: defaults.inputConfiguration.triplePenShortcut,
        invertedPen: defaults.inputConfiguration.invertedPen,
        doubleInvertedPenShortcut:
            defaults.inputConfiguration.doubleInvertedPenShortcut,
        tripleInvertedPenShortcut:
            defaults.inputConfiguration.tripleInvertedPenShortcut,
        firstPenButton: defaults.inputConfiguration.firstPenButton,
        doubleFirstPenButtonShortcut:
            defaults.inputConfiguration.doubleFirstPenButtonShortcut,
        tripleFirstPenButtonShortcut:
            defaults.inputConfiguration.tripleFirstPenButtonShortcut,
        secondPenButton: defaults.inputConfiguration.secondPenButton,
        doubleSecondPenButtonShortcut:
            defaults.inputConfiguration.doubleSecondPenButtonShortcut,
        tripleSecondPenButtonShortcut:
            defaults.inputConfiguration.tripleSecondPenButtonShortcut,
      ),
    ),
  ),
  sections: {
    'behavior': SettingsLeapSection(
      settings: [
        SettingsLeapListSetting<ButterflySettings, bool?>(
          id: 'penOnlyInput',
          displayName: (context) => AppLocalizations.of(context).penOnlyInput,
          hintBuilder: (context) =>
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
          hintBuilder: (context) =>
              AppLocalizations.of(context).showPenOnlyToggleDescription,
          icon: PhosphorIconsLight.toggleRight,
          read: (state) => state.showPenOnlyToggle,
          write: (context, value) =>
              context.read<SettingsCubit>().changeShowPenOnlyToggle(value),
        ),
        SettingsLeapListSetting<ButterflySettings, IgnorePressure>(
          id: 'ignorePressure',
          displayName: (context) => AppLocalizations.of(context).ignorePressure,
          hintBuilder: (context) =>
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
                  .never => AppLocalizations.of(
                    context,
                  ).ignorePressureNeverDescription,
                  .first => AppLocalizations.of(
                    context,
                  ).ignoreFirstPressureDescription,
                  .always => AppLocalizations.of(
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
          displayName: (context) => AppLocalizations.of(context).stylus,
          icon: PhosphorIconsLight.pen,
          read: (config) => config.pen,
          write: (config, value) => config.copyWith(pen: value),
        ),
        _inputMappingSetting(
          id: 'invertedPen',
          displayName: (context) => AppLocalizations.of(context).invertedPen,
          icon: PhosphorIconsLight.pen,
          read: (config) => config.invertedPen,
          write: (config, value) => config.copyWith(invertedPen: value),
        ),
        _inputMappingSetting(
          id: 'firstPenButton',
          displayName: (context) => AppLocalizations.of(context).first,
          icon: PhosphorIconsLight.numberCircleOne,
          read: (config) => config.firstPenButton,
          write: (config, value) => config.copyWith(firstPenButton: value),
        ),
        _inputMappingSetting(
          id: 'secondPenButton',
          displayName: (context) => AppLocalizations.of(context).second,
          icon: PhosphorIconsLight.numberCircleTwo,
          read: (config) => config.secondPenButton,
          write: (config, value) => config.copyWith(secondPenButton: value),
        ),
      ],
    ),
    'repeatedTapShortcuts': SettingsLeapSection(
      displayName: (context) =>
          AppLocalizations.of(context).repeatedTapShortcuts,
      settings: [
        _repeatedTapShortcutsNote,
        _inputShortcutSetting(
          id: 'doublePenShortcut',
          displayName: (context) =>
              _getDoubleName(context, AppLocalizations.of(context).stylus),
          icon: PhosphorIconsLight.pen,
          read: (config) => config.doublePenShortcut,
          write: (config, value) => config.copyWith(doublePenShortcut: value),
        ),
        _inputShortcutSetting(
          id: 'triplePenShortcut',
          displayName: (context) =>
              _getTripleName(AppLocalizations.of(context).stylus),
          icon: PhosphorIconsLight.pen,
          read: (config) => config.triplePenShortcut,
          write: (config, value) => config.copyWith(triplePenShortcut: value),
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

final _repeatedTapShortcutsNote = SettingsLeapCustomSetting<ButterflySettings>(
  id: 'inputDelayNote',
  displayName: (context) => AppLocalizations.of(context).repeatedTapShortcuts,
  builder: (context, state) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
    child: Text(
      AppLocalizations.of(context).repeatedTapShortcutsDescription,
      style: TextTheme.of(context).bodyMedium,
    ),
  ),
);

Widget _shortcutsHelpHeader(BuildContext context, ButterflySettings state) {
  return IconButton(
    icon: const PhosphorIcon(PhosphorIconsLight.sealQuestion),
    tooltip: AppLocalizations.of(context).help,
    onPressed: () => openHelp(['shortcuts'], 'configure'),
  );
}

String _getDoubleName(BuildContext context, String inputName) =>
    '${AppLocalizations.of(context).double} $inputName';

String _getTripleName(String inputName) => 'Triple $inputName';

String _getIgnorePressureName(
  IgnorePressure ignorePressure,
  BuildContext context,
) => switch (ignorePressure) {
  .never => AppLocalizations.of(context).never,
  .first => AppLocalizations.of(context).first,
  .always => AppLocalizations.of(context).always,
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
    disableOptionSearch: true,
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

SettingsLeapListSetting<ButterflySettings, InputMapping?>
_optionalInputMappingSetting({
  required String id,
  required SettingsLeapDisplayName displayName,
  required IconData icon,
  required _InputConfigurationRead<InputMapping?> read,
  required _InputConfigurationWrite<InputMapping?> write,
}) {
  return SettingsLeapListSetting<ButterflySettings, InputMapping?>(
    id: id,
    disableOptionSearch: true,
    displayName: displayName,
    icon: icon,
    options: [
      SettingsLeapOption<InputMapping?>(
        id: 'none',
        value: null,
        displayName: (context) => AppLocalizations.of(context).none,
      ),
      SettingsLeapOption<InputMapping?>(
        id: 'activeTool',
        value: const InputMapping(InputMapping.activeToolValue),
        displayName: (context) => AppLocalizations.of(context).activeTool,
        descriptionBuilder: (context) =>
            AppLocalizations.of(context).activeToolDescription,
      ),
      SettingsLeapOption<InputMapping?>(
        id: 'handTool',
        value: const InputMapping(InputMapping.handToolValue),
        displayName: (context) => AppLocalizations.of(context).handTool,
        descriptionBuilder: (context) =>
            AppLocalizations.of(context).handToolDescription,
      ),
      for (var index = 0; index < 99; index++)
        SettingsLeapOption<InputMapping?>(
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
    disableOptionSearch: true,
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
  resetZoomShortcut,
  rotateLeftShortcut,
  rotateRightShortcut,
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
        crossAxisAlignment: .stretch,
        children: [
          Padding(
            padding: settingsCardTitlePadding,
            child: Row(
              crossAxisAlignment: .start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: .start,
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
          crossAxisAlignment: .stretch,
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

SettingsLeapSliderSetting<ButterflySettings> _sensitivitySetting({
  required String id,
  required SettingsLeapDisplayName displayName,
  required SettingsLeapDisplayName hintBuilder,
  required SettingsLeapStateReader<ButterflySettings, double> read,
  required SettingsLeapStateWriter<double> write,
}) => SettingsLeapSliderSetting(
  id: id,
  displayName: displayName,
  hintBuilder: hintBuilder,
  min: 10,
  max: 1000,
  defaultValue: 100,
  fractionDigits: 0,
  read: (state) => read(state) * 100,
  write: (context, value) => write(context, value.round() / 100),
);

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
      crossAxisAlignment: .stretch,
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
            .touch => AppLocalizations.of(context).touch,
            .mouse => AppLocalizations.of(context).mouse,
            .stylus => AppLocalizations.of(context).stylus,
            .invertedStylus => AppLocalizations.of(context).invert,
            .unknown => AppLocalizations.of(context).error,
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
