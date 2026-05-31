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
          .map((e) => ProfessionalModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    throw ServerFailure(_msg(res.body));
  }

  Future<ProfessionalModel> getProfessional(String id) async {
    final res = await ApiClient.get('/professionals/$id');
    if (res.statusCode == 200) {
      return ProfessionalModel.fromJson(
          jsonDecode(res.body) as Map<String, dynamic>);
    }
    if (res.statusCode == 404) {
      throw const NotFoundFailure('Professional not found');
    }
    throw ServerFailure(_msg(res.body));
  }

  Future<ProfessionalModel> getMyProfile() async {
    final res = await ApiClient.get('/professionals/me');
    if (res.statusCode == 200) {
      return ProfessionalModel.fromJson(
          jsonDecode(res.body) as Map<String, dynamic>);
    }
    throw ServerFailure(_msg(res.body));
  }

  Future<ProfessionalModel> updateProfessional({
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
    final res = await ApiClient.put('/professionals/$id', {
      if (name != null)             'name':             name,
      if (profession != null)       'profession':       profession,
      if (bio != null)              'bio':              bio,
      if (location != null)         'location':         location,
      if (experienceYears != null)  'experience_years': experienceYears,
      if (serviceRate != null)      'service_rate':     serviceRate,
      if (educationLevel != null)   'education_level':  educationLevel,
      if (skills != null)          'skills':           skills,
      if (photoBase64 != null)     'photo_base64':     photoBase64
    });
    if (res.statusCode == 200) {
      return ProfessionalModel.fromJson(
          jsonDecode(res.body) as Map<String, dynamic>);
    }
    throw ServerFailure(_msg(res.body));
  }

  Future<void> deleteProfessional(String id) async {
    final res = await ApiClient.delete('/professionals/$id');
    if (res.statusCode != 200) throw ServerFailure(_msg(res.body));
  }

  String _msg(String body) {
    try {
      return (jsonDecode(body) as Map<String, dynamic>)['message']
              as String? ??
          'Server error';
    } catch (e) {
      return 'Server error';
    }
  }
}