abstract interface class PathRepository {

  Future<void> saveUrl(String url);

  Future<void> fetchPath();

  Future<void> sendResult();
}