class BusinessLogicException implements Exception {
  final List<String> errors;
  BusinessLogicException(this.errors);

  @override
  String toString() => 'Business logic error(s): ${errors.join(', ')}';
}
