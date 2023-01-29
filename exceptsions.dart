class CommandLineArgumentException implements Exception {
  String cause = "String stream must be provided through the cli.";

  toString() {
    return this.cause;
  }
}

class NonOperableException implements Exception {
  String cause = "This operation is not operable.";

  toString() {
    return this.cause;
  }
}