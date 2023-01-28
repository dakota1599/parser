import 'dart:io';
import 'dart:convert';
import "./parser.dart";
import "./exceptsions.dart";

void main(List<String> args) {
  // if (args.isEmpty) {
  //   throw new CommandLineArgumentException();
  // }
  var program = "var myVar = \"hello\"; hello += \"!\"";
  var parser = new Parser(program);
  List<Token> result = parser.parse();

  result.forEach((element) {
    print(element.toString());
  });
}
