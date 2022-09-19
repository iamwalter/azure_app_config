class AzureError implements Exception {
  final String message;

  AzureError(this.message);

  @override
  String toString() {
    return "[AzureError]: $message";
  }
}
