import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../infrastructure/adapters/character_provider.dart';
abstract class CharacterPort {
  Future<CharactersResponse> getCharacters(int page, String query);
}