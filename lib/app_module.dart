import 'package:desafio_marvel/modules/characters/characters_home_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  void routes(RouteManager r) {
    super.routes(r);

    r.module('/', module: CharactersHomeModule());
  }
}
