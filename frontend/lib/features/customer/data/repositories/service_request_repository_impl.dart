import '../../domain/entities/service_request_entity.dart';
import '../../domain/repositories/service_request_repository.dart';
import '../datasources/service_request_local_datasource.dart';
import '../datasources/service_request_remote_datasource.dart';
//import '../models/service_request_model.dart';

class ServiceRequestRepositoryImpl implements ServiceRequestRepository {
  final ServiceRequestRemoteDataSource _remote;
  final ServiceRequestLocalDataSource  _local;

  ServiceRequestRepositoryImpl() :
   _remote = ServiceRequestRemoteDataSource(),
   _local  = ServiceRequestLocalDataSource();

  @override
  Future<List<ServiceRequestEntity>> getRequests() async {
    try {
      final remote = await _remote.getRequests();
      await _local.clearAll();
      await _local.saveRequests(remote);
      return remote;
    } catch (_) {
      final cached = await _local.getRequests();
      if (cached.isNotEmpty) return cached;
      rethrow;
    }
  }

  @override
  Future<List<ServiceRequestEntity>> refreshRequests() async {
    final remote = await _remote.getRequests();
    await _local.clearAll();
    await _local.saveRequests(remote);
    return remote;
  }

  @override
  Future<ServiceRequestEntity> createRequest({
    required String title,
    required String description,
    required String profession,
    required String location,
    String urgency = 'regular',
    String? photoBase64,
  }) async {
    final r = await _remote.createRequest(
      title: title, description: description,
      profession: profession, location: location,
      urgency: urgency, photoBase64: photoBase64,
    );
    await _local.saveRequest(r);
    return r;
  }

  @override
  Future<ServiceRequestEntity> updateRequest({
    required String id,
    String? title, String? description,
    String? profession, String? location, String? urgency,
  }) async {
    final r = await _remote.updateRequest(
      id: id, title: title, description: description,
      profession: profession, location: location, urgency: urgency,
    );
    await _local.saveRequest(r);
    return r;
  }

  Future<ServiceRequestEntity> applyRequest(String id) async {
  final r = await _remote.applyRequest(id);
  await _local.saveRequest(r);
  return r;
  }

  Future<ServiceRequestEntity> confirmRequest({
    required String id,
    required String customerPhone,
  }) async {
    final r = await _remote.confirmRequest(id: id, customerPhone: customerPhone);
    await _local.saveRequest(r);
    return r;
  }

  Future<ServiceRequestEntity> rejectApplicant(String id) async {
    final r = await _remote.rejectApplicant(id);
    await _local.saveRequest(r);
    return r;
  }

  @override
  Future<void> deleteRequest(String id) async {
    await _remote.deleteRequest(id);
    await _local.deleteRequest(id);
  }

  @override
  Future<ServiceRequestEntity> acceptRequest(String id) async {
    final r = await _remote.acceptRequest(id);
    await _local.saveRequest(r);
    return r;
  }
}