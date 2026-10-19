import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/errors/app_exception.dart';
import '../../domain/usecases/save_url_use_case.dart';
import 'home_event.dart';
import 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final SaveUrlUseCase _saveBaseUrl;

  HomeBloc(this._saveBaseUrl) : super(HomeState()) {
    on<HomeUrlChanged>((_, emit) {
      if (state.errorMessage != null) {
        emit(state.copyWith(errorMessage: null));
      }
    });
    on<HomeStartClicked>(_onStartPressed, transformer: droppable());
    on<HomeNavigationHandled>(
      (_, emit) => emit(state.copyWith(status: HomeStatus.editing)),
    );
  }

  Future<void> _onStartPressed(
    HomeStartClicked event,
    Emitter<HomeState> emit,
  ) async {
    try {
      await _saveBaseUrl(event.url);
      emit(
        HomeState(savedUrl: event.url.trim(), status: HomeStatus.readyToStart),
      );
    } on AppException catch (e) {
      emit(state.copyWith(errorMessage: e.message));
    }
  }
}
