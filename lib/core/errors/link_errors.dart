class LinkException implements Exception {
  final String message;
  LinkException(this.message);

  @override toString() => "LinkException: $message";
}