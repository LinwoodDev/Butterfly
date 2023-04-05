import 'package:butterfly/visualizer/element.dart';
import 'package:butterfly/widgets/exact_slider.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ConstraintsView extends StatefulWidget {
  final ElementConstraints? initialConstraints;
  final bool enableScaled;
  final ValueChanged<ElementConstraints?> onChanged;
  const ConstraintsView({
    super.key,
    this.enableScaled = true,
    this.initialConstraints,
    required this.onChanged,
  });

  @override
  State<ConstraintsView> createState() => _ConstraintsViewState();
}

class _ConstraintsViewState extends State<ConstraintsView> {
  late ElementConstraints? constraints;
  bool opened = false;

  @override
  void initState() {
    super.initState();
    constraints = widget.initialConstraints;
  }

  void _onChanged(ElementConstraints? constraints) {
    setState(() {
      this.constraints = constraints;
    });
    widget.onChanged(constraints);
  }

  @override
  Widget build(BuildContext context) {
    Widget? content = constraints?.map(
      scaled: (value) => _ScaledConstraintsContent(
        constraints: value,
        onChanged: _onChanged,
      ),
      fixed: (value) => _FixedConstraintsContent(
        constraints: value,
        onChanged: _onChanged,
      ),
      dynamic: (value) => _DynamicConstraintsContent(
        constraints: value,
        onChanged: _onChanged,
      ),
    );
    return ExpansionPanelList(
      expansionCallback: (panelIndex, isExpanded) => setState(() {
        opened = !isExpanded;
      }),
      children: [
        ExpansionPanel(
          isExpanded: opened,
          headerBuilder: (context, isExpanded) => Wrap(
            children: [
              ListTile(
                title: Text(AppLocalizations.of(context).constraints),
                leading: PhosphorIcon(PhosphorIcons.light.selection),
                onTap: () => setState(() {
                  opened = !isExpanded;
                }),
                trailing: DropdownButton<String>(
                  items: [
                    ...[
                      const FixedElementConstraints(0, 0),
                      const ScaledElementConstraints(scaleX: 1, scaleY: 1),
                      const DynamicElementConstraints()
                    ].map((e) => DropdownMenuItem(
                          value: e.runtimeType.toString(),
                          child: Text(
                            e.getLocalizedName(context),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          onTap: () {
                            setState(() {
                              constraints = e;
                              opened = false;
                            });
                            _onChanged(e);
                          },
                        ))
                  ],
                  value: constraints?.runtimeType.toString(),
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
          body: content ?? Container(),
        ),
      ],
    );
  }
}

class _FixedConstraintsContent extends StatelessWidget {
  final FixedElementConstraints constraints;
  final ValueChanged<ElementConstraints?> onChanged;
  const _FixedConstraintsContent(
      {required this.constraints, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return ListView(shrinkWrap: true, children: [
      TextFormField(
          decoration: InputDecoration(
              filled: true, labelText: AppLocalizations.of(context).width),
          keyboardType: TextInputType.number,
          onFieldSubmitted: (value) {
            onChanged(constraints.copyWith(width: double.parse(value)));
          },
          initialValue: constraints.width.toStringAsFixed(2)),
      const SizedBox(height: 8),
      TextFormField(
          decoration: InputDecoration(
              filled: true, labelText: AppLocalizations.of(context).height),
          keyboardType: TextInputType.number,
          onFieldSubmitted: (value) {
            onChanged(constraints.copyWith(height: double.parse(value)));
          },
          initialValue: constraints.height.toStringAsFixed(2)),
    ]);
  }
}

class _ScaledConstraintsContent extends StatelessWidget {
  final ScaledElementConstraints constraints;
  final ValueChanged<ElementConstraints?> onChanged;
  const _ScaledConstraintsContent(
      {required this.constraints, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return ListView(shrinkWrap: true, children: [
      ExactSlider(
        header: const Text('X'),
        min: 0,
        max: 10,
        defaultValue: 1,
        value: constraints.scaleX,
        onChangeEnd: (value) => onChanged(constraints.copyWith(scaleX: value)),
      ),
      ExactSlider(
        header: const Text('Y'),
        min: 0,
        max: 10,
        defaultValue: 1,
        value: constraints.scaleY,
        onChangeEnd: (value) => onChanged(constraints.copyWith(scaleY: value)),
      ),
    ]);
  }
}

class _DynamicConstraintsContent extends StatelessWidget {
  final DynamicElementConstraints constraints;
  final ValueChanged<ElementConstraints?> onChanged;
  const _DynamicConstraintsContent(
      {required this.constraints, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return ListView(shrinkWrap: true, children: [
      TextFormField(
          decoration: InputDecoration(
              filled: true, labelText: AppLocalizations.of(context).width),
          keyboardType: TextInputType.number,
          onFieldSubmitted: (value) {
            onChanged(constraints.copyWith(width: double.parse(value)));
          },
          initialValue: constraints.width.toStringAsFixed(2)),
      const SizedBox(height: 8),
      TextFormField(
          decoration: InputDecoration(
              filled: true, labelText: AppLocalizations.of(context).height),
          keyboardType: TextInputType.number,
          onFieldSubmitted: (value) {
            onChanged(constraints.copyWith(height: double.parse(value)));
          },
          initialValue: constraints.height.toStringAsFixed(2)),
      const SizedBox(height: 8),
      TextFormField(
        decoration: InputDecoration(
            filled: true, labelText: AppLocalizations.of(context).aspectRatio),
        keyboardType: TextInputType.number,
        onFieldSubmitted: (value) {
          onChanged(constraints.copyWith(aspectRatio: double.parse(value)));
        },
        initialValue: constraints.aspectRatio.toStringAsFixed(2),
      ),
      const SizedBox(height: 8),
      CheckboxListTile(
          value: constraints.includeArea,
          onChanged: (value) {
            onChanged(constraints.copyWith(
                includeArea: value ?? constraints.includeArea));
          },
          title: Text(AppLocalizations.of(context).includeArea)),
    ]);
  }
}

class ConstraintView extends StatefulWidget {
  final ElementConstraint initialConstraint;
  final ValueChanged<ElementConstraint> onChanged;
  const ConstraintView({
    super.key,
    required this.initialConstraint,
    required this.onChanged,
  });

  @override
  State<ConstraintView> createState() => _ConstraintViewState();
}

class _ConstraintViewState extends State<ConstraintView> {
  late ElementConstraint constraint;

  @override
  void initState() {
    super.initState();
    constraint = widget.initialConstraint;
  }

  void _onChanged(ElementConstraint constraint) {
    setState(() {
      this.constraint = constraint;
    });
    widget.onChanged(constraint);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text(
          AppLocalizations.of(context).constraint,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const Divider(),
        ListView(
          shrinkWrap: true,
          children: [
            TextFormField(
              decoration: InputDecoration(
                  filled: true, labelText: AppLocalizations.of(context).size),
              keyboardType: TextInputType.number,
              onFieldSubmitted: (value) {
                _onChanged(constraint.copyWith(size: double.parse(value)));
              },
              initialValue: constraint.size.toStringAsFixed(2),
            ),
            const SizedBox(height: 8),
            TextFormField(
              decoration: InputDecoration(
                  filled: true, labelText: AppLocalizations.of(context).length),
              keyboardType: TextInputType.number,
              onFieldSubmitted: (value) {
                _onChanged(constraint.copyWith(length: double.parse(value)));
              },
              initialValue: constraint.length.toStringAsFixed(2),
            ),
            const SizedBox(height: 8),
            CheckboxListTile(
              value: constraint.includeArea,
              onChanged: (value) {
                _onChanged(constraint.copyWith(
                    includeArea: value ?? constraint.includeArea));
              },
              title: Text(AppLocalizations.of(context).includeArea),
            ),
          ],
        ),
      ]),
    );
  }
}
