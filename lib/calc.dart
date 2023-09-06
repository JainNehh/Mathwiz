import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class calc extends StatefulWidget {
  const calc({super.key});

  @override
  State<calc> createState() => _calcState();
}

class _calcState extends State<calc> {
  var result = '0';
  var inputUser = '';
  var newstr = '';

  void buttonPressed(String text) {
    setState(() {
      inputUser = inputUser + text;
      // print(inputUser);
      newstr =inputUser.replaceAll("*", "x");
      // print("NewSTR: $newstr");
    });
  }
  Widget getRow(
    String text1,
    String text2,
    String text3,
    String text4,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RawMaterialButton(
          onPressed: () {
            if (text1 == 'AC') {
              setState(() {
                inputUser = '';
                result = '0';
                newstr = '' ;
              });
            } else {
              buttonPressed(text1);
            }
          },
          elevation: 4.0,
          fillColor: getBackgroundColor(text1),
          child: Text(
            text1,
            style: TextStyle(
                color: getTextColor(text1),
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
          padding: EdgeInsets.all(20.0),
          shape: CircleBorder(),
        ),
        RawMaterialButton(
          onPressed: () {
            if (text2 == 'CE') {
              setState(() {
                if (inputUser.length > 0) {
                  inputUser = inputUser.substring(0, inputUser.length - 1);
                  newstr=newstr.substring(0,newstr.length-1);
                }
              });
            } else {
              buttonPressed(text2);
            }
          },
          elevation: 2.0,
          fillColor: getBackgroundColor(text2),
          child: Text(
            text2,
            style: TextStyle(
                color: getTextColor(text2),
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
          padding: EdgeInsets.all(20.0),
          shape: CircleBorder(),
        ),
        RawMaterialButton(
          onPressed: () {
            buttonPressed(text3);
          },
          elevation: 2.0,
          fillColor: getBackgroundColor(text3),
          child: Text(
            text3,
            style: TextStyle(
                color: getTextColor(text3),
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
          padding: EdgeInsets.all(20.0),
          shape: CircleBorder(),
        ),
        RawMaterialButton(
          onPressed: () {
            if (text4 == "x") {
              text4 = "*";
            }

            if (text4 == '=') {
              Parser parser = Parser();
              Expression expression = parser.parse(inputUser);
              ContextModel contextModel = ContextModel();
              double eval =
                  expression.evaluate(EvaluationType.REAL, contextModel);
              setState(() {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          backgroundColor: Colors.transparent,
                          titlePadding: EdgeInsets.only(),
                          title: Column(
                            children: [
                              Container(
                                height: 250,
                                width: 250,
                                child: Center(
                                    // child: Text(result = eval.toString(),textAlign: TextAlign.right,
                                    //   style: TextStyle(color:Colors.black,wordSpacing: 1.0,
                                    //       fontSize: 30),
                                    // ),
                                    ),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("assets/cal.png"),
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ],
                          ),
                        )

                    //
                    // backgroundColor: Colors.transparent,
                    //
                    //   iconPadding: EdgeInsets.zero,
                    //   icon:Image.asset("assets/cal.png",),
                    //   //contentPadding: EdgeInsets.all(100.0,),
                    //   content:Text(result = eval.toString(),style: TextStyle(color:Colors.black),),

                    );
                result = eval.toString();

                // newstr='';
              });
            } else {
              buttonPressed(text4);
            }
          },
          elevation: 2.0,
          fillColor: Color(0xFF72ABEA),
          child: Text(
            text4,
            style: TextStyle(
                fontSize: 40, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          padding: EdgeInsets.all(15.0),
          shape: CircleBorder(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              // title:Text("MathWiz",style:TextStyle(color:Colors.purpleAccent)),
              leading: Image.asset("assets/Mathlogo.png"),
              backgroundColor: Colors.transparent,
              //leading: Image.asset("assets/Mathlogo.png"),
              actions: [
                IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
              ],
            ),
            body: SafeArea(
                child: Column(
              children: [
                Expanded(
                    flex: 25,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                newstr,
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 40,
                                ),
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // Text(
                              //   '=',
                              //   style: TextStyle(
                              //     color: Colors.white,
                              //     fontSize: 80,
                              //   ),
                              // ),
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  result,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 70,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                Expanded(
                    flex: 55,
                    child: Container(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(height: 5),
                        getRow('AC', 'CE', '%', '/'),
                        getRow('1', '2', '3', 'x'),
                        getRow('4', '5', '6', '+'),
                        getRow('7', '8', '9', '-'),
                        getRow('00', '0', '.', '='),
                        Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0))
                      ],
                    )))
              ],
            ))));
  }

  bool isOprator(String text) {
    var list = ['AC', 'CE', '%'];

    for (var item in list) {
      if (text == item) {
        return true;
      }
    }
    return false;
  }

  Color getBackgroundColor(String text) {
    if (isOprator(text)) {
      return Color(0xFFECCDED);
    } else {
      return Color(0xFFFFFFFF);
    }
  }

  bool TextOprator(String text) {
    var list = ['AC', 'CE', '%'];

    for (var item in list) {
      if (text == item) {
        return true;
      }
    }
    return false;
  }

  Color getTextColor(String text) {
    if (isOprator(text)) {
      return Colors.black;
    } else {
      return Color(0xFF2A8E9F);
    }
  }
}
