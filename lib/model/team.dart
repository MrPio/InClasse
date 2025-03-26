import 'package:json_annotation/json_annotation.dart';
import 'package:in_classe/interfaces/json_serializable.dart';
import 'package:in_classe/model/utils/serializable_color.dart';

part 'generated/team.g.dart';

@JsonSerializable(explicitToJson: true)
class Team implements JSONSerializable {
  final String name, captainUID;
  final String? logo;
  final SerializableColor primaryColor, secondaryColor;
  final List<String> playerUIDs;

  Team(
      {required this.name,
      required this.captainUID,
      this.logo,
      this.primaryColor = const SerializableColor(1, 1, 1),
      this.secondaryColor = const SerializableColor(0, 0, 0),
      this.playerUIDs = const [],
      int? regTimestamp})
      : regTimestamp = regTimestamp ?? DateTime.now().millisecondsSinceEpoch;

  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);

  Map<String, dynamic> toJSON() => _$TeamToJson(this);

  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  late final String? uid;

  @override
  late final int? regTimestamp;

  @override
  fetchData() {}
}
