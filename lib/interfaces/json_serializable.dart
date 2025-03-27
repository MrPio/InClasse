import 'package:json_annotation/json_annotation.dart';
import 'package:in_classe/model/user.dart';

abstract class JSONSerializable {
  /// Used to retrieve the Type object relative to a `T` generic
  static List<Type> implementations = [
    User,
  ];

  /// Used to retrieve the class json constructor object relative to a `T` generic
  static Map<Type, Function> modelFactories = {
    User: User.fromJson,
  };

  factory JSONSerializable.fromJson(Map<String, dynamic> json) {
    throw UnimplementedError();
  }

  Map<String, dynamic> toJSON();

  /// The UID of an object should be stored as the name of the Firebase document, rather than as a field of that document.
  /// This means that this field should be initialized when the object is fetched from Firestore
  @JsonKey(includeFromJson: false, includeToJson: false)
  late final String? uid;
  late final int? regTimestamp;

  /// Uses DataManager to load any UID instances.
  /// E.g. News's author User object is loaded from the New's authorUID
  fetchData() async {}
}
