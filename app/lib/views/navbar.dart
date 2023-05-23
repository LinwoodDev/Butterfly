import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/views/files.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DocumentNavbar extends StatefulWidget {
  const DocumentNavbar({super.key});

  @override
  State<DocumentNavbar> createState() => _DocumentNavbarState();
}

class _DocumentNavbarState extends State<DocumentNavbar> {
  RemoteStorage? _remote;
  @override
  void initState() {
    super.initState();
    _remote = context.read<SettingsCubit>().getRemote();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: ListView(
        children: [
          BlocBuilder<DocumentBloc, DocumentState>(
              buildWhen: (previous, current) =>
                  previous is! DocumentLoaded ||
                  current is! DocumentLoaded ||
                  current.location != previous.location,
              builder: (context, state) {
                AssetLocation? location;
                if (state is DocumentLoaded) {
                  location = state.location;
                }
                return FilesView(
                  remote: _remote,
                  selectedAsset: location,
                  collapsed: true,
                );
              }),
        ],
      ),
    );
  }
}
