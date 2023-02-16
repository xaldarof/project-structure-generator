class ArgsParser {
  Map parse(List<String> args) {
    var argsMap = {};
    args.asMap().forEach((key, value) {
      if(value.startsWith("-")) {
        argsMap[value.replaceFirst("-", "")] = args[key + 1];
      }
    });
    return argsMap;
  }
}