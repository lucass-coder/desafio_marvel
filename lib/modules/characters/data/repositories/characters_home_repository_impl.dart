import 'package:desafio_marvel/modules/characters/data/datasources/characters_home_datasource.dart';
import 'package:desafio_marvel/modules/characters/domain/entities/chacacter_entity.dart';
import 'package:desafio_marvel/modules/characters/domain/repositories/characters_home_repository.dart';

class CharactersHomeRepositoryImpl extends CharactersHomeRepository {
  final CharactersHomeDatasource datasource;
  CharactersHomeRepositoryImpl({required this.datasource});

  @override
  Future<List<CharacterEntity>> getCharacters({
    required int offset,
    required int limit,
  }) {
    return datasource.getCharactersForPagination(offset: offset, limit: limit);
  }
}
