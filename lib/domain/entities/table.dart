import 'cell.dart';

final class Table {
  Table._(this._blocked, this.width, this.height);

  factory Table.parse(List<String> rows) {
    if (rows.isEmpty || rows.first.isEmpty) {
      throw const FormatException('Table is empty');
    }
    final width = rows.first.length;
    final blocked = [
      for (final row in rows)
        for (final char in row.split('')) char.toUpperCase() == 'X',
    ];
    return Table._(blocked, width, rows.length);
  }

  final List<bool> _blocked;
  final int width;
  final int height;

  bool contains(Cell p) => p.x >= 0 && p.y >= 0 && p.x < width && p.y < height;

  bool isBlocked(Cell p) => _blocked[p.y * width + p.x];

  bool isWalkable(Cell p) => contains(p) && !isBlocked(p);
}
