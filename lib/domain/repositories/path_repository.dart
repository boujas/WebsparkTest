import '../../core/result/result.dart';
import '../entities/path_task.dart';

abstract interface class PathRepository {

  Future<void> saveUrl(String url);

  Future<Result<List<PathTask>>> fetchTasks();

  Future<void> sendResult();
}