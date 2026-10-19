import 'package:injectable/injectable.dart';
import 'package:webspark_test/domain/repositories/path_repository.dart';

@LazySingleton(as: PathRepository)
class PathRepositoryImpl implements PathRepository {

  String? _url;

  @override
  Future<void> fetchPath() {
    // TODO: implement fetchPath
    throw UnimplementedError();
  }

  @override
  Future<void> sendResult() {
    // TODO: implement sendResult
    throw UnimplementedError();
  }

  @override
  Future<void> saveUrl(String url) async {
    _url = url;
  }
}
