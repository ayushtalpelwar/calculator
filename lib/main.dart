import 'package:calculator/colors.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MaterialApp(
    home: CalculatorApp(),
  ));
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  var input='';
  var output='';
  var hideinput=false;
  var outputsize=34.0;

  onButtonClick(value){
    if(value=="AC"){
      input='';
      output='';
    }
    else if(value=="<"){
      if(input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    }
    else if(value=="="){
      if(input.isNotEmpty) {
        var userinput = input;
        userinput = input.replaceAll("x", "*");
        Parser p = Parser();
        Expression expression = p.parse(userinput);
        ContextModel cm = ContextModel();
        var result = expression.evaluate(EvaluationType.REAL, cm);
        output = result.toString();
        hideinput=true;
        outputsize=54.0;
      }
    }
    else{
      input=input+value;
      hideinput=false;
      outputsize=34.0;
    }
    setState(() {

    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(14),
              color: Colors.red,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    hideinput?" ":input,
                    style: TextStyle(fontSize: 48, color: Colors.white),
                  ),
                  SizedBox(height: 20),
                  Text(
                    output,
                    style: TextStyle(fontSize: outputsize, color: Colors.white.withOpacity(0.7)),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
          Row(
            children: [
              button(
                  text: "AC", buttonbgcolor: operatorColor, color: orangeColor),
              button(
                  text: "<", buttonbgcolor: operatorColor, color: orangeColor),
              button(text: "", color: Colors.transparent),
              button(
                  text: "/", buttonbgcolor: operatorColor, color: orangeColor),
            ],
          ),
          Row(
            children: [
              button(text: "7"),
              button(text: "8"),
              button(text: "9"),
              button(
                  text: "x", buttonbgcolor: operatorColor, color: orangeColor),
            ],
          ),
          Row(
            children: [
              button(text: "4"),
              button(text: "5"),
              button(text: "6"),
              button(
                  text: "-", buttonbgcolor: operatorColor, color: orangeColor),
            ],
          ),
          Row(
            children: [
              button(text: "1"),
              button(text: "2"),
              button(text: "3"),
              button(
                  text: "+", buttonbgcolor: operatorColor, color: orangeColor),
            ],
          ),
          Row(
            children: [
              button(
                  text: "%", buttonbgcolor: operatorColor, color: orangeColor),
              button(text: "0"),
              button(text: "."),
              button(text: "=", buttonbgcolor: Colors.red),
            ],
          ),
        ],
      ),
    );
  }

  Widget button({text, color = Colors.white, buttonbgcolor = buttonColor}) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(22),
              backgroundColor: buttonbgcolor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15))),
          onPressed: () =>onButtonClick(text),
          child: Text(
            text,
            style: TextStyle(
                color: color, fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
