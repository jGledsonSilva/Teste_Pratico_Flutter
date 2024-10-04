// ignore: file_names
import 'package:listagem_de_itens/dtos/iten_validate_mixin.dart';
import 'package:listagem_de_itens/services/string_generator.dart';

import 'dto.dart';


class ItemDto extends DTO with ItemValidate {
  late String id;
  late String title;
  late String image;
  late String description;

  ItemDto({
    String? id,
    required this.title,
    required this.image,
    required this.description,
  }) {
    this.id = id ?? stringGenerator();
  }

  ItemDto copy() {
    return ItemDto(
      id: id,
      title: title,
      image: image,
      description: description,
    );
  }

  @override
  void validate() {
    titleValidate(title);
    descricaoValidate(description);
    imageValidate(image);
  }
}
