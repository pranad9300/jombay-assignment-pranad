import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../../../core/error/failures.dart';
import '../../../../core/network/endpoints.dart';
import '../../../../shared/data/models/character_model.dart';
import '../models/episode.dart';

class CharacterDetailsRemoteDataSource {
  final http.Client client;

  const CharacterDetailsRemoteDataSource({
    required this.client,
  });

  Future<Character> getCharactersDetails({
    required int characterId,
  }) async {
    try {
      // get character endpoints
      Uri charactersApiEndpoint =
          Uri.parse('${Endpoints.characterBaseUrl}/$characterId');

      // make api requests
      http.Response response = await client.get(charactersApiEndpoint);

      if (response.statusCode == 200) {
        // get response body
        Map<String, dynamic> responseBody = json.decode(response.body);

        // parse response body and return [CharactersResponse]
        return Character.fromMap(responseBody);
      }

      // throw http status code when api call failed.
      throw response.statusCode;
    } on SocketException catch (_) {
      throw NoInternetFailure();
    } catch (e) {
      throw HttpFailure(message: 'Something went wrong, please try again.');
    }
  }

  Future<Episode> _getEpisodeInfo(
    String episodeInfo,
  ) async {
    try {
      // get character endpoints
      Uri charactersApiEndpoint = Uri.parse(episodeInfo);

      // make api requests
      http.Response response = await client.get(charactersApiEndpoint);

      if (response.statusCode == 200) {
        // get response body
        Map<String, dynamic> responseBody = json.decode(response.body);

        // parse response body and return [CharactersResponse]
        return Episode.fromMap(responseBody);
      }

      // throw http status code when api call failed.
      throw response.statusCode;
    } on SocketException catch (_) {
      throw NoInternetFailure();
    } catch (e) {
      throw HttpFailure(message: 'Something went wrong, please try again.');
    }
  }

  Future<Episode> computeEpisodeInfo({
    required String episodeUrl,
  }) async =>
      await _getEpisodeInfo(
        episodeUrl,
      );
}
