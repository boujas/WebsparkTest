import '../../core/result/result.dart';
import '../entities/path_result.dart';
import '../entities/path_task.dart';
import '../entities/submission_result.dart';

abstract interface class PathRepository {

  Future<void> saveUrl(String url);

  Future<Result<List<PathTask>>> fetchTasks();

  Future<Result<List<SubmissionResult>>> sendResults(List<PathResult> results);
}