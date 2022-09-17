import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';

void main() {
  var body = '';

  var contentHash = base64.encode(sha256.convert(utf8.encode(body)).bytes);

  print(body.codeUnits);
  // 47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=
  print(contentHash);
}
