import 'dart:core';

import 'package:json_annotation/json_annotation.dart';
import 'package:in_classe/interfaces/json_serializable.dart';
import 'package:in_classe/model/person.dart';
import 'package:in_classe/model/team.dart';

part 'generated/player.g.dart';

@JsonSerializable()
class Player extends Person implements JSONSerializable {
  final Map<int, String>? teamUIDs; // Map<int (anno dell'ediz), Team>

  Player({
    super.name,
    super.surname,
    super.dateBirth,
    super.avatar,
    super.regTimestamp,
    this.teamUIDs,
  });

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);

  Map<String, dynamic> toJSON() => _$PlayerToJson(this);
}
