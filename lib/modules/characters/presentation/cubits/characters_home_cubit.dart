import 'dart:developer';

import 'package:desafio_marvel/core/client/exceptions/api_exceptions.dart';
import 'package:desafio_marvel/modules/characters/domain/entities/chacacter_entity.dart';
import 'package:desafio_marvel/modules/characters/domain/usecases/get_characters_for_name_usecase.dart';
import 'package:desafio_marvel/modules/characters/domain/usecases/get_characters_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'characters_home_state.dart';

class CharactersHomeCubit extends Cubit<CharactersHomeState> {
  final GetCharactersUseCase getCharactersUseCase;
  final GetCharactersForNameUseCase getCharactersForNameUseCase;

  CharactersHomeCubit(
    this.getCharactersUseCase,
    this.getCharactersForNameUseCase,
  ) : super(CharactersHomeInitial());

  String? _currentSearchName;
  final int _limit = 20;

  Future<void> fetchInitialCharacters() async {
    _currentSearchName = null;
    emit(CharactersHomeLoading());

    try {
      final newCharacters = await getCharactersUseCase(
        offset: 0,
        limit: _limit,
      );

      emit(
        CharactersHomeSuccess(
          characters: newCharacters,
          hasReachedEnd: newCharacters.length < _limit,
        ),
      );
    } on ApiException catch (e) {
      emit(CharactersHomeError(message: e.message));
    } catch (e) {
      emit(CharactersHomeError(message: 'Ocorreu um erro desconhecido.'));
    }
  }

  Future<void> loadMoreCharacters() async {
    if (state is! CharactersHomeSuccess) return;
    final currentState = state as CharactersHomeSuccess;
    if (currentState.isFetching || currentState.hasReachedEnd) return;

    emit(currentState.copyWith(isFetching: true));

    try {
      final currentOffset = currentState.characters.length;

      final newCharacters = await getCharactersUseCase(
        offset: currentOffset,
        limit: _limit,
      );

      final hasReachedEnd = newCharacters.length < _limit;

      final updatedCharacters = List<CharacterEntity>.from(
        currentState.characters,
      )..addAll(newCharacters);

      emit(
        CharactersHomeSuccess(
          characters: updatedCharacters,
          isFetching: false,
          hasReachedEnd: hasReachedEnd,
        ),
      );
    } on ApiException catch (e) {
      log('Erro ao carregar mais: ${e.message}');
      emit(currentState.copyWith(isFetching: false));
    } catch (e) {
      log('Erro inesperado ao carregar mais: $e');
      emit(currentState.copyWith(isFetching: false));
    }
  }

  Future<void> fetchInitialCharactersByName({required String name}) async {
    _currentSearchName = name;
    emit(CharactersHomeLoading());

    try {
      final newCharacters = await getCharactersForNameUseCase(
        name: name,
        offset: 0,
        limit: _limit,
      );

      emit(
        CharactersHomeSuccess(
          characters: newCharacters,
          hasReachedEnd: newCharacters.length < _limit,
        ),
      );
    } on ApiException catch (e) {
      emit(CharactersHomeError(message: e.message));
    } catch (e) {
      emit(CharactersHomeError(message: 'Ocorreu um erro desconhecido.'));
    }
  }

  Future<void> loadMoreCharactersByName() async {
    if (state is! CharactersHomeSuccess || _currentSearchName == null) return;
    final currentState = state as CharactersHomeSuccess;
    if (currentState.isFetching || currentState.hasReachedEnd) return;

    emit(currentState.copyWith(isFetching: true));

    try {
      final currentOffset = currentState.characters.length;

      final newCharacters = await getCharactersForNameUseCase(
        name: _currentSearchName!,
        offset: currentOffset,
        limit: _limit,
      );

      final hasReachedEnd = newCharacters.length < _limit;

      final updatedCharacters = List<CharacterEntity>.from(
        currentState.characters,
      )..addAll(newCharacters);

      emit(
        CharactersHomeSuccess(
          characters: updatedCharacters,
          isFetching: false,
          hasReachedEnd: hasReachedEnd,
        ),
      );
    } on ApiException catch (e) {
      log('Erro ao carregar mais por nome: ${e.message}');
      emit(currentState.copyWith(isFetching: false));
    } catch (e) {
      log('Erro inesperado ao carregar mais por nome: $e');
      emit(currentState.copyWith(isFetching: false));
    }
  }
}
