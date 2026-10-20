import '../../domain/entities/cell.dart';
import '../../domain/entities/path_result.dart';
import '../../domain/entities/path_task.dart';
import '../../domain/entities/submission_result.dart';
import '../../domain/entities/table.dart';
import '../models/result_dto.dart';
import '../models/submit_response_dto.dart';
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

extension PathResultMapper on PathResult {
  ResultRequestDto toDto() => ResultRequestDto(
    id: task.id,
    result: ResultDataDto(
      steps: [for (final cell in path) StepDto(x: cell.x, y: cell.y)],
      path: label,
    ),
  );
}

extension SubmitResponseDtoMapper on SubmitResponseDto {
  List<SubmissionResult> toDomain() => [
    for (final item in data)
      SubmissionResult(taskId: item.id, isCorrect: item.correct),
  ];
}
