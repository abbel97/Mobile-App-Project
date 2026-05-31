import 'dart:convert';
import '../../../../core/errors/failure.dart';
import '../../../../core/network/api_client.dart';
import '../models/service_request_model.dart';

class ServiceRequestRemoteDataSource {
  Future<List<ServiceRequestModel>> getRequests() async {
    final res = await ApiClient.get('/requests');
    if (res.statusCode == 200) {
      final list = jsonDecode(res.body) as List;
      return list
          .map((e) => ServiceRequestModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    throw ServerFailure(_msg(res.body));
  }

  Future<ServiceRequestModel> createRequest({
    required String title,
    required String description,
    required String profession,
    required String location,
    String urgency = 'regular',
    String? photoBase64,
  }) async {
    final res = await ApiClient.post('/requests', {
      'title': title, 'description': description,
      'profession': profession, 'location': location, 'urgency': urgency,
      if (photoBase64 != null) 'photo_base64': photoBase64,
    });
    if (res.statusCode == 201)
      return ServiceRequestModel.fromJson(jsonDecode(res.body) as Map<String, dynamic>);
    throw ServerFailure(_msg(res.body));
  }

  Future<ServiceRequestModel> updateRequest({
    required String id,
    String? title, String? description,
    String? profession, String? location, String? urgency,
  }) async {
    final res = await ApiClient.put('/requests/$id', {
      if (title != null)       'title': title,
      if (description != null) 'description': description,
      if (profession != null)  'profession': profession,
      if (location != null)    'location': location,
      if (urgency != null)     'urgency': urgency,
    });
    if (res.statusCode == 200)
      return ServiceRequestModel.fromJson(jsonDecode(res.body) as Map<String, dynamic>);
    throw ServerFailure(_msg(res.body));
  }

  Future<void> deleteRequest(String id) async {
    final res = await ApiClient.delete('/requests/$id');
    if (res.statusCode != 200) throw ServerFailure(_msg(res.body));
  }

  Future<ServiceRequestModel> acceptRequest(String id) async {
    final res = await ApiClient.put('/requests/$id/accept', {});
    if (res.statusCode == 200)
      return ServiceRequestModel.fromJson(jsonDecode(res.body) as Map<String, dynamic>);
    throw ServerFailure(_msg(res.body));
  }

  String _msg(String body) {
    try { 
      return (
        jsonDecode(body) as Map<String, dynamic>)['message'] as String? ?? 'Server error'; 
      }
    catch (e){ 
      return 'Server error'; 
      }
  }
}