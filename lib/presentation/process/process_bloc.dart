import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../core/result/result.dart';
import '../../domain/entities/path_result.dart';
import '../../domain/entities/path_task.dart';
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

    switch (await _fetchTasks()) {
      case Failure(:final error):
        emit(state.copyWith(
          status: ProcessStatus.fetchFailed,
          errorMessage: error.message,
        ));
      case Success(:final data):
        await _calculate(data, emit);
    }
  }

  Future<void> _calculate(
      List<PathTask> tasks,
      Emitter<ProcessState> emit,
      ) async {
    try {
      emit(state.copyWith(status: ProcessStatus.calculating));

      var results = const <PathResult>[];
      await for (final progress in _calculatePaths(tasks)) {
        results = progress.results;
        emit(state.copyWith(progress: progress.percent));
      }

      emit(state.copyWith(
        status: ProcessStatus.ready,
        progress: 100,
        results: results,
      ));
    } catch (_) {
      emit(state.copyWith(
        status: ProcessStatus.fetchFailed,
        errorMessage: 'Something went wrong while calculating',
      ));
    }
  }

  Future<void> _onSendPressed(
      ProcessSendClicked event,
      Emitter<ProcessState> emit,
      ) async {
    emit(state.copyWith(status: ProcessStatus.sending, errorMessage: null));

    final result = await _sendResults(state.results);
    emit(switch (result) {
      Success() => state.copyWith(status: ProcessStatus.sent),
      Failure(:final error) => state.copyWith(
        status: ProcessStatus.sendFailed,
        errorMessage: error.message,
      ),
    });
  }
}
