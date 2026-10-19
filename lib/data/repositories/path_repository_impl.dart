import 'package:injectable/injectable.dart';
import 'package:webspark_test/domain/repositories/path_repository.dart';

@LazySingleton(as: PathRepository)
class PathRepositoryImpl implements PathRepository {
  @override
  Future<void> fetchPath(String url) {
    // TODO: implement fetchPath
    throw UnimplementedError();
  }

  @override
  Future<void> sendResult(String url) {
    // TODO: implement sendResult
    throw UnimplementedError();
  }
}
