import 'package:bloc/bloc.dart';

import '../../../core/error/failures.dart';

import '../../../shared/data/models/character_model.dart';
import '../data/models/episode.dart';
import '../data/repository/characters_details_repository.dart';

part 'character_details_event.dart';

part 'character_details_state.dart';

class CharacterDetailsBloc
    extends Bloc<CharactersDetailsEvent, CharacterDetailsState> {
  CharacterDetailsBloc({
    required this.charactersDetailsRepository,
  }) : super(CharacterDetailsState()) {
    on<CharactersDetailsGet>(_getCharacterDetails);
  }

  final CharactersDetailsRepository charactersDetailsRepository;

  Future<void> _getCharacterDetails(
    CharactersDetailsGet event,
    Emitter<CharacterDetailsState> emit,
  ) async {
    try {
      emit(CharacterDetailsState(
        status: CharacterDetailsStatus.success,
        characterDetails: null,
      ));

      Character characterDetails =
          await charactersDetailsRepository.getCharacterDetails(
        characterId: event.characterId,
      );

      emit(CharacterDetailsState(
        status: CharacterDetailsStatus.success,
        characterDetails: characterDetails,
      ));
    } on Failure catch (e) {
      emit(state.copyWith(
        message: e.message,
        status: CharacterDetailsStatus.failure,
      ));
    }
  }

  Future<Episode> Function({
    required String episodeUrl,
  }) get computeEpisodeInfo => ({
        required String episodeUrl,
      }) async =>
          await charactersDetailsRepository.computeEpisodeInfo(
            episodeUrl: episodeUrl,
          );
}
