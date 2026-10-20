import 'package:injectable/injectable.dart';

import '../entities/table.dart';
import '../entities/cell.dart';
import 'path_finder.dart';

@LazySingleton(as: PathFinder)
class SimplePathFinder implements PathFinder {
  @override
  List<Cell> findShortestPath(Table grid, Cell start, Cell end) {
    if (!grid.isWalkable(start) || !grid.isWalkable(end)) return const [];

    final visited = <Cell>{start};
    final queue = <List<Cell>>[
      [start],
    ];

    while (queue.isNotEmpty) {
      final path = queue.removeAt(0);
      final last = path.last;

      if (last == end) return path;

      for (var dy = -1; dy <= 1; dy++) {
        for (var dx = -1; dx <= 1; dx++) {
          final next = Cell(last.x + dx, last.y + dy);

          if (!grid.isWalkable(next)) continue;
          if (visited.contains(next)) continue;

          visited.add(next);
          queue.add([...path, next]);
        }
      }
    }
    return const [];
  }
}
