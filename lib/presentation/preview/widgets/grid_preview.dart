import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../core/theme/grid_colors.dart';
import '../../../domain/entities/path_result.dart';
import '../../../domain/entities/cell.dart';

class GridPreview extends StatelessWidget {
  const GridPreview({super.key, required this.result});

  final PathResult result;

  @override
  Widget build(BuildContext context) {
    final task = result.task;
    final grid = task.table;
    final pathCells = result.path.toSet();

    return LayoutBuilder(
      builder: (context, constraints) {
        final cellSize = constraints.maxWidth / grid.width;
        final showText = cellSize >= 24;

        return Column(
          children: [
            for (var y = 0; y < grid.height; y++)
              Row(
                children: [
                  for (var x = 0; x < grid.width; x++)
                    _Cell(
                      size: cellSize,
                      point: Cell(x, y),
                      color: _colorFor(Cell(x, y), pathCells),
                    ),
                ],
              ),
          ],
        );
      },
    );
  }

  Color _colorFor(Cell cell, Set<Cell> pathCells) {
    final task = result.task;
    if (cell == task.start) return GridColors.start;
    if (cell == task.end) return GridColors.end;
    if (task.table.isBlocked(cell)) return GridColors.blocked;
    if (pathCells.contains(cell)) return GridColors.path;
    return GridColors.empty;
  }
}

class _Cell extends StatelessWidget {
  const _Cell({required this.size, required this.point, required this.color});

  final double size;
  final Cell point;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final isDark = color == GridColors.blocked || color == GridColors.end;

    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: color, border: Border.all(width: 0.5)),
      child: FittedBox(
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Text(
            point.toString(),
            style: TextStyle(
              fontSize: math.min(12, size / 5),
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
