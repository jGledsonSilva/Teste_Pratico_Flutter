import 'package:listagem_de_itens/entities/item_entity.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

const key = 'todo_list';

class SharedPreferencesService {

  Future<List<ItemEntity>> getList() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    final jsonString = sf.getString(key) ?? '[]';
    final jsonDecoded = json.decode(jsonString) as List;

    return jsonDecoded
        .map(
          (e) => ItemEntity.fromJson(e as Map<String, dynamic>),
        )
        .toList();
  }

  //save list
  void saveList(List<ItemEntity> todos) async {
    final stringJson = json.encode(todos);
    SharedPreferences sf = await SharedPreferences.getInstance();
    sf.setString(key, stringJson);
  }

  //update List
  void updateList(List<ItemEntity> todos, int id, String title, String image,
      String description) async {
    for (var i in todos) {
      if (i.id == id) {
        i.title = title;
        i.image = image;
        i.description = description;
      }
    }
    saveList(todos);
  }
}
