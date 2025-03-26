// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../team.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Team _$TeamFromJson(Map<String, dynamic> json) => Team(
      name: json['name'] as String,
      captainUID: json['captainUID'] as String,
      logo: json['logo'] as String?,
      primaryColor: json['primaryColor'] == null
          ? const SerializableColor(1, 1, 1, 1)
          : SerializableColor.fromJson(
              json['primaryColor'] as Map<String, dynamic>),
      secondaryColor: json['secondaryColor'] == null
          ? const SerializableColor(1, 0, 0, 0)
          : SerializableColor.fromJson(
              json['secondaryColor'] as Map<String, dynamic>),
      playerUIDs: (json['playerUIDs'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      regTimestamp: (json['regTimestamp'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TeamToJson(Team instance) => <String, dynamic>{
      'name': instance.name,
      'captainUID': instance.captainUID,
      'logo': instance.logo,
      'primaryColor': instance.primaryColor.toJSON(),
      'secondaryColor': instance.secondaryColor.toJSON(),
      'playerUIDs': instance.playerUIDs,
      'regTimestamp': instance.regTimestamp,
    };
