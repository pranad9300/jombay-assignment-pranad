import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/widgets/bottom_loader.dart';
import '../view_model/characters_bloc.dart';
import 'character_list_item.dart';

class CharactersList extends StatefulWidget {
  const CharactersList({
    super.key,
    required this.state,
  });

  final CharactersState state;

  @override
  State<CharactersList> createState() => _CharactersListState();
}

class _CharactersListState extends State<CharactersList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<CharactersBloc>().add(CharactersUpdate());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.state.charactersResponse?.characters.isEmpty ?? true) {
      return Center(
          child: Text(
        'no posts',
        style: Theme.of(context).textTheme.bodyMedium,
      ));
    }
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return index >=
                    (widget.state.charactersResponse?.characters.length ?? 0)
                ? const BottomLoader()
                : CharactersListItem(
                    character:
                        widget.state.charactersResponse!.characters[index],
                  );
          },
          itemCount: widget.state.hasReachedMax
              ? widget.state.charactersResponse!.characters.length
              : widget.state.charactersResponse!.characters.length + 1,
          controller: _scrollController,
        ),
      ),
    );
  }
}
