import 'package:freezed_annotation/freezed_annotation.dart';

part 'process_state.freezed.dart';

enum ProcessStatus {
  fetching,
  fetchFailed,
  calculating,
  ready,
  sending,
  sendFailed,
  sent,
}

@freezed
abstract class ProcessState with _$ProcessState {
  const factory ProcessState({
    @Default(ProcessStatus.fetching) ProcessStatus status,
    @Default(0) int progress,
    String? errorMessage,
  }) = _ProcessState;
}
