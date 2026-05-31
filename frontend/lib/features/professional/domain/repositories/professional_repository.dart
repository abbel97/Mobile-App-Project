import '../entities/professional_entity.dart';

abstract class ProfessionalRepository {
  Future<List<ProfessionalEntity>> getProfessionals();
  Future<List<ProfessionalEntity>> refreshProfessionals();
  Future<ProfessionalEntity>       getProfessional(String id);
  Future<ProfessionalEntity>       getMyProfile();
  Future<ProfessionalEntity>       updateProfessional({
    required String id,
    String? name,
    String? profession,
    String? bio,
    String? location,
    int?    experienceYears,
    double? serviceRate,
    String? educationLevel,
  });
  Future<void> deleteProfessional(String id);
}