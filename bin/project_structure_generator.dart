import 'dart:io';

import 'package:project_structure_generator/args_parser.dart';

void main(List<String> arguments) {
  var args = ArgsParser().parse(arguments);
  final dirs = args['dirs'].toString().split(",");
  final features = args['features'].toString().split(",");
  final path = args['path'].toString().replaceAll("/", _separator);
  final force = args.containsKey('f');

  ///
  genDirs(dirs, path, force);
  genFeatures(features, dirs, path);
}

final _separator = Platform.pathSeparator;

genDirs(List<String> dirs, String path, bool force) {
  for (var element in dirs) {
    final basePath = "${Directory.current.path}$_separator$path";
    final f = Directory("$basePath$_separator$element$_separator");

    if (f.existsSync() && !force) {
      throw Exception("Dir named $element already exist");
    }

    var file = File("$basePath$_separator$element$_separator$element.dart");
    file.createSync(recursive: true);
  }
}

genFeatures(List<String> features, List<String> dirs, String path) {
  for (var element in dirs) {
    for (var feature in features) {
      final featureObject = extractFeatureFileNames(feature);
      for (var featureFile in featureObject?.files ?? []) {
        var file = File(
            "${Directory.current.path}$_separator$path$_separator$element$_separator${featureObject?.name}$_separator$featureFile$_separator$element.dart");
        file.createSync(recursive: true);
      }
    }
  }
}

Feature? extractFeatureFileNames(String featureName) {
  RegExp regExp = RegExp(r'\[([^\]]+)\]');
  Iterable<Match> matches = regExp.allMatches(featureName);
  final files =
      matches.toList()[0].group(0)?.replaceAll("[", "").replaceAll("]", "");

  final name = featureName.substring(0, featureName.indexOf("["));

  return Feature(name: name, files: (files ?? "").split("."));
}

class Feature {
  final String name;
  final List<String> files;

  const Feature({
    required this.name,
    required this.files,
  });

  @override
  String toString() {
    return 'Feature{name: $name, files: $files}';
  }
}
