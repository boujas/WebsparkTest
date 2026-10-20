import 'package:injectable/injectable.dart';
import 'package:webspark_test/domain/repositories/path_repository.dart';

import '../../core/result/result.dart';
import '../entities/path_result.dart';
import '../entities/submission_result.dart';

@injectable
class SendPathResultsUseCase {
  SendPathResultsUseCase(this._repository);

  final PathRepository _repository;

  Future<Result<List<SubmissionResult>>> call(List<PathResult> results) =>
      _repository.sendResults(results);
}
