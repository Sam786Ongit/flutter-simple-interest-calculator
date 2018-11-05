import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Simple Interest Calculator',
    home: SimpleInterest(),
    theme: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.indigo,
      accentColor: Colors.indigoAccent,
    ),
  ));
}

class SimpleInterest extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _SimpleInterestState();
  }
}

class _SimpleInterestState extends State<SimpleInterest> {
  var _currencies = ['Rupees', 'Dollars'];
  var _currentItemSelected ='';

  void initState() { 
    super.initState();
    _currentItemSelected = _currencies[0];
  }
  var _displayResult = '';
  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Simple Interest Calculator'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: getImageAsset(),
            ),
            /*text field 1*/
            Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: principalController,
                decoration: InputDecoration(
                  labelText: 'Principal Amount',
                  hintText: 'Enter Principal amount eg: 12000',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
              ),
            ),
            /*text field 2*/
            Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: roiController,
                decoration: InputDecoration(
                  labelText: 'Rate of Interest',
                  hintText: 'In Percentage',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: termController,
                    decoration: InputDecoration(
                      labelText: 'Term',
                      hintText: 'Term in Years',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                  ),
                ),
                Container(width: 20.0),
                Expanded(
                  child: DropdownButton<String>(
                    items: _currencies.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    value: _currentItemSelected,
                    onChanged: (String newValueSelected) {
                      _onDropdownItemSelected(newValueSelected);
                    },
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).accentColor,
                      child: Text('Calculate'),
                      onPressed: () {
                        setState(() {
                          this._displayResult=_calculateTotalReturns();
                        });
                      },
                    ),
                  ),
                  Container(width: 10.0),
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).accentColor,
                      child: Text('Reset'),
                      onPressed: () {
                        setState(() {
                         _resetInputs();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5.0),
              child: Text(_displayResult),
            ),
          ],
        ),
      ),
    );
  }

  Widget getImageAsset() {
    AssetImage logo = AssetImage('images/logo2.png');
    Image image = Image(
      image: logo,
      width: 125.0,
      height: 125.0,
    );
    return Container(child: image);
  }

  void _onDropdownItemSelected(String newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected;
    });
  }

  String _calculateTotalReturns(){
    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);

    double totalAmountPayable = principal + (principal * roi * term) / 100;
 
    var result = "After $term years, your total amount payable is $totalAmountPayable";
    return result;
  }

  void _resetInputs(){
    principalController.text='';
    roiController.text='';
    termController.text='';
     _displayResult='';
     _currentItemSelected=_currencies[0];

  }
}
