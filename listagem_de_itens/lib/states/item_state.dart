import 'package:listagem_de_itens/entities/item_entity.dart';

sealed class ItemState {
  const ItemState();
}

class StartItemState extends ItemState {
  const StartItemState();
}

class GettedItemState extends ItemState {
  final List<ItemEntity> intens;

  const GettedItemState(this.intens);
}

class LoadingItemState extends ItemState {
  const LoadingItemState();
}

class FailureItemState extends ItemState {
  final String message;
  const FailureItemState(this.message);
}
