import '../../enum/round.dart';
import '../../model/edition.dart';
import '../database_seeder.dart';

class EditionSeeder extends Seeder<Edition> {
  @override
  List<Edition> get seeds => [
        Edition(
          year: 2025,
          teamUIDs: {
            Round.bianco: ['tenna'],
            Round.blu: ['sant_andrea'],
          },
          matchUIDs: ['match_demo_1'],
        )
      ];
}
