import 'package:desafio_marvel/core/client/exceptions/api_exceptions.dart';
import 'package:desafio_marvel/modules/characters/domain/entities/chacacter_entity.dart';
import 'package:desafio_marvel/modules/characters/domain/repositories/characters_home_repository.dart';
import 'package:desafio_marvel/modules/characters/domain/usecases/get_characters_for_name_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// 1. Crie um Mock para a dependência do UseCase (o Repository)
class MockCharactersHomeRepository extends Mock
    implements CharactersHomeRepository {}

void main() {
  late GetCharactersForNameUseCase usecase;
  late MockCharactersHomeRepository mockRepository;

  setUp(() {
    mockRepository = MockCharactersHomeRepository();
    usecase = GetCharactersForNameUseCase(mockRepository);
  });

  // Lista de personagens de teste
  const tCharacterList = [
    CharacterEntity(
      id: 1,
      name: 'Spider-Man',
      thumbnailUrl: 'url1',
      description: 'A hero with spider-like abilities.',
    ),
    CharacterEntity(
      id: 2,
      name: 'Iron Man',
      thumbnailUrl: 'url2',
      description: 'A genius billionaire in a high-tech suit.',
    ),
  ];
  const tOffset = 0;
  const tLimit = 20;

  test('deve retornar uma lista de personagens do repositório', () async {
    when(
      () => mockRepository.getCharacters(
        offset: any(named: 'offset'),
        limit: any(named: 'limit'),
      ),
    ).thenAnswer((_) async => tCharacterList);

    final result = await usecase.call(
      offset: tOffset,
      limit: tLimit,
      name: 'Spi',
    );

    expect(result, tCharacterList);
    verify(() => mockRepository.getCharacters(offset: tOffset, limit: tLimit));
    verifyNoMoreInteractions(mockRepository);
  });

  test('deve propagar a exceção do repositório', () async {
    final tException = ServerException('Erro no servidor');
    when(
      () => mockRepository.getCharacters(
        offset: any(named: 'offset'),
        limit: any(named: 'limit'),
      ),
    ).thenThrow(tException);

    final call = usecase.call;

    expect(
      () => call(offset: tOffset, limit: tLimit, name: 'Spi'),
      throwsA(isA<ServerException>()),
    );
    verify(() => mockRepository.getCharacters(offset: tOffset, limit: tLimit));
    verifyNoMoreInteractions(mockRepository);
  });
}
