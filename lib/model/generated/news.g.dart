// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../news.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

News _$NewsFromJson(Map<String, dynamic> json) => News(
      titolo: json['titolo'] as String? ?? "Titolo",
      body: json['body'] as String? ?? "Testo della notizia",
      authorUID: json['authorUID'] as String?,
      pubblicazioneTimestamp: (json['pubblicazioneTimestamp'] as num?)?.toInt(),
      sottotitolo: json['sottotitolo'] as String?,
      immagine: json['immagine'] as String?,
      regTimestamp: (json['regTimestamp'] as num?)?.toInt(),
    );

Map<String, dynamic> _$NewsToJson(News instance) => <String, dynamic>{
      'titolo': instance.titolo,
      'body': instance.body,
      'authorUID': instance.authorUID,
      'sottotitolo': instance.sottotitolo,
      'immagine': instance.immagine,
      'pubblicazioneTimestamp': instance.pubblicazioneTimestamp,
      'regTimestamp': instance.regTimestamp,
    };
