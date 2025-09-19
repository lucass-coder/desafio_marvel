import 'package:flutter/material.dart';

import 'character_card_shimmer.dart';

class CharactersGridViewShimmer extends StatelessWidget {
  const CharactersGridViewShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(left: 24, right: 24),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate((context, index) {
          return const CharacterCardShimmer(width: 0, height: 0);
        }, childCount: 6),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.8,
        ),
      ),
    );
  }
}
