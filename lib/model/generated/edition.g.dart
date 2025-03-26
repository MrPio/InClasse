// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../edition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Edition _$EditionFromJson(Map<String, dynamic> json) => Edition.jsonConstructor(
      (json['year'] as num).toInt(),
      (json['teamUIDs'] as Map<String, dynamic>).map(
        (k, e) => MapEntry($enumDecode(_$RoundEnumMap, k),
            (e as List<dynamic>).map((e) => e as String).toList()),
      ),
      (json['matchUIDs'] as List<dynamic>).map((e) => e as String).toList(),
      (json['regTimestamp'] as num?)?.toInt(),
    );

Map<String, dynamic> _$EditionToJson(Edition instance) => <String, dynamic>{
      'year': instance.year,
      'teamUIDs':
          instance.teamUIDs.map((k, e) => MapEntry(_$RoundEnumMap[k]!, e)),
      'matchUIDs': instance.matchUIDs,
      'regTimestamp': instance.regTimestamp,
    };

const _$RoundEnumMap = {
  Round.blu: 'blu',
  Round.bianco: 'bianco',
};
