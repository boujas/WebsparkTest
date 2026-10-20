import 'package:injectable/injectable.dart';

import '../algorithms/path_finder.dart';
import '../entities/path_calculation_progress.dart';
import '../entities/path_result.dart';
import '../entities/path_task.dart';

@injectable
class CalculatePathsUseCase {
  CalculatePathsUseCase(this._pathFinder);

  final PathFinder _pathFinder;

  Stream<PathCalculationProgress> call(List<PathTask> tasks) async* {
    if (tasks.isEmpty) {
      yield const PathCalculationProgress(percent: 100, results: []);
      return;
    }

    final results = <PathResult>[];
    for (var i = 0; i < tasks.length; i++) {
      await Future<void>.delayed(Duration.zero);

      final task = tasks[i];
      final path = _pathFinder.findShortestPath(
        task.table,
        task.start,
        task.end,
      );
      results.add(PathResult(task: task, path: path));

      yield PathCalculationProgress(
        percent: ((i + 1) * 100 / tasks.length).round(),
        results: List.unmodifiable(results),
      );
    }
  }
}
