part of 'handler.dart';

class CollectionHandler extends Handler<CollectionTool> {
  CollectionHandler(super.data);

  @override
  SelectState onSelected(BuildContext context, [bool wasAdded = true]) {
    final bloc = context.read<DocumentBloc>();
    showDialog(
      context: context,
      builder: (context) =>
          BlocProvider.value(value: bloc, child: const CollectionsDialog()),
    );
    return SelectState.normal;
  }
}
