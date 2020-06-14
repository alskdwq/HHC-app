import 'package:flutter/material.dart';
import './CheckboxList.dart';


//Data package which sends to next page
class Data {
  bool travel = false;
  bool closeContactL = false;
  bool closeContactW = false;
  void setTravel(){travel = true;}
  void setCloseContactLive(){closeContactL = true;}
  void setCloseContactWork(){closeContactW = true;}
}

class Questionnaire extends StatefulWidget{

  @override
  PageQuestionnaire createState() => new PageQuestionnaire();
}

class PageQuestionnaire extends State<Questionnaire>{
  int _index = 0;
  static TextStyle _size30Bold =  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  //List of questions packaged by container
  List questions = [
    //Question 1
    Container(
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Have you travelled outside of Ontario?',
                style:_size30Bold,
              ),
              Padding(padding: EdgeInsets.all(50),),
              Text('Person who travelled outside of Ontario advise to self-isolated for 14 days.'),
            ],
          ),
        ),
      ),
    ),
    //Question 2
    Container(
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(padding: EdgeInsets.all(10),),
              Text('In the last 14 days, have you been in close physical contact with someone you live with who test positive for COVID-19?',
                style: _size30Bold,
              ),
              Padding(padding: EdgeInsets.all(40),),
              Text('  Close physical contact means:'),
              Padding(padding: EdgeInsets.all(10),),
              Text('• being less than 2 metres away in the same area for over 15 minutes', style: new TextStyle(fontWeight: FontWeight.bold),),
              Padding(padding: EdgeInsets.all(10),),
              Text('• living in the same home', style: new TextStyle(fontWeight: FontWeight.bold),),
            ],
          ),
        ),
      ),
    ),
    //Question 3
    Container(
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(padding: EdgeInsets.all(10),),
              Text('In the last 14 days, have you been in close physical contact with someone at work who test positive for COVID-19?',
                style: _size30Bold,
              ),
              Padding(padding: EdgeInsets.all(40),),
              Text('  Close physical contact means:'),
              Padding(padding: EdgeInsets.all(10),),
              Text('• being less than 2 metres away in the same area for over 15 minutes', style: new TextStyle(fontWeight: FontWeight.bold),),
              Padding(padding: EdgeInsets.all(10),),
              Text('• living in the same home', style: new TextStyle(fontWeight: FontWeight.bold),),
            ],
          ),
        ),
      ),
    ),
  ];

  final data = Data();

  //Tap on button no
  //Check whether the question list is finish; if finish, move to next page with data
  void tapNo(){
    setState(() {
      _index == questions.length - 1 ? Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => CheckboxList(yndata:data)),(route) => route == null): _index++;
    });
  }

  //Tap on button yes
  //Set data depending on current index
  //Check whether the question list is finish; if finish, move to next page with data
  void tapYes(){
    setState(() {
      switch(_index){
        case 0:{
          data.setTravel();
          break;
        }
        case 1:{
          data.setCloseContactLive();
          break;
        }
        case 2:{
          data.setCloseContactWork();
          break;
        }
        default:{
          //do nothing
          break;
        }
      }
      _index == questions.length - 1 ? Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => CheckboxList(yndata:data)),
              (route) => route == null): _index++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Questionnaire',),backgroundColor: Colors.green,centerTitle: true,
        ),
        body: new Column(
          children: <Widget>[
            questions[_index],
            Center(
              child: Container(
                margin: EdgeInsets.only(
                    left: 20,
                  bottom: 30
                ),
                child: Row(
                children: <Widget>[
                  ButtonTheme(
                    minWidth: 150.0,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.green)),
                      onPressed: tapNo,
                      color: Colors.green,
                      child: Text('No'),
                    ),
                  ),

                  Padding(padding: EdgeInsets.all(15),),
                  ButtonTheme(
                    minWidth: 150.0,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.red[900])),
                      onPressed: tapYes,
                      color: Colors.red[900],
                      child: Text('Yes'),
                    ),
                  ),
                ],
              ),),
            ),
          ],
        )
    );
  }
}