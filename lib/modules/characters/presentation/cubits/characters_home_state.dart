part of 'characters_home_cubit.dart';

abstract class CharactersHomeState extends Equatable {}

class CharactersHomeInitial extends CharactersHomeState {
  @override
  List<Object?> get props => [];
}

class CharactersHomeLoading extends CharactersHomeState {
  @override
  List<Object?> get props => [];
}

class CharactersHomeLoadingMore extends CharactersHomeState {
  @override
  List<Object?> get props => [];
}

class CharactersHomeSuccess extends CharactersHomeState {
  final List<CharacterEntity> characters;
  final bool isFetching;
  final bool hasReachedEnd;
  CharactersHomeSuccess({
    required this.characters,
    this.isFetching = false,
    this.hasReachedEnd = false,
  });

  CharactersHomeSuccess copyWith({
    List<CharacterEntity>? characters,
    bool? isFetching,
  }) {
    return CharactersHomeSuccess(
      characters: characters ?? this.characters,
      isFetching: isFetching ?? this.isFetching,
    );
  }

  @override
  List<Object?> get props => [characters, isFetching, hasReachedEnd];
}

final class CharactersHomeError extends CharactersHomeState {
  final String message;
  CharactersHomeError({this.message = 'Ocorreu um erro inesperado.'});

  @override
  List<Object> get props => [message];
}
