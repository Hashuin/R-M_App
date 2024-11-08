import 'package:flutter/material.dart';
import '../../domain/models/character_model.dart';

class CharacterWidget extends StatelessWidget {
  final Character character;

  CharacterWidget({required this.character});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(character.image),
      title: Text(character.name),
      subtitle: Text('Status: ${character.status}\nSpecies: ${character.species}'),
    );
  }
}
