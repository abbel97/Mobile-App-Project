import 'package:equatable/equatable.dart';

class ProfessionalEntity extends Equatable {
  final String  id;
  final String  userId;
  final String  name;
  final String  email;
  final String  profession;
  final String? bio;
  final String? location;
  final int     experienceYears;
  final double  serviceRate;
  final String? educationLevel;
  final String  createdAt;
  final String  updatedAt;
  final List<String> skills;
  final String? photoBase64;

  const ProfessionalEntity({
    required this.id,
    required this.userId,
    required this.name,
    required this.email,
    required this.profession,
    this.bio,
    this.location,
    required this.experienceYears,
    required this.serviceRate,
    this.educationLevel,
    required this.createdAt,
    required this.updatedAt,
    required this.skills,
    this.photoBase64,
  });

  @override
  List<Object?> get props => [id, userId];
}