import 'package:in_classe/model/player.dart';

import '../database_seeder.dart';

class PlayerSeeder extends Seeder<Player> {
  @override
  List<Player> get seeds => [
        // Tenna
        Player(
          name: "Mario",
          surname: "Rossi",
          dateBirth: DateTime(2000, 1, 1),
          teamUIDs: {2020: "tenna"},
        )..uid = "player_demo_1",

        // Sant'Andrea
        Player(
          name: "Luigi",
          surname: "Verdi",
          dateBirth: DateTime(2002, 1, 1),
          teamUIDs: {2020: "sant_andrea"},
        )..uid = "player_demo_2",
      ];
}
