import 'package:freezed_annotation/freezed_annotation.dart';

part 'process_event.freezed.dart';

@freezed
sealed class ProcessEvent with _$ProcessEvent {
  const factory ProcessEvent.started() = ProcessStarted;

  const factory ProcessEvent.sendClicked() = ProcessSendClicked;
}
