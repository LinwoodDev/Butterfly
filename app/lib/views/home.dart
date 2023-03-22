import 'package:butterfly/views/window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:window_manager/window_manager.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: (!kIsWeb && isWindow)
          ? PreferredSize(
              preferredSize: Size.fromHeight(
                  Theme.of(context).appBarTheme.toolbarHeight ?? 56),
              child: DragToMoveArea(
                child: AppBar(actions: const [
                  WindowButtons(),
                ]),
              ),
            )
          : null,
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 32),
            constraints: const BoxConstraints(maxWidth: 1400),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 64),
                _HeaderHomeView(colorScheme: colorScheme),
                const SizedBox(height: 64),
                LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth > 1000) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Expanded(child: _FilesHomeView()),
                          SizedBox(width: 32),
                          SizedBox(width: 500, child: _QuickstartHomeView()),
                        ],
                      );
                    } else {
                      return Column(
                        children: const [
                          _QuickstartHomeView(),
                          SizedBox(height: 32),
                          _FilesHomeView(),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HeaderHomeView extends StatelessWidget {
  const _HeaderHomeView({
    required this.colorScheme,
  });

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final actions = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(PhosphorIcons.bookOpenLight),
            label: Text(AppLocalizations.of(context).documentation),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(PhosphorIcons.gearLight),
            tooltip: AppLocalizations.of(context).settings,
          ),
        ],
      );
      final isDesktop = constraints.maxWidth > 1000;
      final whatsNew = FilledButton(
        onPressed: () {},
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 16,
          ),
        ),
        child: const Text('What\'s new?'),
      );
      final logo = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'images/logo.png',
            width: 64,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Hey, this is Linwood Butterfly',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: colorScheme.onInverseSurface,
                      ),
                  overflow: TextOverflow.clip,
                ),
                Text(
                  'A free and open-cource drawing space!',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colorScheme.onInverseSurface,
                      ),
                ),
              ],
            ),
          ),
        ],
      );
      final innerCard = isDesktop
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: logo),
                const SizedBox(width: 32),
                whatsNew,
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                logo,
                const SizedBox(height: 32),
                whatsNew,
              ],
            );
      final card = Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                colorScheme.inverseSurface,
                colorScheme.inversePrimary,
              ],
              stops: const [0, 0.8],
            ),
          ),
          child: innerCard,
        ),
      );
      if (isDesktop) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: card),
            const SizedBox(width: 32),
            actions,
          ],
        );
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            card,
            const SizedBox(height: 32),
            actions,
          ],
        );
      }
    });
  }
}

class _FilesHomeView extends StatelessWidget {
  const _FilesHomeView();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        runAlignment: WrapAlignment.spaceBetween,
        runSpacing: 16,
        spacing: 16,
        children: [
          Text(
            'Files',
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.start,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Switch view'),
              IconButton(
                onPressed: () {},
                icon: const Icon(PhosphorIcons.gridFourLight),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Source'),
              const SizedBox(width: 8),
              SizedBox(
                width: 150,
                child: DropdownButtonFormField(
                  items: const [
                    DropdownMenuItem(
                      value: 0,
                      child: Text('Local'),
                    ),
                  ],
                  value: 0,
                  onChanged: (int? value) {},
                ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Sort by'),
              const SizedBox(width: 8),
              SizedBox(
                width: 150,
                child: DropdownButtonFormField(
                  items: const [
                    DropdownMenuItem(
                      value: 0,
                      child: Text('Latest'),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(16),
                  value: 0,
                  onChanged: (int? value) {},
                ),
              ),
            ],
          ),
        ],
      ),
      const SizedBox(height: 16),
      ListView.builder(
        shrinkWrap: true,
        itemCount: 50,
        itemBuilder: (context, index) {
          final selected = index == 3;
          return Row(
            children: [
              Expanded(
                  child: Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: selected
                      ? BorderSide(
                          color: colorScheme.primaryContainer,
                          width: 1,
                        )
                      : BorderSide.none,
                ),
                surfaceTintColor: index == 3
                    ? colorScheme.primaryContainer
                    : colorScheme.secondaryContainer,
                clipBehavior: Clip.hardEdge,
                child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 32,
                      ),
                      child: LayoutBuilder(builder: (context, constraints) {
                        final fileName = Text('File $index');
                        final actions = Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(PhosphorIcons.starLight),
                            ),
                          ],
                        );
                        final modified = Text(
                          '1 hour ago',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: colorScheme.outline,
                                  ),
                        );
                        final isDesktop = constraints.maxWidth > 400;
                        if (isDesktop) {
                          return Row(
                            children: [
                              Expanded(child: fileName),
                              const SizedBox(width: 32),
                              modified,
                              const SizedBox(width: 32),
                              actions,
                            ],
                          );
                        } else {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  fileName,
                                  const SizedBox(height: 8),
                                  modified,
                                ],
                              ),
                              const SizedBox(width: 8),
                              actions,
                            ],
                          );
                        }
                      }),
                    )),
              )),
              const SizedBox(width: 16),
              IconButton(
                onPressed: () {},
                icon: const Icon(PhosphorIcons.paperPlaneRightLight),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(PhosphorIcons.trashLight),
              ),
            ],
          );
        },
      ),
    ]);
  }
}

class _QuickstartHomeView extends StatelessWidget {
  const _QuickstartHomeView();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(32),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Text(
            'Quickstart',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          Wrap(
            alignment: WrapAlignment.center,
            runAlignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            runSpacing: 16,
            spacing: 16,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 200),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Card(
                    color: Colors.white70,
                    elevation: 5,
                    margin: const EdgeInsets.all(8),
                    child: Align(
                      child: Text(
                        'Light',
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 200),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Card(
                    color: Colors.black87,
                    elevation: 5,
                    margin: const EdgeInsets.all(8),
                    child: Align(
                      child: Text(
                        'Dark',
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ]),
      ),
    );
  }
}
