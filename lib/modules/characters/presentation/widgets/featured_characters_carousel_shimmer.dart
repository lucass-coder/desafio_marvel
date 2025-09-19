import 'package:flutter/material.dart';

import 'character_card_shimmer.dart';

class FeaturedCharactersCarouselShimmer extends StatelessWidget {
  const FeaturedCharactersCarouselShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24, bottom: 16, left: 24),
          child: Container(width: 200, height: 16, color: Colors.black26),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 180,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 24),
                child: const CharacterCardShimmer(width: 140, height: 180),
              );
            },
          ),
        ),
      ],
    );
  }
}
