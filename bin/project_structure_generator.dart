import 'dart:io';

void main(List<String> arguments) {
  var structure = ["common", "data", "domain", "ui"];

  structure.forEach((element) {
    var file =
        File("${Directory.current.path}/lib/debug/$element/$element.dart");
    file.create(recursive: true);
  });
}
