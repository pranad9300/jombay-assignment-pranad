class Character {
  // Character ID (final ensures it's set during initialization)
  final int id;

  // Character name
  final String name;

  // Character status (alive, dead, unknown)
  final String status;

  // Character species
  final String species;

  // Character type (additional description)
  final String type;

  // Character gender
  final String gender;

  // Character origin information (nested Origin class)
  final Origin origin;

  // Character location information (nested Location class)
  final Location location;

  // Character image URL
  final String image;

  // List of episode URLs the character appeared in
  final List<String> episode;

  // Character URL from the Rick and Morty API
  final String url;

  // Date and time the character was created in the API
  final DateTime created;

  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.url,
    required this.created,
  });

  // Converts the Character object to a Map for serialization (e.g., saving to a database)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'species': species,
      'type': type,
      'gender': gender,
      'origin': origin.toMap(), // Delegate tomap() to nested Origin class
      'location': location.toMap(), // Delegate tomap() to nested Location class
      'image': image,
      'episode': episode,
      'url': url,
      'created': created
          .toIso8601String(), // Use toIso8601String for consistent date format
    };
  }

  // Factory constructor that creates a Character object from a Map (e.g., deserialization)
  factory Character.fromMap(Map<String, dynamic> map) {
    return Character(
      id: map['id'] ??
          0, // Use nullish coalescing operator (??) to handle missing values
      name: map['name'] ?? '',
      status: map['status'] ?? '',
      species: map['species'] ?? '',
      type: map['type'] ?? '',
      gender: map['gender'] ?? '',
      origin: Origin.fromMap(
          map['origin'] ?? {}), // Delegate fromMap() to nested Origin class
      location: Location.fromMap(
          map['location'] ?? {}), // Delegate fromMap() to nested Location class
      image: map['image'] ?? '',
      episode: map['episode']?.cast<String>() ??
          [], // Handle null episode list gracefully
      url: map['url'] ?? '',
      created: DateTime.parse(
          map['created'] ?? ''), // Parse date string even if it's null
    );
  }
}

class Origin {
  // Origin name
  final String name;

  // Origin URL
  final String url;

  Origin({
    required this.name,
    required this.url,
  });

  // Converts the Origin object to a Map for serialization
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'url': url,
    };
  }

  // Factory constructor that creates an Origin object from a Map
  factory Origin.fromMap(Map<String, dynamic> map) {
    return Origin(
      name: map['name'] ?? '',
      url: map['url'] ?? '',
    );
  }
}

class Location {
  // Location name
  final String name;

  // Location URL
  final String url;

  Location({
    required this.name,
    required this.url,
  });

  // Converts the Location object to a Map for serialization
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'url': url,
    };
  }

  // Factory constructor that creates a Location object from a Map
  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      name: map['name'] ?? '',
      url: map['url'] ?? '',
    );
  }
}
