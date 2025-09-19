import 'package:desafio_marvel/modules/characters/domain/entities/chacacter_entity.dart';

abstract class CharactersHomeRepository {
  Future<List<CharacterEntity>> getCharacters({
    required int offset,
    required int limit,
  });
}
