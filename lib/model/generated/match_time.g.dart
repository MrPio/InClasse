// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../match_time.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MatchTime _$MatchTimeFromJson(Map<String, dynamic> json) => MatchTime(
      scheduledStart: (json['scheduledStart'] as num).toInt(),
      scheduledEnd: (json['scheduledEnd'] as num).toInt(),
      actualStart: (json['actualStart'] as num?)?.toInt(),
      actualEnd: (json['actualEnd'] as num?)?.toInt(),
      extraTime: (json['extraTime'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$MatchTimeToJson(MatchTime instance) => <String, dynamic>{
      'scheduledStart': instance.scheduledStart,
      'scheduledEnd': instance.scheduledEnd,
      'actualStart': instance.actualStart,
      'actualEnd': instance.actualEnd,
      'extraTime': instance.extraTime,
    };
