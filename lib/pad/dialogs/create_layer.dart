import 'package:butterfly/models/elements/type.dart';
import 'package:flutter/material.dart';

class CreateLayerDialog extends StatelessWidget {
  final int layerIndex;
  final TextEditingController _nameController = TextEditingController();

  CreateLayerDialog({Key key, this.layerIndex = 0}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        actions: [
          FlatButton(onPressed: () => Navigator.of(context).pop(), child: Text("CANCEL")),
          FlatButton(onPressed: () {}, child: Text("CREATE"))
        ],
        content: Container(
            child: SingleChildScrollView(
                child: Form(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Name", hintText: "Layer #$layerIndex")),
          DropdownButtonFormField<LayerType>(
              onChanged: (value) => print(value),
              items: LayerType.values
                  .map((e) => DropdownMenuItem<LayerType>(child: Text(e.getName()), value: e))
                  .toList())
        ])))));
  }
}
