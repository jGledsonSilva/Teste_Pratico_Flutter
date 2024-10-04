import 'package:flutter/material.dart';
import '../states/item_state.dart';
import '../atoms/item_atom.dart';

class ItemPage extends StatefulWidget {
  const ItemPage({super.key});

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  @override
  void initState() {
    super.initState();

    itemState.value = const StartItemState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      fetchItemsAction.value = Object();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Intens'),
      ),
      body: ListenableBuilder(
        listenable: itemState,
        builder: (context, child) {
          return switch (itemState.value) {
            StartItemState _ => const SizedBox(),
            LoadingItemState _ =>
              const Center(child: CircularProgressIndicator()),
            GettedItemState state => _gettedItem(state),
            FailureItemState state => _failure(state),
          };
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createNewIntemt,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _gettedItem(GettedItemState state) {
    final items = state.intens;
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (_, index) {
        final item = items[index];
        return ListTile(
          onTap: () {
            Navigator.of(context).pushNamed('/edit', arguments: item);
          },
          title: Text(item.title),
          subtitle: Text(item.description),
          trailing: IconButton(
            onPressed: () {
              deleteItemAction.value = item.id;
            },
            icon: const Icon(Icons.remove_circle),
          ),
        );
      },
    );
  }

  Widget _failure(FailureItemState state) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          fetchItemsAction.value = Object();
        },
        child: Text(state.message),
      ),
    );
  }

  void _createNewIntemt() {
    Navigator.of(context).pushNamed('/create');
  }
}
