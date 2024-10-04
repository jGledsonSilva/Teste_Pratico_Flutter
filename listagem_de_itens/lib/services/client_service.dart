// import 'package:teste_pratico/adapters/intem_adapter.dart';
// import 'package:teste_pratico/dtos/inten_dto.dart';
// import 'package:teste_pratico/entities/inten_entity.dart';
// import 'local_storage_service.dart'; // Novo serviço

// class ClientService {
//   final LocalStorageService storage;

//   ClientService(this.storage);

//   Future<List<IntenEntity>> fetchClients() async {
//     try {
//       final response = await storage.getClients();
//       return response.map(IntenAdapter.fromMap).toList();
//     } catch (e) {
//       print('Failed to fetch clients: $e');
//       rethrow;
//     }
//   }

//   Future<void> createClient(IntenDto dto) async {
//     try {
//       final data = IntenAdapter.dtoToMap(dto);
//       await storage.saveClient(data);
//     } catch (e) {
//       print('Failed to create client: $e');
//       rethrow;
//     }
//   }

//   Future<void> updateClient(IntenDto dto) async {
//     try {
//       final data = IntenAdapter.dtoToMap(dto);
//       await storage.updateClient(data);
//     } catch (e) {
//       print('Failed to update client: $e');
//       rethrow;
//     }
//   }

//   Future<void> deleteClient(String id) async {
//     try {
//       await storage.deleteClient(id);
//     } catch (e) {
//       print('Failed to delete client: $e');
//       rethrow;
//     }
//   }
// }
