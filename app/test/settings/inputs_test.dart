import 'package:archive/archive.dart';
import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/dialogs/input.dart';
import 'package:butterfly/dialogs/packs/select.dart';
import 'package:butterfly/settings/home.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:material_leap/material_leap.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/mocks.dart';

class _FileSystem extends MockButterflyFileSystem {
  final pack = NoteData(Archive())
      .setMetadata(
        const FileMetadata(type: NoteFileType.pack, name: 'Studio erasers'),
      )
      .setToolPreset('soft', EraserTool(name: 'Soft eraser', strokeWidth: 64));

  @override
  Future<Tool?> getToolPreset(PackAssetLocation location) async =>
      location.namespace == 'erasers.bfly'
      ? pack.getToolPreset(location.key)
      : super.getToolPreset(location);

  @override
  String getToolPresetPackName(PackAssetLocation location) =>
      location.namespace == 'erasers.bfly'
      ? getPackDisplayName(pack, location.namespace)
      : super.getToolPresetPackName(location);

  @override
  Future<List<(String, NoteData)>> getCoreAndUserPacks([
    ExternalStorage? storage,
  ]) async => [('erasers.bfly', pack)];
}

void main() {
  testWidgets(
    'stylus settings select a preset and switch back to a normal mapping',
    (tester) async {
      tester.view.physicalSize = const Size(1000, 1600);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      FlutterSecureStorage.setMockInitialValues({});
      SharedPreferences.setMockInitialValues({});
      final cubit = SettingsCubit(await SharedPreferences.getInstance());
      addTearDown(cubit.close);
      await tester.pumpWidget(
        RepositoryProvider<ButterflyFileSystem>.value(
          value: _FileSystem(),
          child: BlocProvider.value(
            value: cubit,
            child: MaterialApp(
              localizationsDelegates: const [
                ...AppLocalizations.localizationsDelegates,
                LeapLocalizations.delegate,
              ],
              supportedLocales: AppLocalizations.supportedLocales,
              home: const SettingsDetailsPage(
                id: 'inputs.stylus',
                inView: true,
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.text('Inverted Stylus'));
      await tester.tap(find.text('Inverted Stylus'));
      await tester.pumpAndSettle();
      expect(find.byType(InputMappingOptions), findsOneWidget);
      await tester.tap(find.byTooltip('Select asset'));
      await tester.pumpAndSettle();
      final assetTile = tester.widget<ListTile>(
        find.ancestor(of: find.text('soft'), matching: find.byType(ListTile)),
      );
      expect((assetTile.title as Text).data, 'soft');
      expect((assetTile.subtitle as Text).data, 'Studio erasers');
      await tester.tap(find.text('soft'));
      await tester.pumpAndSettle();
      expect(
        cubit.state.inputConfiguration.invertedPen,
        const InputMapping.preset(PackAssetLocation('erasers.bfly', 'soft')),
      );
      expect(find.text('Soft eraser · Studio erasers'), findsWidgets);
      await tester.tap(
        find.descendant(
          of: find.byType(InputMappingOptions),
          matching: find.text('Active Tool'),
        ),
      );
      await tester.pumpAndSettle();
      expect(
        cubit.state.inputConfiguration.invertedPen,
        InputMappingDefault.pen,
      );
      await tester.tap(
        find.descendant(
          of: find.byType(InputMappingOptions),
          matching: find.text('Hand Tool'),
        ),
      );
      await tester.pumpAndSettle();
      expect(
        cubit.state.inputConfiguration.invertedPen,
        InputMappingDefault.middleMouse,
      );
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('optional mappings can be cleared', (tester) async {
    InputMapping? mapping = InputMappingDefault.leftMouse;
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: InputMappingOptions(
            startingValue: mapping,
            allowNone: true,
            onChanged: (value) => mapping = value,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('None'));
    await tester.pumpAndSettle();
    expect(mapping, isNull);
    await tester.tap(find.text('Hand Tool'));
    await tester.pumpAndSettle();
    expect(mapping, InputMappingDefault.middleMouse);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'preset selection starts empty and cancelling keeps the current mapping',
    (tester) async {
      InputMapping? mapping = InputMappingDefault.leftMouse;
      await tester.pumpWidget(
        RepositoryProvider<ButterflyFileSystem>.value(
          value: _FileSystem(),
          child: MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: Scaffold(
              body: InputMappingOptions(
                startingValue: mapping,
                onChanged: (value) => mapping = value,
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Select asset'), findsOneWidget);
      expect(find.textContaining('Core.bfly'), findsNothing);
      await tester.tap(find.text('Presets'));
      await tester.pumpAndSettle();
      expect(
        tester
            .widget<SelectPackAssetDialog>(find.byType(SelectPackAssetDialog))
            .selected,
        isNull,
      );
      expect(mapping, InputMappingDefault.leftMouse);
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      expect(mapping, InputMappingDefault.leftMouse);
      expect(find.text('Select asset'), findsOneWidget);
      await tester.tap(find.text('Presets'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('soft'));
      await tester.pumpAndSettle();
      expect(
        mapping,
        const InputMapping.preset(PackAssetLocation('erasers.bfly', 'soft')),
      );
      expect(find.text('Soft eraser · Studio erasers'), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );
}
