import 'package:json_annotation/json_annotation.dart';
import 'package:in_classe/interfaces/json_serializable.dart';
import 'package:in_classe/model/team.dart';

import 'match_event.dart';
import 'match_statistic.dart';
import 'match_time.dart';

part 'generated/match.g.dart';

@JsonSerializable(explicitToJson: true)
class Match implements JSONSerializable {
  /// Le squadre che hanno giocato questa partita
  final String casa, ospite;

  /// Le date di inizio e fine partita, programmate e effettive, e minuti di recupero.
  final MatchTime time;
  final List<MatchEvent> eventi;
  final MatchStatistic angoli, possessoPalla;

  Match({
    required this.casa,
    required this.ospite,
    required this.time,
    this.eventi = const [],
    this.angoli = const MatchStatistic(),
    this.possessoPalla = const MatchStatistic(),
    int? regTimestamp,
  }) : regTimestamp = regTimestamp ?? DateTime.now().millisecondsSinceEpoch;

  factory Match.fromJson(Map<String, dynamic> json) => _$MatchFromJson(json);

  Map<String, dynamic> toJSON() => _$MatchToJson(this);

  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  late final String? uid;

  @override
  late final int? regTimestamp;

  @override
  fetchData() {}
}
