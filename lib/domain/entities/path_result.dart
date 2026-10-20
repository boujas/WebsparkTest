import 'package:equatable/equatable.dart';

import 'path_task.dart';
import 'cell.dart';

final class PathResult extends Equatable {
  const PathResult({required this.task, required this.path});

  final PathTask task;
  final List<Cell> path;

  bool get hasPath => path.isNotEmpty;

  String get label => hasPath ? path.join('->') : 'No path found';

  @override
  List<Object> get props => [task.id, path];
}
