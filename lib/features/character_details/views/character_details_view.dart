import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/episode.dart';
import '../view_model/character_details_bloc.dart';

class CharacterDetailsView extends StatelessWidget {
  final int characterId;

  const CharacterDetailsView({
    super.key,
    required this.characterId,
  });

  Widget _buildDetailsRow(BuildContext context, String characterInfString) {
    return Text(
      textAlign: TextAlign.start,
      characterInfString,
      style: Theme.of(context).textTheme.bodyLarge,
      maxLines: 2,
    );
  }

  Widget _buildEpisodeCard(BuildContext context, String episodeUrl) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<Episode>(
          future: context.read<CharacterDetailsBloc>().computeEpisodeInfo(
                episodeUrl: episodeUrl,
              ),
          builder: (_, episodeSnapshot) =>
              episodeSnapshot.connectionState == ConnectionState.waiting
                  ? const Center(child: CircularProgressIndicator())
                  : episodeSnapshot.hasData
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Episode name (larger font)
                            Text(
                              episodeSnapshot.data!.name,
                              style: Theme.of(context).textTheme.bodyLarge,
                              textScaler: const TextScaler.linear(0.9),
                            ),
                            // Air date (smaller font)

                            Text(
                              episodeSnapshot.data!.episode,
                              style: const TextStyle(color: Colors.grey),
                            ),
                            Text(
                              episodeSnapshot.data!.airDate,
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            Text(episodeSnapshot.error.toString()),
                            TextButton(
                              onPressed: () => _fetchEpisodes(context),
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
        ),
      ),
    );
  }

  void _fetchEpisodes(BuildContext context) {
    context.read<CharacterDetailsBloc>().add(
          CharactersDetailsGet(characterId: characterId),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterDetailsBloc, CharacterDetailsState>(
      bloc: context.read<CharacterDetailsBloc>()
        ..add(
          CharactersDetailsGet(characterId: characterId),
        ),
      builder: (_, state) => Scaffold(
        appBar: state.status != CharacterDetailsStatus.success
            ? null
            : AppBar(
                title: Text(state.characterDetails?.name ?? ''),
              ),
        body: state.status == CharacterDetailsStatus.initial
            ? const Center(child: CircularProgressIndicator())
            : state.status == CharacterDetailsStatus.success
                ? SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Hero image (use same name tag as card)
                        Hero(
                          tag: state.characterDetails?.name ?? '',
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              state.characterDetails?.image ?? '',
                              loadingBuilder: (context, widget, chunk) {
                                bool loaded =
                                    ((chunk?.cumulativeBytesLoaded ?? 1) ==
                                        (chunk?.expectedTotalBytes ?? 1));

                                return Center(
                                  child: loaded
                                      ? widget
                                      : const CircularProgressIndicator(),
                                );
                              },
                              fit: BoxFit.cover,
                              height: 200.0,
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ), // Spacing between image and details

                        // Details section

                        _buildDetailsRow(
                          context,
                          'Status: ${state.characterDetails?.status ?? ''}',
                        ),
                        _buildDetailsRow(
                          context,
                          'Species: ${state.characterDetails?.species ?? ''}',
                        ),
                        _buildDetailsRow(
                          context,
                          'Origin: ${state.characterDetails?.origin.name ?? ''}',
                        ),

                        _buildDetailsRow(
                          context,
                          'Last location:  ${state.characterDetails?.location.name ?? ''}',
                        ),
                        const SizedBox(height: 16.0), // Spacing before episodes

                        // Episode section title (Netflix font style)
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Episodes',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        (state.characterDetails?.episode.isNotEmpty ?? true)
                            ? GridView.count(
                                physics:
                                    const NeverScrollableScrollPhysics(), // Disable scrolling
                                shrinkWrap: true,
                                crossAxisCount: 2,
                                childAspectRatio: 0.9,
                                mainAxisSpacing: 8.0,
                                crossAxisSpacing: 8.0,
                                children: state.characterDetails?.episode
                                        .map(
                                          (episodeUrl) => _buildEpisodeCard(
                                              context, episodeUrl),
                                        )
                                        .toList() ??
                                    [],
                              )
                            : const Text('No episodes found'),
                      ],
                    ),
                  )
                : Center(
                    child: Column(
                      children: [
                        Text(state.message ?? ''),
                        TextButton(
                          onPressed: () => _fetchEpisodes(context),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}
