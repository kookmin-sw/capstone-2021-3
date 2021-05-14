// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orgainzation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Orgainzation _$OrgainzationFromJson(Map<String, dynamic> json) {
  return Orgainzation(
    json['name'] as String,
    json['point'] as int,
    json['phone'] as String,
    json['url'] as String,
    json['id'] as String,
  );
}

Map<String, dynamic> _$OrgainzationToJson(Orgainzation instance) =>
    <String, dynamic>{
      'name': instance.name,
      'point': instance.point,
      'phone': instance.phone,
      'url': instance.url,
      'id': instance.id,
    };
