import 'package:flutter/material.dart';

class BoxTile extends StatelessWidget {
  final Widget title, icon;
  final double size;
  final GestureTapCallback? onTap;

  const BoxTile({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
    this.size = 100,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: InkWell(
          onTap: onTap,
          child: SizedBox.square(
            dimension: size,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconTheme(
                  data: Theme.of(context).iconTheme.copyWith(size: 32),
                  child: icon,
                ),
                const SizedBox(height: 16),
                title,
              ],
            ),
          ),
        ));
  }
}
