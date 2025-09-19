import 'package:desafio_marvel/core/client/exceptions/api_exceptions.dart';
import 'package:desafio_marvel/modules/characters/data/datasources/characters_home_datasource.dart';
import 'package:desafio_marvel/modules/characters/data/repositories/characters_home_repository_impl.dart';
import 'package:desafio_marvel/modules/characters/domain/entities/chacacter_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCharactersHomeDatasource extends Mock
    implements CharactersHomeDatasource {}

void main() {
  late CharactersHomeRepositoryImpl repository;
  late MockCharactersHomeDatasource mockDatasource;

  setUp(() {
    mockDatasource = MockCharactersHomeDatasource();
    repository = CharactersHomeRepositoryImpl(datasource: mockDatasource);
  });

  const tCharacterList = [
    CharacterEntity(id: 1, name: 'Hulk', thumbnailUrl: 'url1', description: ''),
  ];
  const tOffset = 0;
  const tLimit = 20;
  const tName = 'Hulk';
  final tException = ServerException('Erro no servidor');

  group('getCharacters', () {
    test(
      'deve retornar uma lista de personagens quando o datasource for bem sucedido',
      () async {
        when(
          () => mockDatasource.getCharactersForPagination(
            offset: any(named: 'offset'),
            limit: any(named: 'limit'),
          ),
        ).thenAnswer((_) async => tCharacterList);

        final result = await repository.getCharacters(
          offset: tOffset,
          limit: tLimit,
        );

        expect(result, tCharacterList);
        verify(
          () => mockDatasource.getCharactersForPagination(
            offset: tOffset,
            limit: tLimit,
          ),
        );
        verifyNoMoreInteractions(mockDatasource);
      },
    );

    test(
      'deve propagar a exceção quando a chamada ao datasource falhar',
      () async {
        when(
          () => mockDatasource.getCharactersForPagination(
            offset: any(named: 'offset'),
            limit: any(named: 'limit'),
          ),
        ).thenThrow(tException);

        final call = repository.getCharacters;

        expect(
          () => call(offset: tOffset, limit: tLimit),
          throwsA(isA<ServerException>()),
        );
        verify(
          () => mockDatasource.getCharactersForPagination(
            offset: tOffset,
            limit: tLimit,
          ),
        );
        verifyNoMoreInteractions(mockDatasource);
      },
    );
  });

  group('getCharactersFromName', () {
    test(
      'deve retornar uma lista de personagens ao buscar por nome quando o datasource for bem sucedido',
      () async {
        when(
          () => mockDatasource.getCharactersFromName(
            offset: any(named: 'offset'),
            limit: any(named: 'limit'),
            name: any(named: 'name'),
          ),
        ).thenAnswer((_) async => tCharacterList);

        final result = await repository.getCharactersFromName(
          offset: tOffset,
          limit: tLimit,
          name: tName,
        );

        expect(result, tCharacterList);
        verify(
          () => mockDatasource.getCharactersFromName(
            offset: tOffset,
            limit: tLimit,
            name: tName,
          ),
        );
        verifyNoMoreInteractions(mockDatasource);
      },
    );

    test(
      'deve propagar a exceção ao buscar por nome quando a chamada ao datasource falhar',
      () async {
        when(
          () => mockDatasource.getCharactersFromName(
            offset: any(named: 'offset'),
            limit: any(named: 'limit'),
            name: any(named: 'name'),
          ),
        ).thenThrow(tException);

        final call = repository.getCharactersFromName;

        expect(
          () => call(offset: tOffset, limit: tLimit, name: tName),
          throwsA(isA<ServerException>()),
        );
        verify(
          () => mockDatasource.getCharactersFromName(
            offset: tOffset,
            limit: tLimit,
            name: tName,
          ),
        );
        verifyNoMoreInteractions(mockDatasource);
      },
    );
  });
}
