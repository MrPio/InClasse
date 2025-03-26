import 'package:json_annotation/json_annotation.dart';

import '../enum/match_event_type.dart';

part 'generated/match_event.g.dart';

/// Composizione con Match
@JsonSerializable()
class MatchEvent {
  final MatchEventType type;
  final int timestamp;
  final String playerUID;

  MatchEvent({required this.type, required this.playerUID, int? timestamp})
      : timestamp = timestamp ?? DateTime.now().millisecondsSinceEpoch;

  factory MatchEvent.fromJson(Map<String, dynamic> json) => _$MatchEventFromJson(json);

  Map<String, dynamic> toJSON() => _$MatchEventToJson(this);
}
