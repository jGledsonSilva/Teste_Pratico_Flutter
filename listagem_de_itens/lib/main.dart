import 'package:flutter/material.dart';
import 'package:listagem_de_itens/pages/edit_item_page.dart';
import 'package:listagem_de_itens/pages/item_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (_) => const ItemPage(),
        '/create': (_) => const EditItemPage(),
      },
    );
  }
}
