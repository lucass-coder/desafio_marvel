import 'package:desafio_marvel/modules/characters/domain/entities/chacacter_entity.dart';

class CharacterModel extends CharacterEntity {
  const CharacterModel({
    required super.id,
    required super.name,
    required super.description,
    required super.thumbnailUrl,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    final thumbnail = json['thumbnail'];
    final path = thumbnail['path'];
    final extension = thumbnail['extension'];
    final thumbnailUrl = '$path.$extension';

    return CharacterModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      thumbnailUrl: thumbnailUrl,
    );
  }

  static List<CharacterModel> fromList(List<dynamic> list) {
    return list.map((item) => CharacterModel.fromJson(item)).toList();
  }
}
