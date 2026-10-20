import 'package:injectable/injectable.dart';
import 'package:webspark_test/domain/repositories/path_repository.dart';

import '../../core/result/result.dart';
import '../entities/path_task.dart';


@injectable
class FetchTasksUseCase {
  FetchTasksUseCase(this._repository);

  final PathRepository _repository;

  Future<Result<List<PathTask>>> call() => _repository.fetchTasks();
}
