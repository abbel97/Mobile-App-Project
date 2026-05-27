import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  final String? token;

  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.role,
    required super.createdAt,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json, {String? token}) {
    return UserModel(
      id:      json['id']       as String,
      name:      json['name']       as String,
      email:     json['email']      as String,
      role:      json['role']       as String,
      createdAt: json['created_at'] as String,
      token:     token,
    );
  }

  factory UserModel.fromDb(Map<String, dynamic> map) {
    return UserModel(
      id:        map['id']         as String,
      name:      map['name']       as String,
      email:     map['email']      as String,
      role:      map['role']       as String,
      createdAt: map['created_at'] as String,
      token:     map['token']      as String?,
    );
  }

  Map<String, dynamic> toDb() => {
    'id':         id,
    'name':       name,
    'email':      email,
    'role':       role,
    'token':      token,
    'created_at': createdAt,
  };
}