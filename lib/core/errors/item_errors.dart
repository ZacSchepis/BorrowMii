class ItemException implements Exception {
  final String message;
  ItemException(this.message);

  @override toString() => "ItemException: $message";
}