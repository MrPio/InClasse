import 'package:tuple/tuple.dart';

class Analisi {
  final String? corso, summary;
  final int? lezione;
  final List<Tuple2<String, String>>? test, chat;
  final List<String>? topics;

  Analisi({this.corso, this.lezione, this.summary, this.test, this.chat, this.topics});
}
