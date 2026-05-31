import '../../domain/entities/professional_entity.dart';

class ProfessionalModel extends ProfessionalEntity {
  const ProfessionalModel({
    required super.id,
    required super.userId,
    required super.name,
    required super.email,
    required super.profession,
    super.bio,
    super.location,
    required super.experienceYears,
    required super.serviceRate,
    super.educationLevel,
    required super.createdAt,
    required super.updatedAt,
    required super.skills,
    super.photoBase64,
  });

  factory ProfessionalModel.fromJson(Map<String, dynamic> j) =>
      ProfessionalModel(
        id:              j['id']               as String,
        userId:          j['user_id']          as String,
        name:            j['name']             as String,
        email:           j['email']            as String,
        profession:      j['profession']       as String,
        bio:             j['bio']              as String?,
        location:        j['location']         as String?,
        experienceYears: (j['experience_years'] as num?)?.toInt()    ?? 0,
        serviceRate:     (j['service_rate']     as num?)?.toDouble() ?? 0.0,
        educationLevel:  j['education_level']  as String?,
        createdAt:       j['created_at']       as String,
        updatedAt:       j['updated_at']       as String,
        skills:      _parseSkills(j['skills'] as String?),
        photoBase64: j['photo_base64'] as String?,
      );

  factory ProfessionalModel.fromDb(Map<String, dynamic> m) =>
      ProfessionalModel(
        id:              m['id']               as String,
        userId:          m['user_id']          as String,
        name:            m['name']             as String,
        email:           m['email']            as String,
        profession:      m['profession']       as String,
        bio:             m['bio']              as String?,
        location:        m['location']         as String?,
        experienceYears: (m['experience_years'] as num?)?.toInt()    ?? 0,
        serviceRate:     (m['service_rate']     as num?)?.toDouble() ?? 0.0,
        educationLevel:  m['education_level']  as String?,
        createdAt:       m['created_at']       as String,
        updatedAt:       m['updated_at']       as String,
        skills:      _parseSkills(m['skills'] as String?),
        photoBase64: m['photo_base64'] as String?,
      );

  Map<String, dynamic> toDb() => {
    'id':               id,
    'user_id':          userId,
    'name':             name,
    'email':            email,
    'profession':       profession,
    'bio':              bio,
    'location':         location,
    'experience_years': experienceYears,
    'service_rate':     serviceRate,
    'education_level':  educationLevel,
    'created_at':       createdAt,
    'updated_at':       updatedAt,
    'skills':           skills.join(','),
    'photo_base64':     photoBase64,
  };

  static List<String> _parseSkills(String? raw) {
  if (raw == null || raw.isEmpty) return [];
  return raw.split(',').map((s) => s.trim()).where((s) => s.isNotEmpty).toList();
}

}

