import 'package:desafio_marvel/core/client/api_client.dart';
import 'package:desafio_marvel/modules/characters/data/datasources/characters_home_datasource.dart';
import 'package:desafio_marvel/modules/characters/data/repositories/characters_home_repository_impl.dart';
import 'package:desafio_marvel/modules/characters/domain/repositories/characters_home_repository.dart';
import 'package:desafio_marvel/modules/characters/domain/usecases/get_characters_for_name_usecase.dart';
import 'package:desafio_marvel/modules/characters/domain/usecases/get_characters_usecase.dart';
import 'package:desafio_marvel/modules/characters/presentation/cubits/characters_home_cubit.dart';
import 'package:desafio_marvel/modules/characters/presentation/pages/characters_home_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CharactersHomeModule extends Module {
  @override
  void binds(Injector i) {
    super.binds(i);

    i.add<ApiClient>(() => ApiClient());

    i.add<CharactersHomeDatasource>(
      () => CharactersHomeDatasource(dio: i.get<ApiClient>()),
    );

    i.add<CharactersHomeRepository>(
      () => CharactersHomeRepositoryImpl(
        datasource: i.get<CharactersHomeDatasource>(),
      ),
    );

    i.add<GetCharactersForNameUseCase>(
      (() => GetCharactersForNameUseCase(i.get())),
    );

    i.add<GetCharactersUseCase>(
      () => GetCharactersUseCase(i.get<CharactersHomeRepository>()),
    );

    i.add<CharactersHomeCubit>(
      () => CharactersHomeCubit(
        i.get<GetCharactersUseCase>(),
        i.get<GetCharactersForNameUseCase>(),
      ),
    );
  }

  @override
  void routes(RouteManager r) {
    super.routes(r);

    r.child('/', child: (_) => CharactersHomePage());
  }
}
