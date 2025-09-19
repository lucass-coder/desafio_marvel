import 'package:desafio_marvel/modules/characters/presentation/cubits/characters_home_cubit.dart';
import 'package:desafio_marvel/modules/characters/presentation/widgets/characters_grid_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CharactersHomeSuccessView extends StatelessWidget {
  final CharactersHomeCubit cubit;
  final ScrollController scrollController;
  final Future<void> Function() onRefresh;
  final CharactersHomeSuccess state;

  const CharactersHomeSuccessView({
    super.key,
    required this.cubit,
    required this.scrollController,
    required this.onRefresh,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (!state.hasReachedEnd &&
            !state.isFetching &&
            notification.metrics.pixels >=
                notification.metrics.maxScrollExtent * 0.9) {
          cubit.loadMoreCharacters();
        }
        return true;
      },
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        controller: scrollController,
        slivers: [
          CupertinoSliverRefreshControl(onRefresh: onRefresh),
          CharactersGridView(characters: state.characters),
          if (state.isFetching)
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Center(child: CircularProgressIndicator()),
              ),
            ),
          if (state.hasReachedEnd && !state.isFetching)
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Center(
                  child: Text(
                    'END OF LIST',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
