import 'package:injectable/injectable.dart';
import 'package:webspark_test/domain/repositories/path_repository.dart';

@injectable
class SendPathResultsUseCase {
  SendPathResultsUseCase(this._repository);

  final PathRepository _repository;

}