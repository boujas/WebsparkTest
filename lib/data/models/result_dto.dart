import 'package:freezed_annotation/freezed_annotation.dart';

import 'json_converters.dart';

part 'result_dto.freezed.dart';
part 'result_dto.g.dart';

@freezed
abstract class StepDto with _$StepDto {
  const factory StepDto({
    @StringIntConverter() required int x,
    @StringIntConverter() required int y,
  }) = _StepDto;

  factory StepDto.fromJson(Map<String, dynamic> json) =>
      _$StepDtoFromJson(json);
}

@freezed
abstract class ResultDataDto with _$ResultDataDto {
  const factory ResultDataDto({
    required List<StepDto> steps,
    required String path,
  }) = _ResultDataDto;

  factory ResultDataDto.fromJson(Map<String, dynamic> json) =>
      _$ResultDataDtoFromJson(json);
}

@freezed
abstract class ResultRequestDto with _$ResultRequestDto {
  const factory ResultRequestDto({
    required String id,
    required ResultDataDto result,
  }) = _ResultRequestDto;

  factory ResultRequestDto.fromJson(Map<String, dynamic> json) =>
      _$ResultRequestDtoFromJson(json);
}
