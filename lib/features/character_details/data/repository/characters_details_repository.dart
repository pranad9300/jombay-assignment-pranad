import '../data_sources/character_details_remote_data_source.dart';
import '../../../../shared/data/models/character_model.dart';
import '../models/episode.dart';

class CharactersDetailsRepository {
  final CharacterDetailsRemoteDataSource remoteDataSource;

  CharactersDetailsRepository({
    required this.remoteDataSource,
  });

  Future<Character> getCharacterDetails({
    required int characterId,
  }) async =>
      await remoteDataSource.getCharactersDetails(characterId: characterId);

  Future<Episode> computeEpisodeInfo({
    required String episodeUrl,
  }) async =>
      await remoteDataSource.computeEpisodeInfo(
        episodeUrl: episodeUrl,
      );
}
