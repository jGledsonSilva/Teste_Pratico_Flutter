import 'package:flutter/material.dart';
import 'package:listagem_de_itens/entities/item_entity.dart';

TextEditingController title = TextEditingController();
TextEditingController description = TextEditingController();
TextEditingController image = TextEditingController();

List<ItemEntity> task = [];
bool loaded = false;
bool editpressed = false;
int this_id = 0;
