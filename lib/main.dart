import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const Calculator());
}
class Calculator extends StatefulWidget {
  const Calculator({super.key});
  @override
  State<Calculator> createState() => _CalculatorState();
}
class _CalculatorState extends State<Calculator> {
  @override
  Widget build(BuildContext context) {
    return const Application();
  }
}
class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}
class _ApplicationState extends State<Application> {
  var inputuser = '';
  var Result='';
  void Bottonpessed(String text){
    setState(() {
      inputuser = inputuser + text;
    });
  } 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _getbody(),
    );
  }
  Widget _getbody(){
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(inputuser,
                      textAlign: TextAlign.end,
                      style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 28),
                      ),
                    ),
                    Padding(padding: const EdgeInsets.all(8),
                    child: Text(Result,style: const TextStyle(fontSize: 62),textAlign: TextAlign.end,),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Container(
                color: Colors.grey[700],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                  _getRowNumbers('ac','ce','%','/'),
                  _getRowNumbers('1','2','3','*'),
                  _getRowNumbers('4','5','6','-'),
                  _getRowNumbers('7','8','9','+'),
                  _getRowNumbers('00','0','.','='),
               
                ],)
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget _getRowNumbers(String Text1,String Text2,String Text3,String Text4) {
    return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: _getbackgroundColor(Text1),
                      shape: const CircleBorder(
                        side: BorderSide(width: 0,color: Colors.transparent)
                      )
                    ),
                    onPressed: (){
                      if(Text1 == 'ac'){
                        setState(() {
                          inputuser = '';
                          Result = '';
                        }
                        );
                      }else{
                        Bottonpessed(Text1);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(Text1,style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold,color:  _getoperatorcolor(Text1)),textAlign: TextAlign.center),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: _getbackgroundColor(Text2),
                      shape: const CircleBorder(
                        side: BorderSide(width: 0,color: Colors.transparent)
                      )
                    ),
                    onPressed: (){
                      if(Text2 == 'ce'){
                        setState(() {
                          if(inputuser.length >0 ){
                               inputuser = inputuser.substring(0,inputuser.length-1);
                          }else{
                            inputuser = '';
                          }
                       
                        });
                      }else{
                         Bottonpessed(Text2);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(Text2,style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold,color:  _getoperatorcolor(Text2)),textAlign: TextAlign.center),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: _getbackgroundColor(Text3),
                      shape: const CircleBorder(
                        side: BorderSide(width: 0,color: Colors.transparent)
                      )
                    ),
                    onPressed: (){
                       Bottonpessed(Text3);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(Text3,style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold,color:  _getoperatorcolor(Text3)),textAlign: TextAlign.center),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: _getbackgroundColor(Text4),
                      shape: const CircleBorder(
                        side: BorderSide(width: 0,color: Colors.transparent)
                      )
                    ),
                    onPressed: (){
                      if(Text4 == '='){
                        Parser p = Parser();
                        Expression expression = p.parse(inputuser);
                        ContextModel contextModel = ContextModel();
                        double result = expression.evaluate(EvaluationType.REAL, contextModel);
                        setState(() {
                          Result = result.toString();
                        });
                      }else{
                       Bottonpessed(Text4);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(Text4,style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold,color:  _getoperatorcolor(Text4)),textAlign: TextAlign.center,),
                    ),
                  ),
                ],
              );
  }
  bool _isoperator(String text){
    var list = ['ac','ce','%','/','*','-','+','='];
    for (var item in list) {
      if (item == text){
        return true;
      }
    }
    return false;
  }
  Color _getoperatorcolor(String text){
    if(_isoperator(text)){
      return Colors.black;
    }else{
      return Colors.white;
    }
  }
  Color _getbackgroundColor(String text){
    if(_isoperator(text)){
      return Colors.red;
    }else{
      return Colors.grey;
    }
  }
}