import 'dart:io';
import 'dart:convert';

void main(List<String> args) {
  Map<String, dynamic> folderJson =
      directoryToJson(Directory("${Directory.current.path}/ios"));
  String jsonString = json.encode(folderJson);
  print(jsonString);
}

Map<String, dynamic> directoryToJson(Directory directory) {
  List<dynamic> filesJson = [];

  directory.listSync().forEach((FileSystemEntity entity) {
    if (entity is File) {
      filesJson.add({"name": entity.path.split('/').last, "type": "file"});
    } else if (entity is Directory) {
      filesJson.add({
        "name": entity.path.split('/').last,
        "type": "directory",
        "children": directoryToJson(entity)
      });
    }
  });

  return {
    "name": directory.path.split('/').last,
    "type": "directory",
    "children": filesJson
  };
}
