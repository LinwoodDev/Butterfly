import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CameraDialog extends StatefulWidget {
  const CameraDialog({Key? key}) : super(key: key);

  @override
  _CameraDialogState createState() => _CameraDialogState();
}

class _CameraDialogState extends State<CameraDialog>
    with WidgetsBindingObserver {
  CameraController? _controller;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // App state changed before we got the chance to initialize.
    if (!(_controller?.value.isInitialized ?? false)) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      _controller?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      if (_controller != null) {
        onNewCameraSelected(_controller!.description);
      }
    }
  }

  void onNewCameraSelected(CameraDescription description) {
    _controller?.dispose();
    _controller = CameraController(
      description,
      ResolutionPreset.high,
    );

    // If the controller is updated then update the UI.
    _controller!.addListener(() {
      if (mounted) {
        setState(() {});
      }
      if (_controller!.value.hasError) {
        if (kDebugMode) {
          print('Camera error ${_controller!.value.errorDescription}');
        }
      }
    });

    try {
      _controller!.initialize().then((_) {
        if (mounted) {
          setState(() {});
        }
      });
    } on CameraException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Widget _buildCameraToggles(List<CameraDescription> cameras) =>
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
              cameras.map((camera) => _buildCameraToggle(camera)).toList(),
        ),
      );
  Widget _buildCameraToggle(CameraDescription camera) => IconButton(
        icon: Icon(
          camera.lensDirection == CameraLensDirection.front
              ? PhosphorIcons.userFocusLight
              : PhosphorIcons.imageLight,
          // Test if camera is selected
          color: _controller?.description == camera
              ? Theme.of(context).colorScheme.primary
              : null,
        ),
        tooltip: camera.name,
        onPressed: () async {
          if (_controller != null) {
            await _controller!.dispose();
          }
          _controller?.dispose();
          _controller = CameraController(camera, ResolutionPreset.high);
          await _controller!.initialize();
          if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
            await _controller!.startImageStream((image) {
              setState(() {});
            });
          } else {
            setState(() {});
          }
        },
      );
  Widget _buildCameraPreview() => _controller != null
      ? Builder(builder: (context) {
          return Container(
              child: (!kIsWeb && (Platform.isAndroid || Platform.isIOS))
                  ? AspectRatio(
                      aspectRatio: _controller!.value.aspectRatio,
                      child: CameraPreview(_controller!),
                    )
                  : Align(
                      alignment: Alignment.center,
                      child: Text(_controller!.description.name.toString())));
        })
      : Align(
          alignment: Alignment.center,
          child: Text(AppLocalizations.of(context)!.selectCamera));

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 600, maxWidth: 600),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
              title: Text(AppLocalizations.of(context)!.camera),
              leading: const Icon(PhosphorIcons.cameraLight)),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: FutureBuilder<List<CameraDescription>>(
                future: availableCameras(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Align(
                      alignment: Alignment.center,
                      child: Text(snapshot.error.toString()),
                    );
                  }
                  if (!snapshot.hasData) {
                    return const Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(child: _buildCameraPreview()),
                      const Divider(),
                      _buildCameraToggles(snapshot.data!),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            child: Text(AppLocalizations.of(context)!.cancel),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          TextButton(
                            child: Text(AppLocalizations.of(context)!.ok),
                            // Capture image on button press.
                            onPressed: () async {
                              final imageFile =
                                  await _controller?.takePicture();
                              if (imageFile != null) {
                                var content = await imageFile.readAsBytes();
                                return Navigator.of(context).pop(content);
                              }
                            },
                          ),
                        ],
                      )
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }
}
