import '../../domain/entities/cell.dart';
import '../../domain/entities/path_task.dart';
import '../../domain/entities/table.dart';
import '../models/task_dto.dart';

extension PointDtoMapper on PointDto {
  Cell toDomain() => Cell(x, y);
}

extension TaskDtoMapper on TaskDto {
  PathTask toDomain() => PathTask(
    id: id,
    table: Table.parse(field),
    start: start.toDomain(),
    end: end.toDomain(),
  );
}

extension TasksResponseDtoMapper on TasksResponseDto {
  List<PathTask> toDomain() => data.map((task) => task.toDomain()).toList();
}
