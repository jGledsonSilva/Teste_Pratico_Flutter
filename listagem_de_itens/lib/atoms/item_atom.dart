import 'package:flutter/material.dart';
import 'package:listagem_de_itens/dtos/iten_dto.dart';

import '../states/item_state.dart';
import '../states/edit_item.dart';

// Atom
final itemState = ValueNotifier<ItemState>(const StartItemState());
final edititemState = ValueNotifier<ItemEditState>(const StartEditItemState());

// Actions
final fetchItemsAction = ValueNotifier(Object());
final createItemAction = ValueNotifier<ItemDto>(ItemDto(title: '', image: '', description: ''));
final updateItemAction = ValueNotifier<ItemDto>(ItemDto(title: '', image: '', description: ''));
final deleteItemAction = ValueNotifier<String>('');
