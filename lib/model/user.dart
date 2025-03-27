import 'package:in_classe/interfaces/json_serializable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User implements JSONSerializable {
  final String nome, cognome, corso, email, username;

  User(
      {required this.email,
      required this.username,
      this.nome = 'Mario',
      this.cognome = 'Rossi',
      this.corso = "Ingegneria Informatica e dell'Automazione"});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJSON() => _$UserToJson(this);

  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  late final String? uid;

  @override
  late final int? regTimestamp;

  @override
  fetchData() {}
}
