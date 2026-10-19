import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../core/result/result.dart';
import '../../domain/usecases/calculate_paths_use_case.dart';
import '../../domain/usecases/fetch_paths_use_case.dart';
import '../../domain/usecases/send_path_results_use_case.dart';
import 'process_event.dart';
import 'process_state.dart';

@injectable
class ProcessBloc extends Bloc<ProcessEvent, ProcessState> {
  ProcessBloc(this._fetchTasks, this._calculatePaths, this._sendResults)
    : super(const ProcessState()) {
    on<ProcessStarted>(_onStarted, transformer: restartable());
    on<ProcessSendClicked>(_onSendPressed, transformer: droppable());
  }

  final FetchTasksUseCase _fetchTasks;
  final CalculatePathsUseCase _calculatePaths;
  final SendPathResultsUseCase _sendResults;

  Future<void> _onStarted(
    ProcessStarted event,
    Emitter<ProcessState> emit,
  ) async {
    emit(const ProcessState());

    try {
      switch (await _fetchTasks()) {
        case Failure(:final error):
          emit(
            state.copyWith(
              status: ProcessStatus.fetchFailed,
              errorMessage: error.message,
            ),
          );
        case Success(:final data):
          emit(state.copyWith(status: ProcessStatus.ready, progress: 100));
      }
    } catch (_) {
      emit(
        state.copyWith(
          status: ProcessStatus.fetchFailed,
          errorMessage: 'Something went wrong while calculating',
        ),
      );
    }
  }

  Future<void> _onSendPressed(
    ProcessSendClicked event,
    Emitter<ProcessState> emit,
  ) async {}
}
