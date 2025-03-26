// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      name: json['name'] as String? ?? 'Anonimo',
      surname: json['surname'] as String? ?? '',
      dateBirth: json['dateBirth'] == null
          ? null
          : DateTime.parse(json['dateBirth'] as String),
      avatar: json['avatar'] as String? ??
          'https://firebasestorage.googleapis.com/v0/b/tdq-37114.appspot.com/o/Users%2Fanonimo.png?alt=media&token=20f47754-6cf0-495d-ba25-513d76ff34a4',
      regTimestamp: (json['regTimestamp'] as num?)?.toInt(),
      favTeamUID: json['favTeamUID'] as String?,
      email: json['email'] as String? ?? 'default@email.com',
      username: json['username'] as String? ?? 'Guest',
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'surname': instance.surname,
      'dateBirth': instance.dateBirth?.toIso8601String(),
      'avatar': instance.avatar,
      'regTimestamp': instance.regTimestamp,
      'favTeamUID': instance.favTeamUID,
      'email': instance.email,
      'username': instance.username,
    };
