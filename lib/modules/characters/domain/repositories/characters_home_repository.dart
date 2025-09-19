import 'package:desafio_marvel/modules/characters/domain/entities/chacacter_entity.dart';

abstract class CharactersHomeRepository {
  Future<List<CharacterEntity>> getCharacters({
    required int offset,
    required int limit,
  });
  Future<List<CharacterEntity>> getCharactersFromName({
    required int offset,
    required int limit,
    required String name,
  });
}
