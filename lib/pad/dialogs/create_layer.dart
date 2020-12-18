import 'package:butterfly/models/elements/type.dart';
import 'package:flutter/material.dart';

class CreateLayerDialog extends StatefulWidget {
  final int layerIndex;
  CreateLayerDialog({Key key, this.layerIndex = 0}) : super(key: key);
  @override
  _CreateLayerDialogState createState() => _CreateLayerDialogState();
}

class _CreateLayerDialogState extends State<CreateLayerDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final LayerType _type = LayerType.container;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        scrollable: true,
        actions: [
          FlatButton(onPressed: () => Navigator.of(context).pop(), child: Text("CANCEL")),
          FlatButton(onPressed: () {}, child: Text("CREATE"))
        ],
        title: Text("Create layer"),
        content: Container(
            child: Form(
                child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          TextFormField(
              controller: _nameController,
              decoration:
                  InputDecoration(labelText: "Name", hintText: "Layer #${widget.layerIndex}")),
          TextFormField(
              controller: _descriptionController,
              maxLines: null,
              minLines: 3,
              decoration: InputDecoration(labelText: "Description")),
          DropdownButtonFormField<LayerType>(
              decoration: InputDecoration(labelText: "Type"),
              value: _type,
              onChanged: (value) => setState,
              items: LayerType.values
                  .map((e) => DropdownMenuItem<LayerType>(child: Text(e.getName()), value: e))
                  .toList())
        ]))));
  }
}
