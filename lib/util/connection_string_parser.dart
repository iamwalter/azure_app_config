/// Parses a [connectionString] to a Map.
///
/// Throws an [FormatException] if the [connectionString] is malformed.
///
/// ```dart
/// final map = parseConnectionString('id=14;pass=secret;server=production');
/// print(map); // { "id": "14", "pass": "secret", "server": "production"}
/// ```
Map<String, String> parseConnectionString(String connectionString) {
  final pieces = connectionString._controlledSplit(";")
    ..removeWhere((element) => element == '');

  final map = <String, String>{};

  for (final piece in pieces) {
    final nameAndValue = piece._controlledSplit("=", max: 1);

    if (nameAndValue.length != 2) {
      throw FormatException("Malformed connection string");
    }

    final name = nameAndValue[0];
    final value = nameAndValue[1];

    map[name] = value;
  }

  return map;
}

extension on String {
  List<String> _controlledSplit(String separator, {int max = 0}) {
    var result = <String>[];
    var string = this;

    if (separator.isEmpty) {
      result.add(string);
      return result;
    }

    while (true) {
      var index = string.indexOf(separator, 0);
      if (index == -1 || (max > 0 && result.length >= max)) {
        result.add(string);
        break;
      }

      result.add(string.substring(0, index));
      string = string.substring(index + separator.length);
    }

    return result;
  }
}
