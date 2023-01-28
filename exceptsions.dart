class CommandLineArgumentException implements Exception {
  String cause = "String stream must be provided through the cli.";

  toString() {
    return this.cause;
  }
}
