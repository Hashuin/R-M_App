import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../domain/models/character_model.dart';
import '../graphql_config.dart';
import 'characters_query.dart';

class CharactersResponse {
  final List<Character> characters;
  final int totalCount;

  CharactersResponse({required this.characters, required this.totalCount});
}

class CharactersRequest {
  final String query;
  final int page;

  CharactersRequest({required this.query, required this.page});
}

final charactersProvider = FutureProvider.autoDispose.family<CharactersResponse, CharactersRequest>((ref, request) async {
  final client = GraphQLConfig().initializeClient().value;

  final result = await client.query(QueryOptions(
    document: gql(fetchCharacters),
    variables: {'page': request.page, 'name': request.query},
  ));

  if (result.hasException) {
    throw result.exception!;
  }

  final charactersData = result.data?['characters']['results'] as List;
  final totalCount = result.data?['characters']['info']['count'] as int;

  final characters = charactersData.map((character) => Character.fromJson(character)).toList();

  return CharactersResponse(characters: characters, totalCount: totalCount);
});