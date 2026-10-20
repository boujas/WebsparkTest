abstract final class UrlValidator {
  static bool isValid(String raw) {
    final value = raw.trim();
    if (value.isEmpty) return false;

    final uri = Uri.tryParse(value);
    final isHttp =
        uri != null && (uri.scheme == 'http' || uri.scheme == 'https');
    if (!isHttp || uri.host.isEmpty) {
      return false;
    }
    return true;
  }
}
