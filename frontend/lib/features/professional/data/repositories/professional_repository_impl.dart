import '../../domain/entities/professional_entity.dart';
import '../../domain/repositories/professional_repository.dart';
import '../datasources/professional_local_datasource.dart';
import '../datasources/professional_remote_datasource.dart';


class ProfessionalRepositoryImpl implements ProfessionalRepository {
  final ProfessionalRemoteDataSource _remote;
  final ProfessionalLocalDataSource  _local;

  ProfessionalRepositoryImpl()
      : _remote = ProfessionalRemoteDataSource(),
        _local  = ProfessionalLocalDataSource();

  @override
  Future<List<ProfessionalEntity>> getProfessionals() async {
    try {
      final remote = await _remote.getProfessionals();
      await _local.clearAll();
      await _local.saveProfessionals(remote);
      return remote;
    } catch (_) {
      final cached = await _local.getProfessionals();
      if (cached.isNotEmpty) return cached;
      rethrow;
    }
  }

  @override
  Future<List<ProfessionalEntity>> refreshProfessionals() async {
    final remote = await _remote.getProfessionals();
    await _local.clearAll();
    await _local.saveProfessionals(remote);
    return remote;
  }

  @override
  Future<ProfessionalEntity> getProfessional(String id) async {
    try {
      final remote = await _remote.getProfessional(id);
      await _local.saveProfessional(remote);
      return remote;
    } catch (_) {
      final cached = await _local.getProfessional(id);
      if (cached != null) return cached;
      rethrow;
    }
  }

  @override
  Future<ProfessionalEntity> getMyProfile() async {
    try {
      final remote = await _remote.getMyProfile();
      await _local.saveProfessional(remote);
      return remote;
    } catch (_) {
      throw Exception('Failed to load profile');
    }
  }

  @override
  Future<ProfessionalEntity> updateProfessional({
    required String id,
    String? name,
    String? profession,
    String? bio,
    String? location,
    int?    experienceYears,
    double? serviceRate,
    String? educationLevel,
    String? skills,
    String? photoBase64,
  }) async {
    final r = await _remote.updateProfessional(
      id: id, name: name, profession: profession,
      bio: bio, location: location,
      experienceYears: experienceYears,
      serviceRate: serviceRate, educationLevel: educationLevel,
      skills: skills, photoBase64: photoBase64,
    );
    await _local.saveProfessional(r);
    return r;
  }

  @override
  Future<void> deleteProfessional(String id) async {
    await _remote.deleteProfessional(id);
    await _local.deleteProfessional(id);
  }
}