import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: SingleChildScrollView(
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 64),
                  Row(
                    children: [
                      Expanded(
                        child: Material(
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
                                    colorScheme.surfaceVariant,
                                    colorScheme.inversePrimary,
                                  ],
                                  stops: const [0, 0.8],
                                ),
                              ),
                              child: Row(
                                children: [
                                  Image.asset(
                                    'images/logo.png',
                                    width: 64,
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Linwood Butterfly',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge
                                              ?.copyWith(),
                                        ),
                                        Text(
                                            AppLocalizations.of(context)
                                                .welcome,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith()),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  FilledButton(
                                    onPressed: () {},
                                    style: FilledButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 32,
                                        vertical: 16,
                                      ),
                                    ),
                                    child: const Text('What\'s new?'),
                                  ),
                                ],
                              )),
                        ),
                      ),
                      const SizedBox(width: 16),
                      TextButton(
                        onPressed: () {},
                        child: Text(AppLocalizations.of(context).documentation),
                      ),
                    ],
                  ),
                  const SizedBox(height: 64),
                  Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    runAlignment: WrapAlignment.spaceBetween,
                    children: [
                      Text(
                        'Files',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Row(mainAxisSize: MainAxisSize.min, children: [
                        const Text('Switch view'),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(PhosphorIcons.gridFourLight),
                        ),
                        const SizedBox(width: 32),
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
                            decoration: const InputDecoration(
                              filled: true,
                            ),
                            value: 0,
                            onChanged: (int? value) {},
                          ),
                        ),
                        const SizedBox(width: 32),
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
                            decoration: const InputDecoration(
                              filled: true,
                            ),
                            value: 0,
                            onChanged: (int? value) {},
                          ),
                        ),
                      ]),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: 50,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Expanded(
                              child: Card(
                                  elevation: 5,
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 0,
                                  ),
                                  surfaceTintColor: index == 3
                                      ? colorScheme.primary
                                      : colorScheme.secondaryContainer,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                      horizontal: 32,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('File $index'),
                                        Row(children: [
                                          Text(
                                            'Edited 1 hour ago',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                  color: colorScheme.outline,
                                                ),
                                          ),
                                          const SizedBox(width: 16),
                                          IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                                PhosphorIcons.starLight),
                                          ),
                                        ]),
                                      ],
                                    ),
                                  ))),
                          const SizedBox(width: 16),
                          IconButton(
                            onPressed: () {},
                            icon:
                                const Icon(PhosphorIcons.paperPlaneRightLight),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(PhosphorIcons.trashLight),
                          ),
                        ],
                      );
                    },
                  ),
                ]),
          ),
        ]),
      ),
    );
  }
}
