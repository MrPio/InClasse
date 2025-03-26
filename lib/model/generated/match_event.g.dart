// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../match_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MatchEvent _$MatchEventFromJson(Map<String, dynamic> json) => MatchEvent(
      type: $enumDecode(_$MatchEventTypeEnumMap, json['type']),
      playerUID: json['playerUID'] as String,
      timestamp: (json['timestamp'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MatchEventToJson(MatchEvent instance) =>
    <String, dynamic>{
      'type': _$MatchEventTypeEnumMap[instance.type]!,
      'timestamp': instance.timestamp,
      'playerUID': instance.playerUID,
    };

const _$MatchEventTypeEnumMap = {
  MatchEventType.tiro: 'tiro',
  MatchEventType.tiroInPorta: 'tiroInPorta',
  MatchEventType.goal: 'goal',
  MatchEventType.falli: 'falli',
  MatchEventType.giallo: 'giallo',
  MatchEventType.rosso: 'rosso',
};
