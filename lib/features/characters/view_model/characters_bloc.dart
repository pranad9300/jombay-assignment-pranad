import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../../core/error/failures.dart';
import '../data/model/characters_response_model.dart';
import '../data/repositories/characters_repository.dart';

part 'characters_event.dart';
part 'characters_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  CharactersBloc({
    required this.charactersRepository,
  }) : super(const CharactersState()) {
    on<CharactersGet>(_getCharacters);
    on<CharactersUpdate>(
      _updateCharacters,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final CharactersRepository charactersRepository;

  Future<void> _getCharacters(
    CharactersGet event,
    Emitter<CharactersState> emit,
  ) async {
    try {
      CharactersResponse charactersResponse =
          await charactersRepository.getCharacters();

      emit(CharactersState(
        status: CharactersStatus.success,
        charactersResponse: charactersResponse,
        hasReachedMax: charactersResponse.next == null,
      ));
    } on Failure catch (e) {
      emit(state.copyWith(
        message: e.message,
        status: CharactersStatus.failure,
      ));
    }
  }

  Future<void> _updateCharacters(
    CharactersUpdate event,
    Emitter<CharactersState> emit,
  ) async {
    try {
      CharactersResponse charactersResponse =
          await charactersRepository.getCharacters(
        characterNextPageUrl: state.charactersResponse?.next,
      );

      emit(state.copyWith(
        status: CharactersStatus.success,
        charactersResponse: charactersResponse,
        hasReachedMax: charactersResponse.next == null,
      ));
    } on Failure catch (e) {
      emit(state.copyWith(
        message: e.message,
        status: CharactersStatus.failure,
      ));
    }
  }

  Future<String> Function({
    required String firstAppearanceEpisodeUrl,
  }) get computeFirstAppearance => ({
        required String firstAppearanceEpisodeUrl,
      }) async =>
          await charactersRepository.computeCharactersFirstAppearance(
            firstAppearanceEpisodeUrl,
          );
}
