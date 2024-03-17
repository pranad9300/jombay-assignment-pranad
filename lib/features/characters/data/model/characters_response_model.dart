import '../../../../shared/data/models/character_model.dart';

class CharactersResponse {
  final int count;
  final int pages;
  final String? next;
  final String? previous;
  final List<Character> characters;

  const CharactersResponse({
    required this.count,
    required this.pages,
    required this.next,
    required this.previous,
    this.characters = const <Character>[],
  });

  CharactersResponse copyWith(CharactersResponse updatedCharacters) {
    return CharactersResponse(
      count: updatedCharacters.count,
      pages: updatedCharacters.pages,
      next: updatedCharacters.next,
      previous: updatedCharacters.previous,
      characters: characters + updatedCharacters.characters,
    );
  }

  factory CharactersResponse.fromMap(Map<String, dynamic> charactersMap) {
    return CharactersResponse(
      count: charactersMap['info']['count'],
      pages: charactersMap['info']['pages'],
      next: charactersMap['info']['next'],
      previous: charactersMap['info']['previous'],
      characters: charactersMap['results']
          .map((characterMap) => Character.fromMap(characterMap))
          .cast<Character>()
          .toList(),
    );
  }
}
