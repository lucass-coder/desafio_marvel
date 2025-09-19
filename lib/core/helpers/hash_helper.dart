import 'dart:convert';

import 'package:crypto/crypto.dart';

class HashHelper {
  static String generateMarvelHash({
    required String ts,
    required String privateKey,
    required String publicKey,
  }) {
    final input = ts + privateKey + publicKey;
    final bytes = utf8.encode(input);
    final digest = md5.convert(bytes);
    return digest.toString();
  }
}
