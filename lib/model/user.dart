import 'package:json_annotation/json_annotation.dart';
import 'package:in_classe/interfaces/json_serializable.dart';
import 'package:in_classe/model/person.dart';
import 'package:in_classe/model/team.dart';

part 'generated/user.g.dart';

@JsonSerializable()
class User extends Person implements JSONSerializable {
  String? favTeamUID;
  String email, username;

  User(
      {super.name,
      super.surname,
      super.dateBirth,
      super.avatar,
      super.regTimestamp,
      this.favTeamUID,
      this.email = 'default@email.com',
      this.username = 'Guest'});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJSON() => _$UserToJson(this);
}
