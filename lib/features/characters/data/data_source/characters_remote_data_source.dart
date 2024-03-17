import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../../../core/error/failures.dart';
import '../../../../core/network/endpoints.dart';
import '../model/characters_response_model.dart';

class CharactersRemoteDataSources {
  final http.Client client;

  const CharactersRemoteDataSources({required this.client});

  Future<CharactersResponse> getCharacters({
    String? characterNextPageUrl,
  }) async {
    try {
      // get character endpoints
      Uri charactersApiEndpoint =
          Uri.parse(characterNextPageUrl ?? Endpoints.characterBaseUrl);

      // make api requests
      http.Response response = await client.get(charactersApiEndpoint);

      if (response.statusCode == 200) {
        // get response body
        Map<String, dynamic> responseBody = json.decode(response.body);

        // parse response body and return [CharactersResponse]
        return CharactersResponse.fromMap(responseBody);
      }

      // throw http status code when api call failed.
      throw response.statusCode;
    } on SocketException catch (_) {
      throw NoInternetFailure();
    } catch (e) {
      throw HttpFailure(message: 'Something went wrong, please try again.');
    }
  }

  Future<String> _getCharactersFirstAppearanceEpisodeName(
    String firstEpisodeUrl,
  ) async {
    try {
      // get charactersFirstEpisode endpoints
      Uri charactersFirstEpisode = Uri.parse(firstEpisodeUrl);

      // make api requests
      http.Response response = await client.get(charactersFirstEpisode);

      if (response.statusCode == 200) {
        // get response body
        Map<String, dynamic> responseBody = json.decode(response.body);

        // return first appearance name;
        return responseBody['name'];
      }

      // throw http status code when api call failed.
      throw response.statusCode;
    } on SocketException catch (_) {
      throw NoInternetFailure();
    } catch (e) {
      throw HttpFailure(message: 'Something went wrong, please try again.');
    }
  }

  Future<String> computeCharactersFirstAppearanceEpisodeName(
    String firstEpisodeUrl,
  ) async =>
      await _getCharactersFirstAppearanceEpisodeName(firstEpisodeUrl);
}
