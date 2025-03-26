import 'package:json_annotation/json_annotation.dart';
import 'package:in_classe/model/team_statistics.dart';

import '../enum/round.dart';
import '../interfaces/json_serializable.dart';

part 'generated/edition.g.dart';

/// Implementazione di Provider (Opzione Migliore per Stato Reattivo) in quanto accessibile in più punti (MrPio: ?)
@JsonSerializable(constructor: 'jsonConstructor')
class Edition implements JSONSerializable {
  final int year;

  /// Gli UID delle squadre dei due gironi
  final Map<Round, List<String>> teamUIDs;

  /// Le partite disputate in questa edizione.
  final List<String> matchUIDs;

  @JsonKey(includeFromJson: false, includeToJson: false)
  late final Map<String, TeamStatistics> teamStatistics;

  Edition.jsonConstructor(
      this.year, this.teamUIDs, this.matchUIDs, this.regTimestamp);

  Edition({
    int? year,
    this.teamUIDs = const {Round.bianco: [], Round.blu: []},
    this.matchUIDs = const [],
  })  : uid = year.toString(),
        year = year ?? DateTime.now().year,
        regTimestamp = DateTime.now().millisecondsSinceEpoch;

  /// Genera la classifica delle squadre
  List<String> get ranking => teamStatistics.keys.toList()
    ..sort((a, b) => -teamStatistics[a]!.punteggio.compareTo(teamStatistics[b]!.punteggio));

  /// Get the round the given team is in
  Round? getRound(String teamUID) => teamUIDs[Round.bianco]?.contains(teamUID) == true
      ? Round.bianco
      : teamUIDs[Round.bianco]?.contains(teamUID) == true
          ? Round.blu
          : null;

  factory Edition.fromJson(Map<String, dynamic> json) => _$EditionFromJson(json);

  Map<String, dynamic> toJSON() => _$EditionToJson(this);

  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  late final String? uid;

  @override
  late final int? regTimestamp;

  @override
  fetchData() {}
}
