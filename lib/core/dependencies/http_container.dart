import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final GetIt sl = GetIt.instance;

void init() {
  /// [http.Client]
  sl.registerLazySingleton<http.Client>(() => http.Client());
}
