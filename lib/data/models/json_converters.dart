import 'package:freezed_annotation/freezed_annotation.dart';

class FlexibleIntConverter implements JsonConverter<int, Object?> {
  const FlexibleIntConverter();

  @override
  int fromJson(Object? json) =>
      json is num ? json.toInt() : int.parse(json.toString());

  @override
  Object toJson(int object) => object;
}

class StringIntConverter implements JsonConverter<int, Object?> {
  const StringIntConverter();

  @override
  int fromJson(Object? json) =>
      json is num ? json.toInt() : int.parse(json.toString());

  @override
  Object toJson(int object) => object.toString();
}
