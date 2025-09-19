import 'package:bloc_test/bloc_test.dart';
import 'package:desafio_marvel/core/client/exceptions/api_exceptions.dart';
import 'package:desafio_marvel/modules/characters/domain/entities/chacacter_entity.dart';
import 'package:desafio_marvel/modules/characters/domain/usecases/get_characters_for_name_usecase.dart';
import 'package:desafio_marvel/modules/characters/domain/usecases/get_characters_usecase.dart';
import 'package:desafio_marvel/modules/characters/presentation/cubits/characters_home_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetCharactersUseCase extends Mock implements GetCharactersUseCase {}

class MockGetCharactersForNameUseCase extends Mock
    implements GetCharactersForNameUseCase {}

void main() {
  late CharactersHomeCubit cubit;
  late MockGetCharactersUseCase mockGetCharactersUseCase;
  late MockGetCharactersForNameUseCase mockGetCharactersForNameUseCase;

  const character1 = CharacterEntity(
    id: 1,
    name: 'Spider-Man',
    thumbnailUrl: 'url1',
    description: 'Homem Aranha, nunca bate, só apanha',
  );
  const character2 = CharacterEntity(
    id: 1,
    name: 'Iron-Man',
    thumbnailUrl: 'url2',
    description: 'Eu sou o Homem de Ferro',
  );
  final tCharacterList = [character1, character2];
  final tException = ServerException('Erro no servidor');

  setUp(() {
    mockGetCharactersUseCase = MockGetCharactersUseCase();
    mockGetCharactersForNameUseCase = MockGetCharactersForNameUseCase();
    cubit = CharactersHomeCubit(
      mockGetCharactersUseCase,
      mockGetCharactersForNameUseCase,
    );
  });

  tearDown(() {
    cubit.close();
  });

  test('o estado inicial deve ser CharactersHomeInitial', () {
    expect(cubit.state, isA<CharactersHomeInitial>());
  });

  group('fetchInitialCharacters', () {
    blocTest<CharactersHomeCubit, CharactersHomeState>(
      'deve emitir [Loading, Success] quando a busca for bem sucedida',
      build: () {
        when(
          () => mockGetCharactersUseCase.call(
            offset: any(named: 'offset'),
            limit: any(named: 'limit'),
          ),
        ).thenAnswer((_) async => tCharacterList);
        return cubit;
      },
      act: (cubit) => cubit.fetchInitialCharacters(),
      expect: () => <Matcher>[
        isA<CharactersHomeLoading>(),
        isA<CharactersHomeSuccess>(),
      ],
      verify: (_) {
        verify(
          () => mockGetCharactersUseCase.call(offset: 0, limit: 20),
        ).called(1);
      },
    );

    blocTest<CharactersHomeCubit, CharactersHomeState>(
      'deve emitir [Loading, Success com lista vazia] quando a busca não retornar resultados',
      build: () {
        when(
          () => mockGetCharactersUseCase.call(
            offset: any(named: 'offset'),
            limit: any(named: 'limit'),
          ),
        ).thenAnswer((_) async => []);
        return cubit;
      },
      act: (cubit) => cubit.fetchInitialCharacters(),
      expect: () => <Matcher>[
        isA<CharactersHomeLoading>(),
        isA<CharactersHomeSuccess>().having(
          (state) => state.characters,
          'characters',
          isEmpty,
        ),
      ],
    );

    blocTest<CharactersHomeCubit, CharactersHomeState>(
      'deve emitir [Loading, Error] quando a busca falhar',
      build: () {
        when(
          () => mockGetCharactersUseCase.call(
            offset: any(named: 'offset'),
            limit: any(named: 'limit'),
          ),
        ).thenThrow(tException);
        return cubit;
      },
      act: (cubit) => cubit.fetchInitialCharacters(),
      expect: () => <Matcher>[
        isA<CharactersHomeLoading>(),
        isA<CharactersHomeError>().having(
          (state) => state.message,
          'message',
          tException.message,
        ),
      ],
    );
  });

  group('loadMoreCharacters', () {
    final tInitialState = CharactersHomeSuccess(
      characters: tCharacterList,
      isFetching: false,
      hasReachedEnd: false,
    );
    final tNextPageList = [
      const CharacterEntity(
        id: 2,
        name: 'Iron Man',
        thumbnailUrl: 'url2',
        description: '',
      ),
    ];

    blocTest<CharactersHomeCubit, CharactersHomeState>(
      'deve emitir [Success com isFetching=true, Success com lista atualizada] ao carregar mais',
      setUp: () {
        when(
          () => mockGetCharactersUseCase.call(offset: 20, limit: 20),
        ).thenAnswer((_) async => tNextPageList);
      },
      build: () => cubit,
      seed: () {
        cubit.emit(tInitialState);
        return cubit.state;
      },
      act: (cubit) => cubit.loadMoreCharacters(),
      expect: () => <Matcher>[
        isA<CharactersHomeSuccess>().having(
          (s) => s.isFetching,
          'isFetching',
          isTrue,
        ),
        isA<CharactersHomeSuccess>(),
      ],
    );

    blocTest<CharactersHomeCubit, CharactersHomeState>(
      'não deve emitir novos estados se já estiver buscando',
      build: () => cubit,
      seed: () => CharactersHomeSuccess(characters: [], isFetching: true),
      act: (cubit) => cubit.loadMoreCharacters(),
      expect: () => <Matcher>[],
      verify: (_) {
        verifyNever(
          () => mockGetCharactersUseCase.call(
            offset: any(named: 'offset'),
            limit: any(named: 'limit'),
          ),
        );
      },
    );
  });
}
