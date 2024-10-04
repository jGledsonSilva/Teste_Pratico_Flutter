// import '../adapters/intem_adapter.dart';
// import '../dtos/inten_dto.dart';
// import '../entities/inten_entity.dart';
// import 'http_client_service.dart';

// class ClientService {
//   final HttpClientService client;

//   ClientService(this.client);

//   Future<List<IntenEntity>> fetchClients() async {
//     final response = await client.get('http://127.0.0.1:3031/clients');
//     return (response as List).map(IntenAdapter.fromMap).toList();
//   }

//   Future<void> createClient(IntenDto dto) async {
//     final data = IntenAdapter.dtoToMap(dto);
//     await client.post('http://localhost:3031/clients', data);
//   }

//   Future<void> updateClient(IntenDto dto) async {
//     final data = IntenAdapter.dtoToMap(dto);
//     await client.put('http://127.0.0.1:3031/clients/${dto.id}', data);
//   // // }

//   Future<void> deleteClient(String id) async {
//     await client.delete('http://127.0.0.1:3031/clients/$id');
//   }
// }
