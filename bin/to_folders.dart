import 'dart:io';
import 'dart:convert';

import 'package:project_structure_generator/args_parser.dart';

void main(List<String> args) {
  ToFolders().handle(args);
}

class ToFolders {
  void handle(List<String> args) {
    final input = ArgsParser().parse(args);
    final output = input['output'];
    final inputJson = input['json'];
    print("json path : $inputJson");
    String jsonString =
        File("${Directory.current.path}/$inputJson").readAsStringSync();
    Map<String, dynamic> folderJson = json.decode(jsonString);

    createFolderStructure(
        folderJson, Directory("${Directory.current.path}/$output"));
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
}
