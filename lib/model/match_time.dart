import 'package:json_annotation/json_annotation.dart';

part 'generated/match_time.g.dart';

/// Composizione con Match
@JsonSerializable()
class MatchTime {
  final int scheduledStart, scheduledEnd;
  int? actualStart, actualEnd;

  /// I minuti di recupero della partita
  int extraTime;

  MatchTime(
      {required this.scheduledStart,
      required this.scheduledEnd,
      this.actualStart,
      this.actualEnd,
      this.extraTime = 0});

  factory MatchTime.fromJson(Map<String, dynamic> json) => _$MatchTimeFromJson(json);

  Map<String, dynamic> toJSON() => _$MatchTimeToJson(this);
}
