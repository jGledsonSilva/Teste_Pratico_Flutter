// import '../dtos/client_dto.dart';
import 'package:listagem_de_itens/dtos/iten_dto.dart';
import '../entities/item_entity.dart';

class ItemAdapter {
  ItemAdapter._();

  static ItemEntity fromMap(dynamic map) {
    return ItemEntity(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      image: map['image'] ?? '',
      description: map['description'] ?? '',
    );
  }

  static ItemDto entityToDTO(ItemEntity model) {
    return ItemDto(
      id: model.id,
      title: model.title,
      image: model.image,
      description: model.description,
    );
  }

  static Map<String, dynamic> entityToMap(ItemEntity model) {
    return {
      'id': model.id,
      'title': model.title,
      'image': model.image,
      'description': model.description,
    };
  }

  static Map<String, dynamic> dtoToMap(ItemDto model) {
    return {
      'id': model.id,
      'title': model.title,
      'image': model.image,
      'description': model.description,
    };
  }
}
