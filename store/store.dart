import 'dart:math';

import '../exceptsions.dart';
class Store<T>{
  Type type = T;
  late T value;

  Store(this.value);

}

abstract class Operation{
  late List<String> operands = [];
  late OperationType type;
  late String operator;

  Operation(this.type, this.operator, this.operands);

  calculate();
}

class MathOperation implements Operation{
  late List<String> operands = [];
  late OperationType type;
  late String operator;
  late bool operable;
  late bool isInt;

  MathOperation(this.type, this.operator, this.operands){
    this.operable = this.type != OperationType.Single;
    this.operands.forEach((element) => {
      if(element.contains(".")){
        this.isInt = false
      }
    });
  }

  @override
  calculate() {
    if(!this.operable) return new NonOperableException();
    switch(this.type){
      case OperationType.LeftSingle: return leftSingle();
      case OperationType.RightSingle: return rightSingle();
      case OperationType.Double: return double();
      default: return new NonOperableException();
    }
  }

  leftSingle(){
    switch(this.operator){
      case "+":
        if(this.isInt){
          return int.parse(this.operands[0]).abs();
        }
    }
  }

  rightSingle(){}

  double(){}

}

enum OperationType{
  Single,
  LeftSingle,
  RightSingle,
  Double,
}