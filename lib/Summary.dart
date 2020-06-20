import 'package:demo/Questionnaire.dart';
import 'package:flutter/material.dart';
import 'package:demo/home.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Summary extends StatefulWidget {
  //Data from last page(CheckboxList.dart)
  final Data questionData;
  Summary({Key  key, this.questionData}) : super (key: key);

  @override
  _SummaryState createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {

  //List of strings which print on the screen
  List review = new List();
  List symList = [];
  //Symptoms that the user has
  String syms = '';
  //User health status is true as default
  bool isHealth = true;
  static final storage = FlutterSecureStorage();

  static void setHealthState(bool isHealth) async {
    String status =isHealth==true?'healthy':'unhealthy';
    print('setting the health status: '+ status);
    await storage.write(key: 'healthState', value: isHealth== true?'healthy':'unhealthy');
  }
  Container showReview(){
    Container container = new Container(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(//review with colored border
              margin: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 20
              ),
              height: 400,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(color: Colors.green)
              ),
              child: Center(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: 20,
                top: 40
              ),
                child: Row(
                children: <Widget>[
                  ButtonTheme(
                    minWidth: 140,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.red[900])),
                      onPressed:(){
                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (context) => Home()),
                                (route) => route == null);
                      },
                      color: Colors.red[900],
                      child: Text('Cancel'),
                    ),
                  ),

                  Padding(padding: EdgeInsets.all(20),),
                  ButtonTheme(
                    minWidth: 140,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.green)),
                      onPressed: (){
                        setHealthState(isHealth);
                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (context) => Home(isHealth: isHealth,)),
                                (route) => route == null);
                      },
                      color: Colors.green,
                      child: Text('Submit'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

    );
    return container;
  }

  List<Widget> addReview(List que, List ans){

    return null;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Review',),backgroundColor: Colors.green,centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: new Column(
          children: <Widget>[
            showReview(),
          ],
        )

      ),
    );
  }
}


