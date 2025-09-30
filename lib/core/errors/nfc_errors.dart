class NFCException extends Error {
  final String message;
  NFCException(this.message);
  @override toString() => "NFCException: $message";
}