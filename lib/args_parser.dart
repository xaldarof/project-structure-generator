class ArgsParser {
  Map parse(List<String> args) {
    var argsMap = {};
    args.asMap().forEach((key, value) {
      if (value.startsWith("-")) {
        if (args.length < key + 2) {
          argsMap[value.replaceFirst("-", "")] = "";
        } else {
          argsMap[value.replaceFirst("-", "")] = args[key + 1];
        }
      }
    });
    return argsMap;
  }
}
