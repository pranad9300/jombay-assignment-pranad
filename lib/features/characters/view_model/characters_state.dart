part of 'characters_bloc.dart';

enum CharactersStatus {
  initial,
  success,
  failure,
}

class CharactersState {
  const CharactersState({
    this.status = CharactersStatus.initial,
    this.charactersResponse,
    this.hasReachedMax = false,
    this.message = '',
  });

  final CharactersStatus status;

  final CharactersResponse? charactersResponse;

  final String message;

  final bool hasReachedMax;

  CharactersState copyWith({
    CharactersStatus? status,
    CharactersResponse? charactersResponse,
    bool? hasReachedMax,
    String? message,
  }) {
    return CharactersState(
      status: status ?? this.status,
      charactersResponse: charactersResponse == null
          ? this.charactersResponse
          : this.charactersResponse?.copyWith(charactersResponse),
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      message: message ?? this.message,
    );
  }
}
