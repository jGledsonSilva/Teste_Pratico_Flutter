sealed class ItemEditState {
  const ItemEditState();
}

class StartEditItemState extends ItemEditState {
  const StartEditItemState();
}

class SavedItemState extends ItemEditState {
  const SavedItemState();
}

class LoadingEditItemState extends ItemEditState {
  const LoadingEditItemState();
}

class FailureEditItemState extends ItemEditState {
  final String message;
  const FailureEditItemState(this.message);
}
