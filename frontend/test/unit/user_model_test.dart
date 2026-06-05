import 'package:flutter_test/flutter_test.dart';
import 'package:home_tweak/features/auth/data/models/user_model.dart';

void main() {
  final json = {
    'id':         'user-1',
    'name':       'Abebe Kebede',
    'email':      'abebe@test.com',
    'role':       'customer',
    'location':   'Addis Ababa',
    'created_at': '2024-01-01T00:00:00.000Z',
  };

  group('UserModel.fromJson', () {
    test('parses standard fields', () {
      final model = UserModel.fromJson(json);
      expect(model.id,    'user-1');
      expect(model.name,  'Abebe Kebede');
      expect(model.email, 'abebe@test.com');
      expect(model.role,  'customer');
    });

    test('sets token from named parameter', () {
      final model = UserModel.fromJson(json, token: 'jwt-token-123');
      expect(model.token, 'jwt-token-123');
    });

    test('handles missing photo_base64 gracefully', () {
      final model = UserModel.fromJson(json);
      expect(model.photoBase64, isNull);
    });

    test('isCustomer and isProfessional reflect role', () {
      final custModel = UserModel.fromJson(json);
      final profModel = UserModel.fromJson({...json, 'role': 'professional'});
      expect(custModel.isCustomer,     true);
      expect(profModel.isProfessional, true);
    });
  });

  group('UserModel.toDb', () {
    test('includes token field', () {
      final model = UserModel.fromJson(json, token: 'abc');
      final db    = model.toDb();
      expect(db['token'], 'abc');
      expect(db['id'],    'user-1');
    });
  });
}