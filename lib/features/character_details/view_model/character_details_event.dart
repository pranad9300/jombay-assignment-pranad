part of 'character_details_bloc.dart';

abstract class CharactersDetailsEvent {}

final class CharactersDetailsGet extends CharactersDetailsEvent {
  final int characterId;

  CharactersDetailsGet({required this.characterId});
}
