import '../../domain/models/character_model.dart';
import '../../domain/ports/character_port.dart';
import 'character_provider.dart';
import 'characters_query.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLCharacterService implements CharacterPort {
  final GraphQLClient client;

  GraphQLCharacterService(this.client);

  @override
  Future<CharactersResponse> getCharacters(int page, String query) async {
    final result = await client.query(QueryOptions(
      document: gql(fetchCharacters),
      variables: {'page': page, 'name': query},
    ));

    if (result.hasException) {
      throw result.exception!;
    }

    final charactersData = result.data?['characters']['results'] as List;
    final totalCount = result.data?['characters']['info']['count'] as int;

    final characters = charactersData.map((character) => Character.fromJson(character)).toList();

    return CharactersResponse(characters: characters, totalCount: totalCount);
  }
}