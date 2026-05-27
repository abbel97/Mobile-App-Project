import '../entities/service_request_entity.dart';

abstract class ServiceRequestRepository {
  Future<List<ServiceRequestEntity>> getRequests();
  Future<List<ServiceRequestEntity>> refreshRequests();
  Future<ServiceRequestEntity> createRequest({
    required String title,
    required String description,
    required String profession,
    required String location,
    String urgency,
  });
  Future<ServiceRequestEntity> updateRequest({
    required String id,
    String? title,
    String? description,
    String? profession,
    String? location,
    String? urgency,
  });
  Future<void> deleteRequest(String id);
  Future<ServiceRequestEntity> acceptRequest(String id);
}