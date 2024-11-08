import '../domain/ports/character_port.dart';
import '../infrastructure/adapters/character_provider.dart';


class CharacterService {
  final CharacterPort characterPort;

  CharacterService({required this.characterPort});

  Future<CharactersResponse> getCharacters(int page, String query) {
    return characterPort.getCharacters(page, query);
  }
}