// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Player _$PlayerFromJson(Map<String, dynamic> json) => Player(
      name: json['name'] as String? ?? 'Anonimo',
      surname: json['surname'] as String? ?? '',
      dateBirth: json['dateBirth'] == null
          ? null
          : DateTime.parse(json['dateBirth'] as String),
      avatar: json['avatar'] as String?,
      regTimestamp: (json['regTimestamp'] as num?)?.toInt(),
      teamUIDs: (json['teamUIDs'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(int.parse(k), e as String),
      ),
    );

Map<String, dynamic> _$PlayerToJson(Player instance) => <String, dynamic>{
      'name': instance.name,
      'surname': instance.surname,
      'dateBirth': instance.dateBirth?.toIso8601String(),
      'avatar': instance.avatar,
      'regTimestamp': instance.regTimestamp,
      'teamUIDs': instance.teamUIDs?.map((k, e) => MapEntry(k.toString(), e)),
    };
