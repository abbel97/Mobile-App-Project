import '../../domain/entities/professional_entity.dart';

class ProfessionalModel extends ProfessionalEntity {
	const ProfessionalModel({
		required super.id,
		required super.userId,
		required super.name,
		required super.email,
		required super.profession,
		required super.bio,
		required super.location,
		required super.experienceYears,
		required super.serviceRate,
		required super.educationLevel,
		required super.createdAt,
		required super.updatedAt,
	});

	factory ProfessionalModel.fromJson(Map<String, dynamic> json) {
		return ProfessionalModel(
			id: json['id'] as String,
			userId: json['user_id'] as String,
			name: json['name'] as String,
			email: json['email'] as String,
			profession: json['profession'] as String,
			bio: json['bio'] as String? ?? '',
			location: json['location'] as String? ?? '',
			experienceYears: (json['experience_years'] as num?)?.toInt() ?? 0,
			serviceRate: (json['service_rate'] as num?)?.toDouble() ?? 0,
			educationLevel: json['education_level'] as String? ?? '',
			createdAt: json['created_at'] as String,
			updatedAt: json['updated_at'] as String? ?? json['created_at'] as String,
		);
	}
}
