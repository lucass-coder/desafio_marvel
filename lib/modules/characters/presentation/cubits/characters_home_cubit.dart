import 'dart:developer';

import 'package:desafio_marvel/core/client/exceptions/api_exceptions.dart';
import 'package:desafio_marvel/modules/characters/domain/entities/chacacter_entity.dart';
import 'package:desafio_marvel/modules/characters/domain/usecases/get_characters_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'characters_home_state.dart';

class CharactersHomeCubit extends Cubit<CharactersHomeState> {
  final GetCharactersUseCase getCharactersUseCase;
  CharactersHomeCubit(this.getCharactersUseCase)
    : super(CharactersHomeInitial());

  int _offset = 0;
  final int _limit = 20;
  bool _isFetching = false;
  final List<CharacterEntity> _characters = [];

  bool _hasReachedEnd = false;

  Future<void> fetchInitialCharacters() async {
    emit(CharactersHomeLoading());

    _offset = 0;
    _characters.clear();
    _hasReachedEnd = false;
    try {
      final newCharacters = await getCharactersUseCase(
        offset: _offset,
        limit: _limit,
      );

      if (newCharacters.isEmpty) {
        emit(
          CharactersHomeSuccess(
            characters: List.from(_characters),
            hasReachedEnd: _hasReachedEnd,
          ),
        );
      } else {
        if (newCharacters.length < _limit) {
          _hasReachedEnd = true;
        }
        _characters.addAll(newCharacters);
        _offset += _limit;

        emit(
          CharactersHomeSuccess(
            characters: List.from(_characters),
            hasReachedEnd: _hasReachedEnd,
          ),
        );
      }
    } on ApiException catch (e) {
      emit(CharactersHomeError(message: e.message));
    } catch (e) {
      emit(CharactersHomeError(message: 'Ocorreu um erro desconhecido.'));
    }
  }

  Future<void> loadMoreCharacters() async {
    if (_isFetching || _hasReachedEnd) return;
    _isFetching = true;

    final currentState = state as CharactersHomeSuccess;
    emit(currentState.copyWith(isFetching: true));

    try {
      final newCharacters = await getCharactersUseCase(
        offset: _offset,
        limit: _limit,
      );

      if (newCharacters.length < _limit) {
        _hasReachedEnd = true;
      }

      _characters.addAll(newCharacters);
      _offset += _limit;

      emit(
        CharactersHomeSuccess(
          characters: List.from(_characters),
          isFetching: false,
          hasReachedEnd: _hasReachedEnd,
        ),
      );
    } on ApiException catch (e) {
      //TODO: Lembrar de tratar o erro de loadMore sem mudar o estado todo
      emit(currentState.copyWith(isFetching: false));
      log('Erro ao carregar mais: ${e.message}');
    } catch (e) {
      emit(currentState.copyWith(isFetching: false));
    } finally {
      _isFetching = false;
    }
  }
}
