import 'package:butterfly/cubits/selection.dart';
import 'package:butterfly/models/elements/element.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SelectElementDialog extends StatelessWidget {
  final List<PadElement> elements;
  final SelectionCubit cubit;

  const SelectElementDialog(
      {Key? key, this.elements = const [], required this.cubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: AlertDialog(
        title: Text(AppLocalizations.of(context)!.selectElement),
        actions: [
          TextButton(
            child: Text(AppLocalizations.of(context)!.cancel),
            onPressed: () {
              cubit.reset();
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text(AppLocalizations.of(context)!.ok),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
        content: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 100),
          child:
              BlocBuilder<SelectionCubit, dynamic>(builder: (context, state) {
            return SizedBox(
                width: double.maxFinite,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: elements.length,
                  itemBuilder: (context, index) {
                    final element = elements[index];
                    final elementType = element.toJson()['type'];
                    IconData icon;
                    switch (elementType) {
                      case 'image':
                        icon = PhosphorIcons.imageLight;
                        break;
                      case 'label':
                        icon = PhosphorIcons.textTLight;
                        break;
                      case 'eraser':
                        icon = PhosphorIcons.eraserLight;
                        break;
                      default:
                        icon = PhosphorIcons.penLight;
                        break;
                    }
                    return IconButton(
                      icon: Icon(icon),
                      color: state == element
                          ? Theme.of(context).colorScheme.primary
                          : null,
                      onPressed: () {
                        cubit.change(element);
                      },
                    );
                  },
                ));
          }),
        ),
      ),
    );
  }
}
