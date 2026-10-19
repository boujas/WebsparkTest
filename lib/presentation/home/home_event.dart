import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_event.freezed.dart';

@freezed
sealed class HomeEvent with _$HomeEvent {
  const factory HomeEvent.urlChanged() = HomeUrlChanged;

  const factory HomeEvent.startClicked(String url) = HomeStartClicked;

  const factory HomeEvent.navigationHandled() = HomeNavigationHandled;
}
