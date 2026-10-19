import 'package:freezed_annotation/freezed_annotation.dart';

import 'json_converters.dart';

part 'task_dto.freezed.dart';
part 'task_dto.g.dart';

@freezed
abstract class PointDto with _$PointDto {
  const factory PointDto({
    @FlexibleIntConverter() required int x,
    @FlexibleIntConverter() required int y,
  }) = _PointDto;

  factory PointDto.fromJson(Map<String, dynamic> json) =>
      _$PointDtoFromJson(json);
}

@freezed
abstract class TaskDto with _$TaskDto {
  const factory TaskDto({
    required String id,
    required List<String> field,
    required PointDto start,
    required PointDto end,
  }) = _TaskDto;

  factory TaskDto.fromJson(Map<String, dynamic> json) =>
      _$TaskDtoFromJson(json);
}

@freezed
abstract class TasksResponseDto with _$TasksResponseDto {
  const factory TasksResponseDto({
    @Default(false) bool error,
    @Default('') String message,
    @Default(<TaskDto>[]) List<TaskDto> data,
  }) = _TasksResponseDto;

  factory TasksResponseDto.fromJson(Map<String, dynamic> json) =>
      _$TasksResponseDtoFromJson(json);
}