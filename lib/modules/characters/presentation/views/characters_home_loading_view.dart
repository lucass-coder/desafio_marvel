import 'package:desafio_marvel/modules/characters/presentation/widgets/character_search_field_shimmer.dart';
import 'package:desafio_marvel/modules/characters/presentation/widgets/characters_grid_view_shimmer.dart';
import 'package:desafio_marvel/modules/characters/presentation/widgets/featured_characters_carousel_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class CharactersHomeLoadingView extends StatelessWidget {
  const CharactersHomeLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      duration: const Duration(seconds: 2),
      color: Colors.white,
      child: const CustomScrollView(
        physics: NeverScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(child: FeaturedCharactersCarouselShimmer()),
          SliverToBoxAdapter(child: CharacterSearchFieldShimmer()),
          CharactersGridViewShimmer(),
        ],
      ),
    );
  }
}
