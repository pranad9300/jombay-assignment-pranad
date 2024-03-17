import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../../features/characters/data/data_source/characters_remote_data_source.dart';
import '../../features/characters/data/repositories/characters_repository.dart';

final GetIt sl = GetIt.instance;

void init() {
  // Datasources
  /// [CharactersRemoteDataSources]
  sl.registerLazySingleton<CharactersRemoteDataSources>(
    () => CharactersRemoteDataSources(client: sl<http.Client>()),
  );

  /// Repositories
  /// [CharactersRepository]
  sl.registerLazySingleton<CharactersRepository>(
    () => CharactersRepository(
        remoteDataSource: sl<CharactersRemoteDataSources>()),
  );
}
