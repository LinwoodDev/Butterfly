import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

MenuAnchorChildBuilder defaultMenuButton(
        [PhosphorIconData icon = PhosphorIconsLight.dotsThreeVertical]) =>
    (context, controller, child) => IconButton(
          icon: Icon(icon),
          onPressed: () =>
              controller.isOpen ? controller.close() : controller.open(),
        );
