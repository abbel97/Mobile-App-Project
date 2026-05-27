import 'dart:convert';

import '../../../../core/errors/failure.dart';
import '../../../../core/network/api_client.dart';
import '../models/professional_model.dart';

class ProfessionalRemoteDataSource {
	Future<List<ProfessionalModel>> getProfessionals() async {
		final res = await ApiClient.get('/professionals');
		if (res.statusCode == 200) {
			final list = jsonDecode(res.body) as List;
			return list
					.map((item) => ProfessionalModel.fromJson(item as Map<String, dynamic>))
					.toList();
		}

		throw ServerFailure(_message(res.body));
	}

	Future<ProfessionalModel> getProfessional(String professionalId) async {
		final res = await ApiClient.get('/professionals/$professionalId');
		if (res.statusCode == 200) {
			return ProfessionalModel.fromJson(jsonDecode(res.body) as Map<String, dynamic>);
		}

		throw ServerFailure(_message(res.body));
	}

	Future<ProfessionalModel> getMyProfile() async {
		final res = await ApiClient.get('/professionals/me');
		if (res.statusCode == 200) {
			return ProfessionalModel.fromJson(jsonDecode(res.body) as Map<String, dynamic>);
		}

		throw ServerFailure(_message(res.body));
	}

	Future<ProfessionalModel> updateMyProfile({
		required String name,
		required String email,
		required String profession,
		required String bio,
		required String location,
		required int experienceYears,
		required double serviceRate,
		required String educationLevel,
	}) async {
		final res = await ApiClient.put('/professionals/me', {
			'name': name,
			'email': email,
			'profession': profession,
			'bio': bio,
			'location': location,
			'experience_years': experienceYears,
			'service_rate': serviceRate,
			'education_level': educationLevel,
		});

		if (res.statusCode == 200) {
			return ProfessionalModel.fromJson(jsonDecode(res.body) as Map<String, dynamic>);
		}

		throw ServerFailure(_message(res.body));
	}

	String _message(String body) {
		try {
			final decoded = jsonDecode(body) as Map<String, dynamic>;
			return decoded['message'] as String? ?? 'Server error';
		} catch (_) {
			return 'Server error';
		}
	}
}
