// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      email: json['email'] as String,
      username: json['username'] as String,
      nome: json['nome'] as String? ?? 'Mario',
      cognome: json['cognome'] as String? ?? 'Rossi',
      corso: json['corso'] as String? ??
          "Ingegneria Informatica e dell'Automazione",
    )..regTimestamp = (json['regTimestamp'] as num?)?.toInt();

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'nome': instance.nome,
      'cognome': instance.cognome,
      'corso': instance.corso,
      'email': instance.email,
      'username': instance.username,
      'regTimestamp': instance.regTimestamp,
    };
