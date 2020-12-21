import 'item.dart';

class FolderProjectItem extends ProjectItem {
  List<ProjectItem> _files = [];
  List<ProjectItem> get files => List.unmodifiable(_files);

  bool addFile(ProjectItem item) {
    if (!hasFile(item.name) && item.name != null)
      _files.add(item);
    else
      return false;
    return true;
  }

  bool deleteFile(String path) {
    List<String> directories = path.split('/');
    List<String> parentPath = directories.sublist(0, directories.length - 1);
    var parent = getFile(parentPath.join('/'));
    if (parent == null || !(parent is FolderProjectItem)) return false;
    (getFile(path) as FolderProjectItem)._files.remove(directories[directories.length - 1]);
    return true;
  }

  bool hasFile(String path) => getFile(path) != null;

  ProjectItem getFile(String path) {
    List<String> directories = path.split('/');
    if (directories.isEmpty) return this;
    ProjectItem current = _files.where((element) => element.name == directories[0]).first;
    if (current == null) return null;
    var next = directories.sublist(0, directories.length - 1);
    if (current is FolderProjectItem)
      return current.getFile(next.join('/'));
    else if (next.isEmpty)
      return current;
    else
      return this;
  }
}
