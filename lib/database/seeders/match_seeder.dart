import 'package:in_classe/enum/match_event_type.dart';
import 'package:in_classe/model/match_event.dart';
import 'package:in_classe/model/match_time.dart';

import '../../model/match.dart';
import '../../model/match_statistic.dart';
import '../database_seeder.dart';

class MatchSeeder extends Seeder<Match> {
  @override
  List<Match> get seeds => [
        Match(
            casa: 'tenna',
            ospite: 'sant_andrea',
            time: MatchTime(
              scheduledStart: DateTime(2025, 1, 1).millisecondsSinceEpoch,
              scheduledEnd: DateTime(2025, 1, 1).add(Duration(hours: 1)).millisecondsSinceEpoch,
            ),
            angoli: MatchStatistic(casa: 1, ospite: 2),
            possessoPalla: MatchStatistic(casa: 30, ospite: 70),
            eventi: [
              MatchEvent(type: MatchEventType.falli, playerUID: "player_demo_2"),
              MatchEvent(type: MatchEventType.tiro, playerUID: "player_demo_1"),
            ])..uid="match_demo_1"
      ];
}
