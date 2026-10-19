import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

enum HomeStatus { editing, readyToStart }

@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState({
    @Default('') String savedUrl,
    @Default(HomeStatus.editing) HomeStatus status,
    String? errorMessage,
  }) = _HomeState;
}