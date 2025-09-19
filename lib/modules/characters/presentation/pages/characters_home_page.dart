import 'package:desafio_marvel/core/utils/debouncer.dart';
import 'package:desafio_marvel/core/widgets/custom_app_bar.dart';
import 'package:desafio_marvel/modules/characters/presentation/cubits/characters_home_cubit.dart';
import 'package:desafio_marvel/modules/characters/presentation/views/characters_home_success_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CharactersHomePage extends StatefulWidget {
  const CharactersHomePage({super.key});

  @override
  State<CharactersHomePage> createState() => _CharactersHomePageState();
}

class _CharactersHomePageState extends State<CharactersHomePage> {
  late CharactersHomeCubit cubit;
  final searchEC = TextEditingController();
  final scrollController = ScrollController();
  final _debouncer = Debouncer(duration: const Duration(milliseconds: 500));

  @override
  void initState() {
    super.initState();
    cubit = Modular.get<CharactersHomeCubit>();
    cubit.fetchInitialCharacters();
  }

  @override
  void dispose() {
    super.dispose();
    searchEC.dispose();
    scrollController.dispose();
    _debouncer.dispose();
  }

  void _onChange(String searchText) {
    _debouncer.run(() {
      searchEC.text.isEmpty
          ? cubit.fetchInitialCharacters()
          : cubit.fetchInitialCharactersByName(name: searchText);
    });
  }

  Future<void> _onRefresh() async {
    final searchText = searchEC.text;
    if (searchText.isEmpty) {
      await cubit.fetchInitialCharacters();
    } else {
      await cubit.fetchInitialCharactersByName(name: searchText);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: BlocBuilder<CharactersHomeCubit, CharactersHomeState>(
        bloc: cubit,
        builder: (context, state) {
          if (state is CharactersHomeLoading ||
              state is CharactersHomeInitial) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CharactersHomeSuccess) {
            return CharactersHomeSuccessView(
              cubit: cubit,
              scrollController: scrollController,
              searchController: searchEC,
              onSearchChanged: _onChange,
              onRefresh: _onRefresh,
              state: state,
            );
          } else if (state is CharactersHomeError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Error fetching characters'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _onRefresh,
                    child: const Text('Refresh'),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('Welcome to Marvel App'));
          }
        },
      ),
    );
  }
}
