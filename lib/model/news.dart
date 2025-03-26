import 'package:json_annotation/json_annotation.dart';
import 'package:in_classe/manager/data_manager.dart';
import 'package:in_classe/mixin/comparable.dart';
import 'package:in_classe/model/user.dart';

import '../interfaces/json_serializable.dart';

part 'generated/news.g.dart';

@JsonSerializable()
class News with Comparable<News> implements JSONSerializable {
  final String titolo, body;

  final String? authorUID, sottotitolo, immagine;
  final int pubblicazioneTimestamp;

  News({
    this.titolo = "Titolo",
    this.body = "Testo della notizia",
    this.authorUID,
    int? pubblicazioneTimestamp,
    this.sottotitolo,
    this.immagine,
    int? regTimestamp,
  })  : pubblicazioneTimestamp = pubblicazioneTimestamp ?? DateTime.now().millisecondsSinceEpoch,
        regTimestamp = regTimestamp ?? DateTime.now().millisecondsSinceEpoch;

  /// Factory per la deserializzazione da JSON
  factory News.fromJson(Map<String, dynamic> json) => _$NewsFromJson(json);

  /// Metodo per la serializzazione in JSON
  @override
  Map<String, dynamic> toJSON() => _$NewsToJson(this);

  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  late final String? uid;

  @override
  late final int? regTimestamp;

  @JsonKey(includeFromJson: false, includeToJson: false)
  User? author;

  @JsonKey(includeFromJson: false, includeToJson: false)
  DateTime get dataPubblicazione => DateTime.fromMillisecondsSinceEpoch(pubblicazioneTimestamp);

  @JsonKey(includeFromJson: false, includeToJson: false)
  bool hasFetched = false;

  @override
  fetchData() async {
    author = authorUID == null ? null : await DataManager().load<User>(authorUID!);
    hasFetched = true;
  }

  @override
  // Compare by publication date in descending order
  int compareTo(News other) => -pubblicazioneTimestamp.compareTo(other.pubblicazioneTimestamp);
}
