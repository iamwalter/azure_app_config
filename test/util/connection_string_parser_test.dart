import 'package:azure_app_config/src/util/connection_string_parser.dart';
import 'package:test/test.dart';

void main() {
  test('should parse the connection string into Endpoint, Id & Secret',
      () async {
    final connectionString =
        'Endpoint=https://test-url.website.io;Id=7Qsdz_g3-:241FblablaGbk9vUzBN;Secret=7a6zzKlDJKSdhs_--sd++g6YM0dad2SGLr68tbfUs=';

    final map = parseConnectionString(connectionString);

    final expected = <String, String>{
      "Endpoint": "https://test-url.website.io",
      "Id": "7Qsdz_g3-:241FblablaGbk9vUzBN",
      "Secret": "7a6zzKlDJKSdhs_--sd++g6YM0dad2SGLr68tbfUs=",
    };

    expect(map, expected);
  });

  test('should parse correctly on empty values', () async {
    final connectionString = 'Endpoint=test;Id=test2;Secret=';

    final expected = <String, String>{
      "Endpoint": "test",
      "Id": "test2",
      "Secret": "",
    };

    expect(parseConnectionString(connectionString), expected);
  });

  test('should parse correctly', () async {
    final connectionString =
        "Persist Security Info=False;Integrated Security=true;Initial Catalog=Northwind;server=(local);";

    final expected = <String, String>{
      "Persist Security Info": "False",
      "Integrated Security": "true",
      "Initial Catalog": "Northwind",
      "server": "(local)",
    };

    expect(parseConnectionString(connectionString), expected);
  });

  test('parse connection string into a representative map ', () async {
    final connectionString =
        "Provider=sqloledb;Data Source=myServerAddress;Initial Catalog=myDataBase;User ID=myUsername;Password=myPassword;OLE DB Services=-2;";

    final expected = <String, String>{
      "Provider": "sqloledb",
      "Data Source": "myServerAddress",
      "Initial Catalog": "myDataBase",
      "User ID": "myUsername",
      "Password": "myPassword",
      "OLE DB Services": "-2",
    };

    expect(parseConnectionString(connectionString), expected);
  });

  test('should throw formatException when malformed endpoint', () async {
    var connectionString = 'Endpoint=test;Id=test2;Secret';
    expect(() => parseConnectionString(connectionString),
        throwsA(isA<FormatException>()));

    connectionString = 'Endpoint=testId=t;est2;Secret=fasf';
    expect(() => parseConnectionString(connectionString),
        throwsA(isA<FormatException>()));
  });
}
