import 'dart:convert';

List<ItemEntity> postModelFromJson(String str) =>
    List<ItemEntity>.from(json.decode(str).map((x) => ItemEntity.fromJson(x)));

String postModelToJson(List<ItemEntity> data) =>
    json.encode(List<dynamic>.from(data.map((e) => e.toJson())));

class ItemEntity {
  ItemEntity({
    required this.id,
    required this.title,
    required this.image,
    required this.description,
  });
  int id;
  String title;
  String image;
  String description;

  factory ItemEntity.fromJson(Map<String, dynamic> json) => ItemEntity(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      description: json['description']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "description": description,
      };

  
}
