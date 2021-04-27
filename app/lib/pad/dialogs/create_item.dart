import 'package:butterfly/models/project/folder.dart';
import 'package:butterfly/models/project/type.dart';
import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateIteMdiIconsalog extends StatefulWidget {
  final FolderProjectItem? parent;

  CreateIteMdiIconsalog({Key? key, this.parent}) : super(key: key);
  @override
  _CreateIteMdiIconsalogState createState() => _CreateIteMdiIconsalogState();
}

class _CreateIteMdiIconsalogState extends State<CreateIteMdiIconsalog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  ProjectItemType? _type = ProjectItemType.folder;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        scrollable: true,
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (widget.parent == null) Navigator.of(context).pop();
              },
              child: Text("CANCEL")),
          TextButton(
              onPressed: () {
                BlocProvider.of<DocumentBloc>(context).add(ItemCreated(
                    parent: widget.parent,
                    item: _type!.create(_nameController.text, _descriptionController.text)!));
                Navigator.of(context).pop();
              },
              child: Text("CREATE"))
        ],
        title: Text("Create item"),
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
          DropdownButtonFormField<ProjectItemType>(
              decoration: InputDecoration(labelText: "Type"),
              value: _type,
              onChanged: (value) => setState(() => _type = value),
              items: ProjectItemType.values
                  .map((e) => DropdownMenuItem<ProjectItemType>(child: Text(e.name!), value: e))
                  .toList())
        ]))));
  }
}
