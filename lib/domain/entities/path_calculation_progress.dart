import 'path_result.dart';

final class PathCalculationProgress {
  const PathCalculationProgress({required this.percent, required this.results});

  final int percent;
  final List<PathResult> results;
}
