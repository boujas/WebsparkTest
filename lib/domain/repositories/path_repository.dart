abstract interface class PathRepository {

  Future<void> fetchPath(String url);

  Future<void> sendResult(String url);
}