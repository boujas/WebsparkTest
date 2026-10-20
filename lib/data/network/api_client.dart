import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../core/errors/app_exception.dart';
import '../../core/result/result.dart';

typedef Json = Map<String, dynamic>;

@lazySingleton
class ApiClient {
  ApiClient(this._dio);

  final Dio _dio;

  Future<Result<Json>> get(String url) => _send(() => _dio.get<Object?>(url));

  Future<Result<Json>> post(String url, {required Object body}) => _send(
    () => _dio.post<Object?>(
      url,
      data: body,
      options: Options(contentType: Headers.jsonContentType),
    ),
    allowEmptyBody: true,
  );

  Future<Result<Json>> _send(
    Future<Response<Object?>> Function() request, {
    bool allowEmptyBody = false,
  }) async {
    try {
      final response = await request();
      final data = response.data;

      if (allowEmptyBody && (data == null || data == '')) {
        return const Success<Json>({});
      }

      final json = _asJson(data);
      if (json == null) {
        return const Failure<Json>(
          AppException('Unexpected response from server'),
        );
      }
      if (json['error'] == true) {
        return Failure<Json>(AppException(_asMessage(json) ?? 'Server error'));
      }
      return Success<Json>(json);
    } on DioException catch (e) {
      return Failure<Json>(
        AppException(e.message ?? 'Unexpected network error'),
      );
    } catch (_) {
      return const Failure<Json>(
        AppException('Unexpected response from server'),
      );
    }
  }

  Json? _asJson(Object? data) {
    try {
      final decoded = data is String ? jsonDecode(data) : data;
      return decoded is Json ? decoded : null;
    } catch (_) {
      return null;
    }
  }

  String? _asMessage(Json json) {
    final message = json['message'];
    return message is String && message.isNotEmpty ? message : null;
  }
}
