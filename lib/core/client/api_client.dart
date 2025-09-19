import 'dart:convert';
import 'dart:nativewrappers/_internal/vm/lib/developer.dart';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HomeApiClient extends DioForNative {
  HomeApiClient() {
    final publicKey = dotenv.env['MARVEL_PUBLIC_KEY'] ?? '';
    final privateKey = dotenv.env['MARVEL_PRIVATE_KEY'] ?? '';

    if (publicKey.isEmpty || privateKey.isEmpty) {
      throw Exception('Chaves da Marvel não encontradas no arquivo .env');
    }

    options = BaseOptions(
      baseUrl: 'https://gateway.marvel.com/v1/public',
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    );

    interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final ts = DateTime.now().millisecondsSinceEpoch.toString();
          final hash = _generateMarvelHash(
            ts: ts,
            privateKey: privateKey,
            publicKey: publicKey,
          );

          options.queryParameters.addAll({
            'apikey': publicKey,
            'ts': ts,
            'hash': hash,
          });
          return handler.next(options);
        },
      ),
    );

    interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        error: true,
        logPrint: (object) {
          log(object.toString());
        },
      ),
    );
  }

  String _generateMarvelHash({
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
