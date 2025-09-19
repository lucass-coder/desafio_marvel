import 'package:desafio_marvel/modules/characters/domain/entities/chacacter_entity.dart';
import 'package:flutter/material.dart';

import 'character_card.dart';

class CharactersGridView extends StatelessWidget {
  final List<CharacterEntity> characters;
  const CharactersGridView({super.key, required this.characters});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(left: 24, right: 24),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate((context, index) {
          return CharacterCard.grid(character: characters[index]);
        }, childCount: characters.length),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.8,
        ),
      ),
    );
  }
}
