import 'package:desafio_marvel/app_module.dart';
import 'package:desafio_marvel/app_widget.dart';
import 'package:desafio_marvel/modules/characters/presentation/widgets/character_card.dart';
import 'package:desafio_marvel/modules/characters/presentation/widgets/characters_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

Future<void> main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  testWidgets('Fluxo E2E Completo do App Marvel', (tester) async {
    await tester.pumpWidget(
      ModularApp(module: AppModule(), child: const AppWidget()),
    );
    await tester.pumpAndSettle(const Duration(seconds: 5));
    const firstCharacterName = '3-D Man';
    expect(find.text(firstCharacterName), findsWidgets);
    expect(find.byType(TextField), findsOneWidget);
    final gridFinder = find.byType(CharactersGridView);
    final firstCardFinder = find
        .descendant(of: gridFinder, matching: find.byType(CharacterCard))
        .first;

    await tester.tap(firstCardFinder);
    await tester.pumpAndSettle(const Duration(seconds: 3));
    expect(find.text('BIOGRAPHY'), findsOneWidget);
    expect(find.text(firstCharacterName), findsOneWidget);
    await tester.tap(find.byKey(Key('back_button')));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    expect(find.text('MARVEL CHARACTERS LIST'), findsOneWidget);

    final searchField = find.byType(TextField);
    await tester.enterText(searchField, 'Hulk');
    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(find.text('3-D Man'), findsNothing);
    expect(find.text('Hulk'), findsWidgets);

    await tester.enterText(searchField, '');
    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(find.text('Hulk'), findsNothing);
    expect(find.text('3-D Man'), findsWidgets);
  });
}
