import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ErrorPage extends StatelessWidget {
  final String message;
  final StackTrace? stackTrace;
  const ErrorPage({super.key, this.message = '', this.stackTrace});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context).error)),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Align(
              alignment: Alignment.center,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                  maxWidth: 600,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              message,
                              style: TextTheme.of(context).titleLarge,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          IconButton(
                            icon: const PhosphorIcon(PhosphorIconsLight.copy),
                            tooltip: AppLocalizations.of(context).copy,
                            onPressed: () {
                              Clipboard.setData(ClipboardData(text: message));
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(child: Text(stackTrace.toString())),
                          IconButton(
                            icon: const PhosphorIcon(PhosphorIconsLight.copy),
                            tooltip: AppLocalizations.of(context).copy,
                            onPressed: () {
                              Clipboard.setData(
                                ClipboardData(text: stackTrace.toString()),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OutlinedButton(
                          onPressed: () => launchUrl(
                            Uri.https(
                              'go.linwood.dev',
                              '/butterfly/report',
                            ),
                          ),
                          child: Text(AppLocalizations.of(context).report),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            final router = GoRouter.of(context);
                            if (router.canPop()) {
                              router.pop();
                            } else {
                              router.go('/');
                            }
                          },
                          child: Text(AppLocalizations.of(context).back),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
