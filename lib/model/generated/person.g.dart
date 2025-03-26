// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) => Person(
      name: json['name'] as String? ?? 'Anonimo',
      surname: json['surname'] as String? ?? '',
      dateBirth: json['dateBirth'] == null
          ? null
          : DateTime.parse(json['dateBirth'] as String),
      avatar: json['avatar'] as String?,
      regTimestamp: (json['regTimestamp'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'name': instance.name,
      'surname': instance.surname,
      'dateBirth': instance.dateBirth?.toIso8601String(),
      'avatar': instance.avatar,
      'regTimestamp': instance.regTimestamp,
    };
