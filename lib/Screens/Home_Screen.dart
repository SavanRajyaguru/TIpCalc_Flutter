import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _tipPercentage = 0;
  int _personCounter = 1;
  double _billAmount = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery
            .of(context)
            .size
            .height * 0.1),
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(10.0),
          children: [
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                color: Colors.lightBlue[50],
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Total Per Person",
                    style: TextStyle(
                      letterSpacing: 1,
                      fontSize: 18.0,
                      // color: Color(0X6908D6).withOpacity(1),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "\u20B9${calculateTotalPerPerson(
                          _billAmount, _personCounter, _tipPercentage)}",
                      style: TextStyle(
                          fontSize: 45.0,
                          // color: Color(0X6908D6).withOpacity(1),
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                    color: Colors.black87,
                    style: BorderStyle.solid
                ),
              ),
              child: Column(
                children: [
                  TextField(
                    keyboardType: TextInputType.numberWithOptions(
                        decimal: true),
                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: "Bill Amount:",
                      hintStyle: TextStyle(
                        color: Colors.black,
                          letterSpacing: 1
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    onChanged: (String value) {
                      try {
                        _billAmount = double.parse(value);
                      } catch (exception) {
                        _billAmount = 0.0;
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Split", style: TextStyle(
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold,
                        // color: Color(0X6908D6).withOpacity(1),
                        fontSize: 16.0,
                      ),),
                      Container(
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  if (_personCounter > 1) {
                                    _personCounter--;
                                  }
                                });
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                margin: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: Colors.lightBlue[50],
                                  borderRadius: BorderRadius.circular(7.0),
                                ),
                                child: Center(
                                  child: Text("-", style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),),
                                ),
                              ),
                            ),
                            Text("$_personCounter", style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 17.0,
                            ),),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _personCounter++;
                                });
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                margin: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: Colors.lightBlue[50],
                                  borderRadius: BorderRadius.circular(7.0),
                                ),
                                child: Center(
                                  child: Text("+", style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                  ),),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Tip", style: TextStyle(
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold,
                        // color: Color(0X6908D6).withOpacity(1),
                        fontSize: 16.0,
                      ),),
                      Padding(
                        padding: const EdgeInsets.all(17.0),
                        child: Text(
                          "\u20B9${(calculateTotalTip(
                              _billAmount, _personCounter, _tipPercentage))
                              .toStringAsFixed(2)}",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                          ),),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text("$_tipPercentage%", style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0,
                        color: Colors.black,
                      ),),
                      Slider(
                        min: 0,
                        max: 100,
                        divisions: 10,
                        // activeColor: Color(0X9608D6).withOpacity(1),
                        // inactiveColor: Color(0X6908D6).withOpacity(0.3),
                        value: _tipPercentage.toDouble(),
                        onChanged: (double newValue) {
                          setState(() {
                            _tipPercentage = newValue.round();
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

calculateTotalPerPerson(double billAmount, int spiltBy, int tipPercentage) {
  var totalPerPerson = (calculateTotalTip(
      billAmount, spiltBy, tipPercentage) + billAmount) / spiltBy;
  return totalPerPerson.toStringAsFixed(2);
}

calculateTotalTip(double billAmount, int spiltBy, int tipPercentage) {
  double totalTip = 0.0;

  if (billAmount < 0 || billAmount
      .toString()
      .isEmpty || billAmount == null) {
    //to go!
  } else {
    totalTip = (billAmount * tipPercentage) / 100;
  }
  return totalTip;
}