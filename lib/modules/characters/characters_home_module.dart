import 'package:desafio_marvel/modules/characters/presentation/pages/characters_home_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CharactersHomeModule extends Module {
  @override
  void routes(RouteManager r) {
    super.routes(r);

    r.child('/', child: (_) => CharactersHomePage());
  }
}
