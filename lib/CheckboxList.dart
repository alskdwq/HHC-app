import 'package:demo/YesNo.dart';
import 'package:flutter/material.dart';
import 'package:demo/Summary.dart';

//Data package from this page
class CheckboxData {
  bool travel = false;
  bool closeL = false;
  bool closeW = false;
  List symptoms = [false,false,false,false,false,false,false,false];

  CheckboxData({this.travel, this.closeL, this.closeW, this.symptoms});
}

class CheckboxList extends StatefulWidget{
  //Data from last page(YesNo.dart)
  final Data yndata;
  CheckboxList({Key key,this.yndata}) : super (key: key);

  @override
  CheckboxListPage createState() => new CheckboxListPage();
}

class CheckboxListPage extends State<CheckboxList>{
  static TextStyle _bold = new TextStyle(fontWeight: FontWeight.bold);
  final CheckboxData checkboxData = CheckboxData();
  var checkList =[false,false,false,false,false,false,false,false];
  var symptomsList = [
    Text('Fever or chill', style: _bold),
    Text('New or worsening respiratory illness', style: _bold),
    Text('Runny nose, sneezing or nasal congestion', style: _bold),
    Text('Fatigue or malaise', style: _bold),
    Text('No taste or no smell', style: _bold),
    Text('Digestive symptoms', style: _bold),
    Text('Headache', style: _bold),
    Text('None of above', style: _bold),
  ];

  //tap on submit button
  void submit(){
    setState(() {
      //If the checkboxes are empty, click on last box instead
      bool isEmpty = true;
      for (var s in checkList){
        if (s) isEmpty = false;
      }
      if (isEmpty) checkList[7] = true;

      //Packaging data and move to next page with data
      checkboxData.symptoms = checkList;
      checkboxData.closeL = widget.yndata.closeContactL;
      checkboxData.closeW = widget.yndata.closeContactW;
      checkboxData.travel = widget.yndata.travel;
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => Summary()),
              (route) => route == null);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Questionnaire',),backgroundColor: Colors.green,centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: new Column(
            children: <Widget>[
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.all(10),),
                    Text('Are you currently experiencing any of these symptoms? Choose any/all that apply.',
                      style:_bold,),

                    Row(
                      children: <Widget>[
                        Checkbox(
                          activeColor: Colors.grey,
                          value: checkList[0],
                          onChanged: (bool newValue) {
                            setState(() {
                              if(newValue==true){checkList[7]=false;}
                              checkList[0] = newValue;
                            });
                          },
                        ),
                        Padding(padding: EdgeInsets.all(5),),
                        symptomsList[0],
                      ],
                    ),
                    Padding(padding: EdgeInsets.all(10),),

                    Row(
                      children: <Widget>[
                        Checkbox(
                          activeColor: Colors.grey,
                          value: checkList[1],
                          onChanged: (bool newValue) {
                            setState(() {
                              if(newValue==true){checkList[7]=false;}
                              checkList[1] = newValue;
                            });
                          },
                        ),
                        Padding(padding: EdgeInsets.all(5),),
                        symptomsList[1],
                      ],
                    ),
                    Padding(padding: EdgeInsets.all(10),),

                    Row(
                      children: <Widget>[
                        Checkbox(
                          activeColor: Colors.grey,
                          value: checkList[2],
                          onChanged: (bool newValue) {
                            setState(() {
                              if(newValue==true){checkList[7]=false;}
                              checkList[2] = newValue;
                            });
                          },
                        ),
                        Padding(padding: EdgeInsets.all(5),),
                        symptomsList[2],
                      ],
                    ),
                    Padding(padding: EdgeInsets.all(10),),
                    Row(
                      children: <Widget>[
                        Checkbox(
                          activeColor: Colors.grey,
                          value: checkList[3],
                          onChanged: (bool newValue) {
                            setState(() {
                              if(newValue==true){checkList[7]=false;}
                              checkList[3] = newValue;
                            });
                          },
                        ),
                        Padding(padding: EdgeInsets.all(5),),
                        symptomsList[3],
                      ],
                    ),
                    Padding(padding: EdgeInsets.all(10),),

                    Row(
                      children: <Widget>[
                        Checkbox(
                          activeColor: Colors.grey,
                          value: checkList[4],
                          onChanged: (bool newValue) {
                            setState(() {
                              if(newValue==true){checkList[7]=false;}
                              checkList[4] = newValue;
                            });
                          },
                        ),
                        Padding(padding: EdgeInsets.all(5),),
                        symptomsList[4],
                      ],
                    ),
                    Padding(padding: EdgeInsets.all(10),),

                    Row(
                      children: <Widget>[
                        Checkbox(
                          activeColor: Colors.grey,
                          value: checkList[5],
                          onChanged: (bool newValue) {
                            setState(() {
                              if(newValue==true){checkList[7]=false;}
                              checkList[5] = newValue;
                            });
                          },
                        ),
                        Padding(padding: EdgeInsets.all(5),),
                        symptomsList[5],
                      ],
                    ),
                    Padding(padding: EdgeInsets.all(10),),

                    Row(
                      children: <Widget>[
                        Checkbox(
                          activeColor: Colors.grey,
                          value: checkList[6],
                          onChanged: (bool newValue) {
                            setState(() {
                              if(newValue==true){checkList[7]=false;}
                              checkList[6] = newValue;
                            });
                          },
                        ),
                        Padding(padding: EdgeInsets.all(5),),
                        symptomsList[6],
                      ],
                    ),
                    Padding(padding: EdgeInsets.all(10),),

                    //None of above
                    Row(
                      children: <Widget>[
                        Checkbox(
                          activeColor: Colors.grey,
                          value: checkList[7],
                          onChanged: (bool newValue) {
                            setState(() {
                              if(newValue == true) checkList.fillRange(0, 7, false);
                              checkList[7] = newValue;
                            });
                          },
                        ),
                        Padding(padding: EdgeInsets.all(5),),
                        symptomsList[7],
                      ],
                    ),
                    Padding(padding: EdgeInsets.all(10),),
                    Center(
                      child: ButtonTheme(
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.green)),
                          child: Text('Submit'),
                          color: Colors.green,
                          onPressed: submit,
                      ),
                        minWidth: 200.0,
                      ),),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}