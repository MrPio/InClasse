// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../match.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Match _$MatchFromJson(Map<String, dynamic> json) => Match(
      casa: json['casa'] as String,
      ospite: json['ospite'] as String,
      time: MatchTime.fromJson(json['time'] as Map<String, dynamic>),
      eventi: (json['eventi'] as List<dynamic>?)
              ?.map((e) => MatchEvent.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      angoli: json['angoli'] == null
          ? const MatchStatistic()
          : MatchStatistic.fromJson(json['angoli'] as Map<String, dynamic>),
      possessoPalla: json['possessoPalla'] == null
          ? const MatchStatistic()
          : MatchStatistic.fromJson(json['possessoPalla'] as Map<String, dynamic>),
      regTimestamp: (json['regTimestamp'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MatchToJson(Match instance) => <String, dynamic>{
      'casa': instance.casa,
      'ospite': instance.ospite,
      'time': instance.time.toJSON(),
      'eventi': instance.eventi.map((e) => e.toJSON()).toList(),
      'angoli': instance.angoli.toJSON(),
      'possessoPalla': instance.possessoPalla.toJSON(),
      'regTimestamp': instance.regTimestamp,
    };
