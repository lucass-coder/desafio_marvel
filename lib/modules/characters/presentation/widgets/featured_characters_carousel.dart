import 'package:desafio_marvel/modules/characters/domain/entities/chacacter_entity.dart';
import 'package:flutter/material.dart';

import 'character_card.dart';

class FeaturedCharactersCarousel extends StatelessWidget {
  final List<CharacterEntity> characters;
  const FeaturedCharactersCarousel({super.key, required this.characters});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24, bottom: 16, left: 24),
          child: const Text(
            'FEATURED CHARACTERS',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
          ),
        ),
        SizedBox(
          height: 180,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: characters.length,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: CharacterCard.carousel(character: characters[index]),
                );
              } else {
                return CharacterCard.carousel(character: characters[index]);
              }
            },
          ),
        ),
      ],
    );
  }
}
