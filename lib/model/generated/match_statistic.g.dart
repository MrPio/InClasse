// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../match_statistic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MatchStatistic _$MatchStatisticFromJson(Map<String, dynamic> json) =>
    MatchStatistic(
      casa: (json['casa'] as num?)?.toInt() ?? 0,
      ospite: (json['ospite'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$MatchStatisticToJson(MatchStatistic instance) =>
    <String, dynamic>{
      'casa': instance.casa,
      'ospite': instance.ospite,
    };
