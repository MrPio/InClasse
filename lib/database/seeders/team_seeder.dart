import 'package:in_classe/model/team.dart';
import 'package:in_classe/model/utils/serializable_color.dart';

import '../database_seeder.dart';

class TeamSeeder extends Seeder<Team> {
  @override
  List<Team> get seeds => [
        Team(
          name: 'Tenna',
          captainUID: 'player_demo_1',
          logo: 'tenna.png',
          primaryColor: SerializableColor.fromInt(0, 191, 106),
          secondaryColor: SerializableColor.fromInt(255, 255, 255),
          playerUIDs: ['player_demo_1'],
        )..uid = 'tenna',

        Team(
          name: "Sant'Andrea",
          logo: 'sant_andrea.png',
          primaryColor: SerializableColor.fromInt(165, 125, 69),
          secondaryColor: SerializableColor.fromInt(24, 23, 24),
          captainUID: 'player_demo_2',
          playerUIDs: ['player_demo_2'],
        )..uid = 'sant_andrea',

        Team(
          name: "Centro",
          logo: 'centro.png',
          primaryColor: SerializableColor.fromInt(237,27,36),
          secondaryColor: SerializableColor.fromInt(48,48,148),
          captainUID: 'player_demo_3',
          playerUIDs: ['player_demo_3'],
        )..uid = 'centro',

        Team(
          name: "Scala santa",
          logo: 'scalasanta.png',
          primaryColor: SerializableColor.fromInt(255,255,255),
          secondaryColor: SerializableColor.fromInt(246,167,170),
          captainUID: 'player_demo_4',
          playerUIDs: ['player_demo_4'],
        )..uid = 'scalasanta',

        Team(
          name: "Croce strada",
          logo: 'crocestrada.png',
          primaryColor: SerializableColor.fromInt(0,44,165),
          secondaryColor: SerializableColor.fromInt(0,0,0),
          captainUID: 'player_demo_5',
          playerUIDs: ['player_demo_5'],
        )..uid = 'crocestrada',

        Team(
          name: "Incancellata",
          logo: 'incancellata.png',
          primaryColor: SerializableColor.fromInt(201,160,80),
          secondaryColor: SerializableColor.fromInt(246,167,170),
          captainUID: 'player_demo_6',
          playerUIDs: ['player_demo_6'],
        )..uid = 'incancellata',

        Team(
          name: "Stadio",
          logo: 'stadio.png',
          primaryColor: SerializableColor.fromInt(0,255,255),
          secondaryColor: SerializableColor.fromInt(32,32,31),
          captainUID: 'player_demo_7',
          playerUIDs: ['player_demo_7'],
        )..uid = 'stadio',

        Team(
          name: "San Lorenzo",
          logo: 'sanlorenzo.png',
          primaryColor: SerializableColor.fromInt(36,235,54),
          secondaryColor: SerializableColor.fromInt(0,0,0),
          captainUID: 'player_demo_8',
          playerUIDs: ['player_demo_8'],
        )..uid = 'sanlorenzo',
      ];
}
