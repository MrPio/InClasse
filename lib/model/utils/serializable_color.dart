import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';

part 'serializable_color.g.dart';

@JsonSerializable()
class SerializableColor {
  final double a, r, g, b;

  const SerializableColor(this.r, this.g, this.b, [this.a = 1.0]);

  const SerializableColor.fromInt(int r, int g, int b, [int a = 255])
      : a = a / 255.0,
        r = r / 255.0,
        g = g / 255.0,
        b = b / 255.0;

  /// Converte SerializableColor in un oggetto Color
  @JsonKey(includeFromJson: false, includeToJson: false)
  Color get color => Color.fromARGB(
        (a * 255).toInt(), // Converti il valore alpha da [0,1] a [0,255]
        (r * 255).toInt(),
        (g * 255).toInt(),
        (b * 255).toInt(),
      );

  /// Crea un SerializableColor da un oggetto Color
  factory SerializableColor.fromColor(Color color) => SerializableColor(
        color.alpha / 255.0,
        color.red / 255.0,
        color.green / 255.0,
        color.blue / 255.0,
      );

  factory SerializableColor.fromJson(Map<String, dynamic> json) => _$SerializableColorFromJson(json);

  Map<String, dynamic> toJSON() => _$SerializableColorToJson(this);
}
