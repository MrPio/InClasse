import 'package:json_annotation/json_annotation.dart';
import 'package:in_classe/interfaces/json_serializable.dart';

part 'generated/person.g.dart';

@JsonSerializable()
class Person implements JSONSerializable {
  final String name;
  final String surname;
  DateTime? dateBirth;
  String? avatar;

  Person({
    this.name = 'Anonimo',
    this.surname = '',
    this.dateBirth,
    this.avatar = 'https://firebasestorage.googleapis.com/v0/b/tdq-37114.appspot.com/o/Users%2Fanonimo.png?alt=media&token=20f47754-6cf0-495d-ba25-513d76ff34a4',
    int? regTimestamp,
  }):regTimestamp = regTimestamp ?? DateTime.now().millisecondsSinceEpoch;

  @override
  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  @override
  Map<String, dynamic> toJSON() => _$PersonToJson(this);

  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  late final String? uid;

  @override
  late final int? regTimestamp;
  @override
  fetchData() {}
}
