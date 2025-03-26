// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serializable_color.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SerializableColor _$SerializableColorFromJson(Map<String, dynamic> json) =>
    SerializableColor(
      (json['r'] as num).toDouble(),
      (json['g'] as num).toDouble(),
      (json['b'] as num).toDouble(),
      (json['a'] as num?)?.toDouble() ?? 1.0,
    );

Map<String, dynamic> _$SerializableColorToJson(SerializableColor instance) =>
    <String, dynamic>{
      'a': instance.a,
      'r': instance.r,
      'g': instance.g,
      'b': instance.b,
    };
