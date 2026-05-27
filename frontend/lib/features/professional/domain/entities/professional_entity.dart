import 'package:equatable/equatable.dart';

class ProfessionalEntity extends Equatable {
	final String id;
	final String userId;
	final String name;
	final String email;
	final String profession;
	final String bio;
	final String location;
	final int experienceYears;
	final double serviceRate;
	final String educationLevel;
	final String createdAt;
	final String updatedAt;

	const ProfessionalEntity({
		required this.id,
		required this.userId,
		required this.name,
		required this.email,
		required this.profession,
		required this.bio,
		required this.location,
		required this.experienceYears,
		required this.serviceRate,
		required this.educationLevel,
		required this.createdAt,
		required this.updatedAt,
	});

	@override
	List<Object?> get props => [
				id,
				userId,
				name,
				email,
				profession,
				bio,
				location,
				experienceYears,
				serviceRate,
				educationLevel,
				createdAt,
				updatedAt,
			];
}
