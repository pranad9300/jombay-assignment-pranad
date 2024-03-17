import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../../features/character_details/data/data_sources/character_details_remote_data_source.dart';
import '../../features/character_details/data/repository/characters_details_repository.dart';

final GetIt sl = GetIt.instance;

void init() {
  // Datasources
  /// [CharactersRemoteDataSources]
  sl.registerLazySingleton<CharacterDetailsRemoteDataSource>(
    () => CharacterDetailsRemoteDataSource(client: sl<http.Client>()),
  );

  /// Repositories
  /// [CharactersRepository]
  sl.registerLazySingleton<CharactersDetailsRepository>(
    () => CharactersDetailsRepository(
      remoteDataSource: sl<CharacterDetailsRemoteDataSource>(),
    ),
  );
}
