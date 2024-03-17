import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/data/models/character_model.dart';
import '../../../themes.dart';
import '../view_model/characters_bloc.dart';

class CharactersListItem extends StatelessWidget {
  const CharactersListItem({super.key, required this.character});

  final Character character;

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'alive':
        return RickAndMortyCharactersAppTheme.characterAliveColor;
      case 'dead':
        return RickAndMortyCharactersAppTheme.characterDeadColor;
      default:
        return RickAndMortyCharactersAppTheme
            .characterUnknownColor; // Suitable color for unknown
    }
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: character.name,
      child: Card(
        elevation: 6.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        child: InkWell(
          onTap: () =>
              Navigator.of(context).pushNamed('/characterDetails', arguments: {
            'characterId': character.id,
          }),
          child: Row(
            children: [
              // Image container
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                height: 200.0,
                child: Image.network(
                  character.image,
                  fit: BoxFit.cover,
                  colorBlendMode: BlendMode.darken,
                  color: Colors.black26,
                ),
              ),
              // Info section
              Expanded(
                child: SizedBox(
                  height: 200,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      // vertical: 5,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Name (larger font)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              character.name,
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Row(
                              textBaseline: TextBaseline.ideographic,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                    right: 5.0,
                                  ), // Add margin after dot
                                  child: Icon(
                                    Icons.brightness_1, // Small circle icon
                                    size: 12.0,
                                    color: _getStatusColor(character.status),
                                  ),
                                ),

                                // Status and species (smaller font)'
                                Expanded(
                                  child: Text(
                                    '${character.status} - ${character.species}',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                    maxLines: 2,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Last Known Location:',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              character.location.name,
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'First Seen in:',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              FutureBuilder(
                                  future: context
                                      .read<CharactersBloc>()
                                      .computeFirstAppearance(
                                        firstAppearanceEpisodeUrl:
                                            character.episode.first.isNotEmpty
                                                ? character.episode.first
                                                : '',
                                      ),
                                  builder: (_, firstAppearanceSnapshot) {
                                    return Text(
                                      firstAppearanceSnapshot.connectionState ==
                                              ConnectionState.waiting
                                          ? 'searching..'
                                          : firstAppearanceSnapshot.hasData
                                              ? firstAppearanceSnapshot.data!
                                              : 'NA',
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    );
                                  }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
