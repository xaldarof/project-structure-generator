import 'dart:io';

import 'package:test/test.dart';

import '../bin/to_folders.dart';

void main() {
  test('description', () {
    final toFolders = ToFolders();
    toFolders.handle([
      "-json",
      "/test/fake_json/to_folders.json",
      "-output",
      "test/fake_json/",
    ]);
    final file = File(
        "${Directory.current.path}/test/fake_json/project_lib/core/file.txt");
    expect(file.existsSync(), true);
  });
}
