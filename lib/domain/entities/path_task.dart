import 'package:webspark_test/domain/entities/table.dart';

import 'cell.dart';

final class PathTask {
  const PathTask({
    required this.id,
    required this.table,
    required this.start,
    required this.end,
  });

  final String id;
  final Table table;
  final Cell start;
  final Cell end;
}
