import 'package:freezed_annotation/freezed_annotation.dart';

part 'submit_response_dto.freezed.dart';
part 'submit_response_dto.g.dart';

@freezed
abstract class SubmitResultDto with _$SubmitResultDto {
  const factory SubmitResultDto({
    required String id,
    required bool correct,
  }) = _SubmitResultDto;

  factory SubmitResultDto.fromJson(Map<String, dynamic> json) =>
      _$SubmitResultDtoFromJson(json);
}

@freezed
abstract class SubmitResponseDto with _$SubmitResponseDto {
  const factory SubmitResponseDto({
    @Default(false) bool error,
    @Default('') String message,
    @Default(<SubmitResultDto>[]) List<SubmitResultDto> data,
  }) = _SubmitResponseDto;

  factory SubmitResponseDto.fromJson(Map<String, dynamic> json) =>
      _$SubmitResponseDtoFromJson(json);
}