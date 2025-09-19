import 'package:desafio_marvel/core/client/exceptions/api_exceptions.dart';
import 'package:desafio_marvel/modules/characters/domain/entities/chacacter_entity.dart';
import 'package:desafio_marvel/modules/characters/domain/repositories/characters_home_repository.dart';
import 'package:desafio_marvel/modules/characters/domain/usecases/get_characters_for_name_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCharactersHomeRepository extends Mock
    implements CharactersHomeRepository {}

void main() {
  late GetCharactersForNameUseCase usecase;
  late MockCharactersHomeRepository mockRepository;

  setUp(() {
    mockRepository = MockCharactersHomeRepository();
    usecase = GetCharactersForNameUseCase(mockRepository);
  });

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
  const tName = 'Spi';

  test(
    'deve retornar uma lista de personagens do repositório ao buscar por nome',
    () async {
      when(
        () => mockRepository.getCharactersFromName(
          offset: any(named: 'offset'),
          limit: any(named: 'limit'),
          name: any(named: 'name'),
        ),
      ).thenAnswer((_) async => tCharacterList);

      final result = await usecase.call(
        offset: tOffset,
        limit: tLimit,
        name: tName,
      );

      expect(result, tCharacterList);
      verify(
        () => mockRepository.getCharactersFromName(
          offset: tOffset,
          limit: tLimit,
          name: tName,
        ),
      );
      verifyNoMoreInteractions(mockRepository);
    },
  );

  test('deve propagar a exceção do repositório ao buscar por nome', () async {
    final tException = ServerException('Erro no servidor');
    when(
      () => mockRepository.getCharactersFromName(
        offset: any(named: 'offset'),
        limit: any(named: 'limit'),
        name: any(named: 'name'),
      ),
    ).thenThrow(tException);

    final call = usecase.call;

    expect(
      () => call(offset: tOffset, limit: tLimit, name: tName),
      throwsA(isA<ServerException>()),
    );
    verify(
      () => mockRepository.getCharactersFromName(
        offset: tOffset,
        limit: tLimit,
        name: tName,
      ),
    );
    verifyNoMoreInteractions(mockRepository);
  });
}
