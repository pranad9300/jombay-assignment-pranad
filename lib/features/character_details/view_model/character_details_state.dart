part of 'character_details_bloc.dart';

enum CharacterDetailsStatus {
  initial,
  success,
  failure,
}

class CharacterDetailsState {
  final CharacterDetailsStatus status;

  final Character? characterDetails;

  final String? message;

  CharacterDetailsState({
    this.status = CharacterDetailsStatus.initial,
    this.characterDetails,
    this.message = '',
  });

  CharacterDetailsState copyWith({
    CharacterDetailsStatus? status,
    Character? characterDetails,
    String? message,
  }) {
    return CharacterDetailsState(
      status: status ?? this.status,
      characterDetails: characterDetails ?? this.characterDetails,
      message: message ?? this.message,
    );
  }
}
