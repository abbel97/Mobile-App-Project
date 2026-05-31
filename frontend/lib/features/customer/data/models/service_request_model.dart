import '../../domain/entities/service_request_entity.dart';

class ServiceRequestModel extends ServiceRequestEntity {
  const ServiceRequestModel({
    required super.id,
    required super.title,
    required super.description,
    required super.profession,
    required super.location,
    super.customerName,
    required super.status,
    required super.urgency,
    required super.customerId,
    super.acceptedBy,
    required super.createdAt,
    required super.updatedAt,
    super.photoBase64,
  });

  factory ServiceRequestModel.fromJson(Map<String, dynamic> j) =>
      ServiceRequestModel(
        id:          j['id']          as String,
        title:       j['title']       as String,
        description: j['description'] as String,
        profession:  j['profession']  as String,
        location:    j['location']    as String,
        customerName: j['customer_name'] as String?,
        status:      j['status']      as String,
        urgency:     j['urgency']     as String,
        customerId:  j['customer_id'] as String,
        acceptedBy:  j['accepted_by'] as String?,
        createdAt:   j['created_at']  as String,
        updatedAt:   j['updated_at']  as String,
        photoBase64: j['photo_base64'] as String?,
      );

  factory ServiceRequestModel.fromDb(Map<String, dynamic> m) =>
      ServiceRequestModel(
        id:          m['id']          as String,
        title:       m['title']       as String,
        description: m['description'] as String,
        profession:  m['profession']  as String,
        location:    m['location']    as String,
        customerName: m['customer_name'] as String?,
        status:      m['status']      as String,
        urgency:     m['urgency']     as String,
        customerId:  m['customer_id'] as String,
        acceptedBy:  m['accepted_by'] as String?,
        createdAt:   m['created_at']  as String,
        updatedAt:   m['updated_at']  as String,
        photoBase64: m['photo_base64'] as String?,
      );

  Map<String, dynamic> toDb() => {
    'id':          id,
    'title':       title,
    'description': description,
    'profession':  profession,
    'location':    location,
    'customer_name': customerName ?? '',
    'status':      status,
    'urgency':     urgency,
    'customer_id': customerId,
    'accepted_by': acceptedBy,
    'created_at':  createdAt,
    'updated_at':  updatedAt,
    'photo_base64': photoBase64,
  };
}