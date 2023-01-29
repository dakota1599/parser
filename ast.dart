import './parser.dart';
import './store/store.dart';
class AST{
    late List<Token> _tokens;
    late Token _current;
    int _cursor = 0;


    AST(this._tokens){
        this._current = this._tokens[0];
    }

    generateTree(){
      
      while(hasMoreTokens()){

        switch(this._current.type){
          case TokenType.Start:
            break;
          case TokenType.NumericLitreral:
            numericLiteral();
            break;
        }

        this._current = this._tokens[++this._cursor];
      }

    }

    numericLiteral(){

    }

    bool hasMoreTokens(){
      return this._current.type != TokenType.Null && this._cursor < this._tokens.length;
    }
    
}