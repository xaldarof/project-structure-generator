import 'dart:io';

import 'package:test/test.dart';

import '../bin/from_folders.dart';

void main() {
  test('description', () {
    final fromFolders = FromFolders();
    fromFolders.handle([
      "-root",
      "/test/fake_json/",
      "-output",
      "test/structure.json",
    ]);
    final result =
        """{"name":"","type":"directory","children":[{"name":"from_folders.json","type":"file"},{"name":"to_folders.json","type":"file"}]}""";
    final file = File("${Directory.current.path}/test/structure.json");
    expect(file.existsSync(), true);
    expect(file.readAsStringSync(), result);
  });
}
