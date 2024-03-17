import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:jombay_assignment_pranad/features/character_details/data/repository/characters_details_repository.dart';
import 'bloc_observer.dart';
import 'core/dependencies/characters_container.dart' as character_container;
import 'core/dependencies/characters_details_container.dart'
    as character_details_container;
import 'core/dependencies/http_container.dart' as http_container;
import 'features/character_details/view_model/character_details_bloc.dart';
import 'features/character_details/views/character_details_view.dart';
import 'features/characters/data/repositories/characters_repository.dart';
import 'features/characters/view_model/characters_bloc.dart';
import 'home.dart';
import 'themes.dart';

void main() {
  Bloc.observer = const SimpleBlocObserver();

  /// init http dependencies
  http_container.init();

  /// init Characters dependencies
  character_container.init();

  /// init character details dependencies
  character_details_container.init();

  runApp(const RickAndMortyCharactersApp());
}

class RickAndMortyCharactersApp extends StatelessWidget {
  const RickAndMortyCharactersApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CharactersBloc>(
      create: (_) => CharactersBloc(
        charactersRepository: GetIt.instance<CharactersRepository>(),
      )..add(CharactersGet()),
      child: MaterialApp(
        theme: RickAndMortyCharactersAppTheme.darkTheme,
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/characterDetails':
              return MaterialPageRoute(
                builder: (context) => BlocProvider<CharacterDetailsBloc>(
                  create: (_) => CharacterDetailsBloc(
                    charactersDetailsRepository:
                        GetIt.instance<CharactersDetailsRepository>(),
                  ),
                  child: CharacterDetailsView(
                    characterId: (settings.arguments
                            as Map<String, int>)['characterId'] ??
                        -1,
                  ),
                ),
              );

            default:
              return MaterialPageRoute(
                builder: (context) => const RickAndMortyCharactersHome(),
              );
          }
        },
      ),
    );
  }
}
