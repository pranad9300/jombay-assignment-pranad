class Endpoints {
  static const String characterBaseUrl =
      'https://rickandmortyapi.com/api/character/';

  static Uri Function(int) get characterEndpoint =>
      (int characterId) => Uri.parse('$characterBaseUrl/$characterId');
}
