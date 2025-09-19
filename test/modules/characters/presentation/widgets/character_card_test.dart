import 'package:desafio_marvel/modules/characters/domain/entities/chacacter_entity.dart';
import 'package:desafio_marvel/modules/characters/presentation/widgets/character_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/mock_http_client.dart';

void main() {
  setUpAll(() {
    registerFallbackValue(Uri.parse('http://fake.url'));
  });

  const tCharacter = CharacterEntity(
    id: 101,
    name: 'Captain Marvel',
    thumbnailUrl: 'url.jpg',
    description: 'The hero.',
  );

  group('CharacterCard Widget Test', () {
    testWidgets('deve renderizar o nome do personagem corretamente', (
      tester,
    ) async {
      await mockHttpClient(
        tester,
        MaterialApp(
          home: Scaffold(body: CharacterCard.grid(character: tCharacter)),
        ),
      );
      expect(find.text('Captain Marvel'), findsOneWidget);
    });

    testWidgets('deve ter 140 de largura quando for do tipo carrossel', (
      tester,
    ) async {
      await mockHttpClient(
        tester,
        MaterialApp(
          home: Scaffold(
            body: Center(child: CharacterCard.carousel(character: tCharacter)),
          ),
        ),
      );

      final sizedBoxFinder = find.byKey(const Key('carousel_card_sized_box'));
      expect(sizedBoxFinder, findsOneWidget);
      final sizedBox = tester.widget<SizedBox>(sizedBoxFinder);
      expect(sizedBox.width, 140);
    });
  });
}
