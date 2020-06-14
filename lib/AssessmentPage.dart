import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './Questionnaire.dart';

class AssessmentPage extends StatefulWidget{
  final String healthStatus;

  AssessmentPage({Key key, this.healthStatus}) : super(key:key);
  @override
  State<StatefulWidget> createState(){
    if (healthStatus != 'Unknown'){
      return new StatusKnown();
    } else return new StatusUnknown();
  }
}

class StatusKnown extends State<AssessmentPage> {
  static DateTime now = DateTime.now();
  String time = DateFormat('MM-dd-yyyy').format(now);
  Color bgColor = Colors.green;
  String title = 'Congratulations!';
  String response = 'Your assessment has been submitted.';

  void checkHealth(){
    if(widget.healthStatus == 'Unhealthy'){// user is not healthy
      bgColor = Colors.red;
      title = 'Your status has been recorded';
      response = 'hope you get well soon.';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    checkHealth();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(title: new Text(title),
        backgroundColor: bgColor,
        centerTitle: true,
        elevation: 0,),
      body: Center(child: new Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(response,
              style: TextStyle(color: Colors.white),),
          ),
          Container(

            height: 200,
            width: 300,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 3.0,color: Colors.white),
                borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(time),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Name'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Faculty'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Position'),
                ),
              ],
            ),
          ),
          Padding(padding: const EdgeInsets.all(30),),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Text('You can check it anytime in',style: TextStyle(color: Colors.white),),
                Text('My Status on your user account page',style: TextStyle(color: Colors.white),),
              ],
            ),
          )
        ],
      )),
    );
  }
}

class StatusUnknown extends State<AssessmentPage>{
  //Color for title and background
  Color _backgroundColor = Colors.green;
  Color _textColor = Colors.white;

  //Tap on plus icon
  void _onTap(){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Questionnaire()), (route) => route == null);
  }

  @override
  Widget build (BuildContext context){
    return new Scaffold(
        backgroundColor: _backgroundColor,
        appBar: AppBar(
          title: Text("Assessment", style: TextStyle(color: _textColor),),
          backgroundColor: _backgroundColor, centerTitle: true,elevation: 1,
    ),
      body: new Center(// Assessment Page
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FloatingActionButton(
               onPressed: _onTap,
              child:Icon(Icons.add_circle_outline, color: _textColor,size: 60,) ,
              backgroundColor: _backgroundColor,
              elevation: 0,

            ),
            Text("Start self assessment for today",
              style: TextStyle(color: _textColor),),
          ],
        ),
      ),
    );
  }
}