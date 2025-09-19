import 'package:desafio_marvel/core/client/api_client.dart';
import 'package:desafio_marvel/core/client/exceptions/api_exceptions.dart';
import 'package:desafio_marvel/modules/characters/data/models/character_model.dart';
import 'package:desafio_marvel/modules/characters/domain/entities/chacacter_entity.dart';
import 'package:dio/dio.dart';

class CharactersHomeDatasource {
  final ApiClient dio;
  CharactersHomeDatasource({required this.dio});

  Future<List<CharacterEntity>> getCharactersForPagination({
    required int offset,
    required int limit,
  }) async {
    try {
      final response = await dio.get(
        '/characters',
        queryParameters: {'offset': offset, 'limit': limit, 'orderBy': 'name'},
      );
      return CharacterModel.fromList(response.data['data']['results']);
    } on DioException catch (e) {
      _handleDioException(e);
    }
  }

  Never _handleDioException(DioException e) {
    if (e.response != null) {
      final statusCode = e.response!.statusCode;
      switch (statusCode) {
        case 409:
          throw AuthorizationException(
            'Erro de autorização. Verifique sua chave de API, hash ou timestamp.',
          );
        case 401:
        case 403:
          throw AuthenticationException(
            'Erro de autenticação. Hash, referer inválido ou acesso proibido.',
          );
        case 405:
          throw ServerException('Método de requisição não permitido.');
        default:
          throw ServerException('Erro no servidor: $statusCode.');
      }
    } else if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      throw ServerException(
        'Tempo de conexão esgotado. Verifique sua internet.',
      );
    } else {
      throw ServerException('Erro de conexão. Verifique sua internet.');
    }
  }
}
