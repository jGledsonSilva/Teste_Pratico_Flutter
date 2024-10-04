import 'package:flutter/material.dart';
import 'package:listagem_de_itens/entities/item_entity.dart';
import 'package:listagem_de_itens/pages/edit_item_page.dart';
import 'package:listagem_de_itens/pages/item_page.dart';

void main() {
  runApp(const MainApp());
}

// class RootWidget extends StatefulWidget {
//   const RootWidget({super.key});

//   @override
//   State<RootWidget> createState() => _RootWidgetState();
// }

// class _RootWidgetState extends State<RootWidget> {
//   final httpClient = HttpClient();
//   late final httpClientService = HttpClientService(httpClient);
//   late final clientService = ClientService(httpClientService);
//   late final reducer;

//   @override
//   void initState() {
//     super.initState();
//     reducer = ClientReducer(clientService);
//   }

//   @override
//   void dispose() {
//     reducer.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const MainApp();
//   }
// }

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (_) => const ItemPage(),
        '/create': (_) => const EditItemPage(),
        '/edit': (context) {
          final entity =
              ModalRoute.of(context)?.settings.arguments as ItemEntity?;
          return EditItemPage(entity: entity);
        },
      },
    );
  }
}
