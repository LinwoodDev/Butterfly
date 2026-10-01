import 'dart:typed_data';

import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:butterfly/views/files/grid.dart';
import 'package:butterfly/views/files/list.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:mocktail/mocktail.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../helpers/mocks.dart';

void main() {
  setUpAll(() => registerFallbackValue(AssetLocation.empty));

  for (final grid in [false, true]) {
    for (final submit in [false, true]) {
      for (final extension in ['bfly', 'tbfly']) {
        testWidgets(
          '${grid ? 'grid' : 'list'} rename via ${submit ? 'Enter' : 'button'} preserves .$extension',
          (tester) async {
            final fileSystem = MockButterflyFileSystem();
            final settingsCubit = fileSystem.settingsCubit as MockSettingsCubit;
            when(() => settingsCubit.state)
                .thenReturn(const ButterflySettings());
            when(() => settingsCubit.getRemote(any())).thenReturn(null);
            when(() => settingsCubit.stream)
                .thenAnswer((_) => const Stream.empty());
            when(
              () => settingsCubit.moveAssetReferences(
                any(),
                any(),
                directory: any(named: 'directory'),
              ),
            ).thenAnswer((_) async {});
            final system = fileSystem.buildDocumentSystem();
            final entity = await system.createFile(
              '/notes/original.$extension',
              NoteFile(Uint8List.fromList([1, 2, 3])),
            );
            final nameController = TextEditingController(text: entity.fileName);
            addTearDown(nameController.dispose);
            final Widget item = grid
                ? FileEntityGridItem(
                    editable: true,
                    icon: PhosphorIconsLight.file,
                    entity: entity,
                    nameController: nameController,
                    actionButton: const SizedBox.shrink(),
                    onTap: () {},
                    onDelete: () {},
                    onReload: () {},
                    onEdit: (_) {},
                    onSelectedChanged: (_) {},
                  )
                : FileEntityListTile(
                    editable: true,
                    icon: PhosphorIconsLight.file,
                    entity: entity,
                    nameController: nameController,
                    actionButton: const SizedBox.shrink(),
                    onTap: () {},
                    onDelete: () {},
                    onReload: () {},
                    onEdit: (_) {},
                    onSelectedChanged: (_) {},
                  );
            await tester.pumpWidget(
              RepositoryProvider<ButterflyFileSystem>.value(
                value: fileSystem,
                child: BlocProvider<SettingsCubit>.value(
                  value: settingsCubit,
                  child: MaterialApp(
                    localizationsDelegates:
                        AppLocalizations.localizationsDelegates,
                    supportedLocales: AppLocalizations.supportedLocales,
                    home: Scaffold(body: Center(child: item)),
                  ),
                ),
              ),
            );
            await tester.enterText(find.byType(TextField), 'Important note');
            if (submit) {
              await tester.testTextInput.receiveAction(TextInputAction.done);
            } else {
              await tester.tap(find.byTooltip('Save'));
            }
            await tester.pumpAndSettle();

            final renamed = await system.getAsset(
              '/notes/Important note.$extension',
            );
            expect(renamed, isA<FileSystemFile<NoteFile>>());
            expect(await system.getAsset('/notes/Important note'), isNull);
            expect(await system.getAsset(entity.path), isNull);
            verify(
              () => settingsCubit.moveAssetReferences(
                entity.location,
                AssetLocation(path: '/notes/Important note.$extension'),
                directory: false,
              ),
            ).called(1);
          },
        );
      }
    }
  }
}
