import '../entities/table.dart';
import '../entities/cell.dart';

abstract interface class PathFinder {
  List<Cell> findShortestPath(Table grid, Cell start, Cell end);
}
