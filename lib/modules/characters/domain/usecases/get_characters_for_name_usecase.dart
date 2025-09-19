import 'package:desafio_marvel/modules/characters/domain/entities/chacacter_entity.dart';
import 'package:desafio_marvel/modules/characters/domain/repositories/characters_home_repository.dart';

class GetCharactersForNameUseCase {
  final CharactersHomeRepository repository;

  GetCharactersForNameUseCase(this.repository);

  Future<List<CharacterEntity>> call({
    int offset = 0,
    int limit = 10,
    required String name,
  }) {
    return repository.getCharactersFromName(
      offset: offset,
      limit: limit,
      name: name,
    );
  }
}
