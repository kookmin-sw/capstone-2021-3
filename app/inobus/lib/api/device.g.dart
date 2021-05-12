// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Device _$DeviceFromJson(Map<String, dynamic> json) {
  return Device(
    json['name'] as String,
    json['id'] as String,
    json['organ'] as String,
    json['installDate'] as String,
    json['point'] as int,
    (json['lat'] as num)?.toDouble(),
    (json['long'] as num)?.toDouble(),
    json['loc'] as String,
  );
}

Map<String, dynamic> _$DeviceToJson(Device instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'organ': instance.organ,
      'installDate': instance.installDate,
      'point': instance.point,
      'lat': instance.lat,
      'long': instance.long,
      'loc': instance.loc,
    };
