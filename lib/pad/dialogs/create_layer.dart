import 'package:butterfly/models/elements/type.dart';
import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateLayerDialog extends StatefulWidget {
  final ElementLayer parent;

  CreateLayerDialog({Key key, this.parent}) : super(key: key);
  @override
  _CreateLayerDialogState createState() => _CreateLayerDialogState();
}

class _CreateLayerDialogState extends State<CreateLayerDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  LayerType _type = LayerType.container;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        scrollable: true,
        actions: [
          FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (widget.parent == null) Navigator.of(context).pop();
              },
              child: Text("CANCEL")),
          FlatButton(
              onPressed: () {
                BlocProvider.of<DocumentBloc>(context).add(LayerCreated(
                    parent: widget.parent,
                    layer: _type.create(_nameController.text, _descriptionController.text)));
                Navigator.of(context).pop();
              },
              child: Text("CREATE"))
        ],
        title: Text("Create layer"),
        content: Container(
            child: Form(
                child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          TextFormField(
              controller: _nameController, decoration: InputDecoration(labelText: "Name")),
          TextFormField(
              controller: _descriptionController,
              maxLines: null,
              minLines: 3,
              decoration: InputDecoration(labelText: "Description")),
          DropdownButtonFormField<LayerType>(
              decoration: InputDecoration(labelText: "Type"),
              value: _type,
              onChanged: (value) => setState(() => _type = value),
              items: LayerType.values
                  .map((e) => DropdownMenuItem<LayerType>(child: Text(e.getName()), value: e))
                  .toList())
        ]))));
  }
}
