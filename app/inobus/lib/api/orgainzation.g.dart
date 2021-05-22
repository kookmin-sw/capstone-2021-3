// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orgainzation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Orgainzation _$OrgainzationFromJson(Map<String, dynamic> json) {
  return Orgainzation(
    json['id'] as String,
    json['name'] as String,
    json['point'] as int,
    json['homepage'] as String,
    json['phone'] as String,
  );
}

Map<String, dynamic> _$OrgainzationToJson(Orgainzation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'point': instance.point,
      'homepage': instance.homepage,
      'phone': instance.phone,
    };
