import 'dart:io';
import 'dart:convert';

void main(List<String> args) {
  String jsonString = File("${Directory.current.path}/folder_structure.json")
      .readAsStringSync();
  Map<String, dynamic> folderJson = json.decode(jsonString);

  Directory rootDirectory = Directory(folderJson['name']);
  rootDirectory.createSync();

  createFolderStructure(folderJson, rootDirectory);
}

void createFolderStructure(
    Map<String, dynamic> folderJson, Directory parentDirectory) {
  Directory directory =
      Directory('${parentDirectory.path}/${folderJson['name']}');
  directory.createSync();

  for (var child in folderJson['children']) {
    if (child['type'] == 'file') {
      File file = File('${directory.path}/${child['name']}');
      file.createSync();
    } else if (child['type'] == 'directory') {
      createFolderStructure(child, directory);
    }
  }
}
