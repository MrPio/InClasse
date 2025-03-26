import 'package:json_annotation/json_annotation.dart';

part 'generated/match_statistic.g.dart';

@JsonSerializable()
class MatchStatistic {
  final int casa, ospite;

  const MatchStatistic({this.casa = 0, this.ospite = 0});

  factory MatchStatistic.fromJson(Map<String, dynamic> json) => _$MatchStatisticFromJson(json);

  Map<String, dynamic> toJSON() => _$MatchStatisticToJson(this);
}
