class ItemException implements Exception {
  final String message;
  ItemException(this.message);

  @override toString() => "ItemException: $message";
}

class ItemUnownedException implements Exception {
  final String message;
  ItemUnownedException(this.message);

  @override String toString() => "ItemUnownedExecption: $message";
}

class BorrowerMissingException implements Exception {
  final String message;
  BorrowerMissingException(this.message);

  @override toString() => "BorrowerMissingException: $message";
}

class DateRangeInvalidException implements Exception {
  final String message;
  DateRangeInvalidException(this.message);
  @override toString() => "DateRangeInvalidException: $message";
}