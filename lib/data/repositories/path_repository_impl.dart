import 'package:injectable/injectable.dart';
import 'package:webspark_test/domain/repositories/path_repository.dart';

import '../../core/errors/app_exception.dart';
import '../../core/result/result.dart';
import '../../domain/entities/path_result.dart';
import '../../domain/entities/path_task.dart';
import '../../domain/entities/submission_result.dart';
import '../mappers/task_mapper.dart';
import '../models/submit_response_dto.dart';
import '../models/task_dto.dart';
import '../network/api_client.dart';

@LazySingleton(as: PathRepository)
class PathRepositoryImpl implements PathRepository {
  PathRepositoryImpl(this._api);

  static const _urlNotSet = AppException('Url is not set');

  final ApiClient _api;

  String? _url;

  @override
  Future<Result<List<PathTask>>> fetchTasks() async {
    if (_url == null) return const Failure<List<PathTask>>(_urlNotSet);

    return switch (await _api.get(_url!)) {
      Success(:final data) => Success(
        TasksResponseDto.fromJson(data).toDomain(),
      ),
      Failure(:final error) => Failure<List<PathTask>>(error),
    };
  }

  @override
  Future<Result<List<SubmissionResult>>> sendResults(
    List<PathResult> results,
  ) async {
    if (_url == null) return const Failure<List<SubmissionResult>>(_urlNotSet);

    final body = results.map((r) => r.toDto().toJson()).toList();
    try {
      return switch (await _api.post(_url!, body: body)) {
        Success(:final data) => Success(
          SubmitResponseDto.fromJson(data).toDomain(),
        ),
        Failure(:final error) => Failure<List<SubmissionResult>>(error),
      };
    } catch (_) {
      return const Failure<List<SubmissionResult>>(
        AppException('Unexpected response from server'),
      );
    }
  }

  @override
  Future<void> saveUrl(String url) async {
    _url = url;
  }
}
