// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';

// class LocalStorageService {
//   Future<List<Map<String, dynamic>>> getClients() async {
//     final prefs = await SharedPreferences.getInstance();
//     final String? clientsJson = prefs.getString('clients');
    
//     if (clientsJson != null) {
//       return List<Map<String, dynamic>>.from(jsonDecode(clientsJson));
//     } else {
//       return [];
//     }
//   }

//   Future<void> saveClients(List<Map<String, dynamic>> clients) async {
//     final prefs = await SharedPreferences.getInstance();
//     final String clientsJson = jsonEncode(clients);
//     await prefs.setString('clients', clientsJson);
//   }

//   Future<void> saveClient(Map<String, dynamic> client) async {
//     final prefs = await SharedPreferences.getInstance();
//     final String? clientsJson = prefs.getString('clients');
    
//     List<Map<String, dynamic>> clients = clientsJson != null
//         ? List<Map<String, dynamic>>.from(jsonDecode(clientsJson))
//         : [];

//     // Adiciona o novo cliente
//     clients.add(client);

//     // Salva a lista de clientes novamente
//     await prefs.setString('clients', jsonEncode(clients));
//   }

//   Future<void> deleteClient(String id) async {
//     final prefs = await SharedPreferences.getInstance();
//     final String? clientsJson = prefs.getString('clients');
    
//     if (clientsJson != null) {
//       List<Map<String, dynamic>> clients = List<Map<String, dynamic>>.from(jsonDecode(clientsJson));

//       // Remove o cliente com o ID fornecido
//       clients.removeWhere((client) => client['id'] == id);

//       // Salva a lista de clientes atualizada
//       await prefs.setString('clients', jsonEncode(clients));
//     }
//   }

//   Future<void> updateClient(Map<String, dynamic> updatedClient) async {
//     final prefs = await SharedPreferences.getInstance();
//     final String? clientsJson = prefs.getString('clients');
    
//     if (clientsJson != null) {
//       List<Map<String, dynamic>> clients = List<Map<String, dynamic>>.from(jsonDecode(clientsJson));

//       // Atualiza o cliente existente
//       int index = clients.indexWhere((client) => client['id'] == updatedClient['id']);
//       if (index != -1) {
//         clients[index] = updatedClient;
//       }

//       // Salva a lista de clientes atualizada
//       await prefs.setString('clients', jsonEncode(clients));
//     }
//   }
// }
