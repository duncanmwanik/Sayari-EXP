//
// file item
//
class FileItem {
  FileItem({required this.id, required this.name});
  String id;
  String name;

  bool isValid() => id.isNotEmpty && name.isNotEmpty;
}

//
// file stach to hold picked files
//
class FileStash {
  FileStash();

  Map<String, FileItem> files = {};

  void addFile(String fileId, FileItem file) => files[fileId] = file;
  void clear() => files.clear();
  bool isValid() => files.isNotEmpty;
  FileItem first() => files.values.first;
}
