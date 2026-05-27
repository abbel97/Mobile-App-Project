import '../entities/professional_entity.dart';

abstract class ProfessionalRepository {
	Future<List<ProfessionalEntity>> getProfessionals();

	Future<ProfessionalEntity> getProfessional(String professionalId);

	Future<ProfessionalEntity> getMyProfile();

	Future<ProfessionalEntity> updateMyProfile({
		required String name,
		required String email,
		required String profession,
		required String bio,
		required String location,
		required int experienceYears,
		required double serviceRate,
		required String educationLevel,
	});
}
