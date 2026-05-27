import '../../domain/entities/professional_entity.dart';
import '../../domain/repositories/professional_repository.dart';
import '../datasources/professional_remote_datasource.dart';

class ProfessionalRepositoryImpl implements ProfessionalRepository {
	final ProfessionalRemoteDataSource _remote;

	ProfessionalRepositoryImpl() : _remote = ProfessionalRemoteDataSource();

	@override
	Future<List<ProfessionalEntity>> getProfessionals() {
		return _remote.getProfessionals();
	}

	@override
	Future<ProfessionalEntity> getProfessional(String professionalId) {
		return _remote.getProfessional(professionalId);
	}

	@override
	Future<ProfessionalEntity> getMyProfile() {
		return _remote.getMyProfile();
	}

	@override
	Future<ProfessionalEntity> updateMyProfile({
		required String name,
		required String email,
		required String profession,
		required String bio,
		required String location,
		required int experienceYears,
		required double serviceRate,
		required String educationLevel,
	}) {
		return _remote.updateMyProfile(
			name: name,
			email: email,
			profession: profession,
			bio: bio,
			location: location,
			experienceYears: experienceYears,
			serviceRate: serviceRate,
			educationLevel: educationLevel,
		);
	}
}
