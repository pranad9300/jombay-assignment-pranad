import '../data_source/characters_remote_data_source.dart';
import '../model/characters_response_model.dart';

class CharactersRepository {
  final CharactersRemoteDataSources remoteDataSource;

  const CharactersRepository({required this.remoteDataSource});

  Future<CharactersResponse> getCharacters({
    String? characterNextPageUrl,
  }) async =>
      await remoteDataSource.getCharacters(
        characterNextPageUrl: characterNextPageUrl,
      );

  Future<String> computeCharactersFirstAppearance(
    String firstAppearanceEpisodeUrl,
  ) async =>
      await remoteDataSource.computeCharactersFirstAppearanceEpisodeName(
        firstAppearanceEpisodeUrl,
      );
}
