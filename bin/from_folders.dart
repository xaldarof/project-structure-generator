import 'dart:io';
import 'dart:convert';

import 'package:project_structure_generator/args_parser.dart';

void main(List<String> args) {
  FromFolders().handle(args);
}

class FromFolders {
  void handle(List<String> args) {
    final input = ArgsParser().parse(args);
    final output = input['output'];
    final root = input['root'];

    Map<String, dynamic> folderJson =
        directoryToJson(Directory("${Directory.current.path}/$root"));
    String jsonString = json.encode(folderJson);
    final file = File("${Directory.current.path}/$output");
    file.createSync();
    file.writeAsStringSync(jsonString);
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
}
