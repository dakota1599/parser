class Parser {
  late String stream;
  late Tokenizer tokenizer;
  late Token lookahead;


  Parser(this.stream) {
    this.tokenizer = new Tokenizer(this.stream);
    this.lookahead = this.tokenizer.getNextToken();
  }

  List<Token> parse() {
    List<Token> body = [new Token(TokenType.Start, "")];

    while (this.lookahead.type != TokenType.Null) {
      body.add(this.lookahead);
      this.lookahead = this.tokenizer.getNextToken();
    }

    body.add(this.lookahead);

    return body;
  }
}

// Creates tokens from text
class Tokenizer {
  int cursor = 0;
  late String string;

  Tokenizer(this.string);

  // Process number literal
  Token numberLiteral() {
    var num = "";
    do {
      num += this.string[this.cursor++];
    } while (
        this.cursor < this.string.length && isNumeric(string[this.cursor]));
    return new Token(TokenType.NumericLitreral, num);
  }

  // Process string literal
  Token stringLiteral() {
    var s = "\"";
    this.cursor++;

    while (this.string[this.cursor] != "\"") {
      s += this.string[this.cursor++];
    }
    s += this.string[this.cursor++];
    return new Token(TokenType.StringLiteral, s);
  }

  // Process keyword
  Token keyword() {
    var s = this.string[this.cursor++];

    while (isAlpha(this.string[this.cursor])) {
      s += this.string[this.cursor++];
    }

    return new Token(TokenType.Keyword, s);
  }

  // Process operator
  Token operator() {
    var op = this.string[this.cursor];
    if (this.cursor + 1 < this.string.length) {
      switch (this.string[this.cursor]) {
        case ":":
        case ";":
          break;
        case "+":
        case "-":
          if (this.string[this.cursor + 1] == this.string[this.cursor]) {
            op += this.string[this.cursor];
            this.cursor++;
          } else if (this.string[this.cursor + 1] == "=") {
            op += "=";
            this.cursor++;
          }
          break;
        case "*":
        case "\/":
          if (this.string[this.cursor + 1] == "=") {
            op += "=";
            this.cursor++;
          }
          break;
      }
    }

    this.cursor++;
    return new Token(TokenType.Operators, op);
  }

  Token getNextToken() {
    // If no more tokens, return the null token.
    if (!hasMoreTokens()) {
      return new Token(TokenType.Null, "");
    }

    // Checks for number literals.
    if (isNumeric((this.string[this.cursor]))) {
      return numberLiteral();
    }

    // Checks for string literals
    if (this.string[this.cursor] == '"') {
      return stringLiteral();
    }

    if (isLetter(this.string[this.cursor])) {
      return keyword();
    }

    if (isOperator(this.string[this.cursor])) {
      return operator();
    }

    // If there is a space, get the next token;
    if (this.string[this.cursor] == ' ') {
      this.cursor++;
      return getNextToken();
    }
    return new Token(TokenType.Null, "");
  }

  // Boolean methods
  bool hasMoreTokens() {
    return this.cursor < string.length;
  }

  bool isNumeric(String s) {
    return RegExp(r'^[0-9]+$').hasMatch(s);
  }

  bool isLetter(String s) {
    return RegExp(r'^[a-zA-Z]+$').hasMatch(s);
  }

  bool isAlpha(String s) {
    return RegExp(r'^[a-zA-Z0-9_]*$').hasMatch(s);
  }

  bool isOperator(String s) {
    switch (s) {
      case "+":
      case "-":
      case "*":
      case "/":
      case ";":
      case ":":
      case "=":
        return true;
    }
    return false;
  }
}

// Token object
class Token {
  late TokenType type;
  late String value;

  Token(this.type, this.value);

  toJson() => {
        'type': this.type,
        'value': this.value,
      };

  toString() {
    return "${this.type}: ${this.value}";
  }
}

// Token Types
enum TokenType {
  Unrecognized,
  NumericLitreral,
  StringLiteral,
  Keyword,
  Operators,
  Null,
  Start
}
