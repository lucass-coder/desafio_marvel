import 'package:desafio_marvel/modules/characters/domain/entities/chacacter_entity.dart';
import 'package:desafio_marvel/modules/characters/domain/repositories/characters_home_repository.dart';

class GetCharactersUseCase {
  final CharactersHomeRepository repository;

  GetCharactersUseCase(this.repository);

  Future<List<CharacterEntity>> call({int offset = 0, int limit = 10}) {
    return repository.getCharacters(offset: offset, limit: limit);
  }
}
