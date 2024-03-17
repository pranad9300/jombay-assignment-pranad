class Episode {
  final int id;
  final String name;
  final String airDate;
  final String episode;
  final List<String> characters;
  final String url;
  final DateTime created;

  Episode({
    required this.id,
    required this.name,
    required this.airDate,
    required this.episode,
    required this.characters,
    required this.url,
    required this.created,
  });

  factory Episode.fromMap(Map<String, dynamic> episodeMap) => Episode(
        id: episodeMap['id'],
        name: episodeMap['name'],
        airDate: episodeMap['air_date'],
        episode: episodeMap['episode'],
        characters: List<String>.from(episodeMap['characters']),
        url: episodeMap['url'],
        created: DateTime.parse(episodeMap['created']),
      );
}
