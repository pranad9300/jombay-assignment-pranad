import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../view_model/characters_bloc.dart';
import 'characters_list.dart';

class CharactersView extends StatelessWidget {
  const CharactersView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharactersBloc, CharactersState>(
      bloc: context.read<CharactersBloc>(),
      builder: (_, charactersState) {
        switch (charactersState.status) {
          case CharactersStatus.failure:
            return Center(
              child: Text(
                charactersState.message,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            );
          case CharactersStatus.success:
            return CharactersList(state: charactersState);
          case CharactersStatus.initial:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
