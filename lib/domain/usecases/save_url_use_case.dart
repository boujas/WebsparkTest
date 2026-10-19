import 'package:injectable/injectable.dart';
import 'package:webspark_test/domain/repositories/path_repository.dart';

import '../../core/utils/url_validator.dart';
import '../errors/app_exception.dart';

@injectable
class SaveUrlUseCase{
  SaveUrlUseCase(this._repository);

  final PathRepository _repository;

  Future<void> call(String url) async {
    final isValid = UrlValidator.isValid(url);
    if (!isValid) throw AppException("Invalid URL");
    _repository.saveUrl(url);
  }

}