import 'package:freezed_annotation/freezed_annotation.dart';
import 'origin_model.dart';
import 'location_model.dart';

part 'character_model.freezed.dart';
part 'character_model.g.dart';

@freezed
class Character with _$Character {
  const factory Character({
    required String id,
    required String name,
    required String image,
    required String status,
    required String species,
    String? type,
    String? gender,
    Origin? origin,
    Location? location,
  }) = _Character;

  factory Character.fromJson(Map<String, dynamic> json) => _$CharacterFromJson(json);
}
