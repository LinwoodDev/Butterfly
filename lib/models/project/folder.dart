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

  bool deleteFile(String file) {
    if (!hasFile(file)) return false;
    _files.remove(getFile(file));
    return true;
  }

  bool hasFile(String file) => _files.any((element) => element.name == file);
  ProjectItem getFile(String file) => _files.where((element) => element.name == file).first;
}
