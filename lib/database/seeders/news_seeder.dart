import 'package:in_classe/model/news.dart';

import '../database_seeder.dart';

class NewsSeeder extends Seeder<News> {
  @override
  List<News> get seeds => [
        News(
            authorUID: "DuU6ZU82ebdEgsR5ssrSVtIMxm23",
            pubblicazioneTimestamp: DateTime.now().millisecondsSinceEpoch,
            titolo: "Apple rilascia iOS 18 con nuove funzionalità",
            sottotitolo: "WOOOOOW",
            body: "Scopri tutte le novità di iOS 18, tra cui miglioramenti alla privacy e nuove app.",
            immagine: "default.jpg")
          ..uid = "news_demo_1",
        News(
            authorUID: "DuU6ZU82ebdEgsR5ssrSVtIMxm23",
            pubblicazioneTimestamp: DateTime.now().millisecondsSinceEpoch,
            titolo: "Pippo, ma non troppo",
            sottotitolo: "WOOOOOW",
            body: "Scopri tutte le novità di iOS 18, tra cui miglioramenti alla privacy e nuove app.",
            immagine: "default2.jpg")
          ..uid = "news_demo_2",
      ];
}
