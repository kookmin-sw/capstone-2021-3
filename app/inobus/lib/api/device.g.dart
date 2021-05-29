// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Device _$DeviceFromJson(Map<String, dynamic> json) {
  return Device(
    json['id'] as String,
    json['name'] as String,
    json['model'] as String,
    json['organization'] as String,
    json['install_date'] as String,
    (json['latitude'] as num)?.toDouble(),
    (json['longitude'] as num)?.toDouble(),
    json['location_description'] as String,
    json['point'] as int,
  );
}

Map<String, dynamic> _$DeviceToJson(Device instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'model': instance.model,
      'organization': instance.organization,
      'install_date': instance.install_date,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'location_description': instance.location_description,
      'point': instance.point,
    };
