import 'package:flutter_test/flutter_test.dart';
import 'package:home_tweak/features/customer/data/models/service_request_model.dart';

void main() {
  final base = {
    'id':          'req-1',
    'title':       'Fix Kitchen Sink',
    'description': 'Leaking pipe under sink',
    'profession':  'Plumber',
    'location':    'Bole, Addis Ababa',
    'status':      'pending',
    'urgency':     'regular',
    'customer_id': 'cust-1',
    'customer_name': 'Abebe Kebede',
    'created_at':  '2026-01-01T00:00:00.000Z',
    'updated_at':  '2026-01-01T00:00:00.000Z',
  };

  group('ServiceRequestModel.fromJson', () {
    test('parses all fields correctly', () {
      final model = ServiceRequestModel.fromJson(base);
      expect(model.id,           'req-1');
      expect(model.title,        'Fix Kitchen Sink');
      expect(model.profession,   'Plumber');
      expect(model.customerName, 'Abebe Kebede');
    });

    test('isPending true for pending status', () {
      final model = ServiceRequestModel.fromJson(base);
      expect(model.isPending,   true);
      expect(model.isApplied,   false);
      expect(model.isConfirmed, false);
    });

    test('isApplied true for applied status', () {
      final json  = {...base, 'status': 'applied', 'accepted_by': 'prof-1'};
      final model = ServiceRequestModel.fromJson(json);
      expect(model.isApplied,  true);
      expect(model.isPending,  false);
      expect(model.acceptedBy, 'prof-1');
    });

    test('isConfirmed true for confirmed status', () {
      final json  = {...base, 'status': 'confirmed'};
      final model = ServiceRequestModel.fromJson(json);
      expect(model.isConfirmed, true);
    });

    test('handles null acceptedBy', () {
      final model = ServiceRequestModel.fromJson(base);
      expect(model.acceptedBy, isNull);
    });
  });

  group('ServiceRequestModel.toDb', () {
    test('toDb includes all required keys', () {
      final model  = ServiceRequestModel.fromJson(base);
      final db     = model.toDb();
      expect(db.containsKey('id'),            true);
      expect(db.containsKey('customer_name'), true);
      expect(db.containsKey('accepted_by'),   true);
      expect(db['status'],                    'pending');
    });
  });
}