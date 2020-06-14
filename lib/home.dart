
import 'package:demo/AssessmentPage.dart';
import 'package:demo/MailPage.dart';
import 'package:demo/MePage.dart';
import 'package:demo/login_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:demo/modules/httpconnector.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  static const String _title = 'demo';

  static final storage = FlutterSecureStorage();
  static String user_id;

  Future<bool> initStatus = Future<bool>.value(post_initpage().then((value) => value =='valid'? true: true));
  Future<bool> stayLogin = Future<bool>.value(post_validate().then((value) => value=='ok'? true:false));
  static Future<String> checkHealth() async{
    return await storage.read(key: 'healthState');
  }
  Future<bool> ishealth = Future<bool>.value(checkHealth().then((value) => value=='healthy'?true:false));

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: _title,
      home: FutureBuilder(builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
      if (snapshot.hasData){

        if(snapshot.data[2] == false){
          return AuthScreen();
        }
        print('stateful home, snapshot value: '+snapshot.toString());
        if(snapshot.data[0]== true){
          print('it goes here');
          return Home(isHealth: snapshot.data[1],);
        }
        else if(snapshot.data[0]== false){
          return Home();
        }
        return Container();
      }
      else{
        print('empty home, snapshot value: '+snapshot.toString());
        return Container();
      }

    },
    future: Future.wait([initStatus, ishealth,stayLogin])
      ),);
  }
  }


class Home extends StatefulWidget {
  //boolean health from Submitted widget
  bool isHealth;
  String value;
  Home({Key key,this.isHealth,}) : super (key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  String titleName = "Assessment";
  static var healthStatus = 'Unknown';
  int isExpire;
  Future<void> checkStatus() async{
    return post_initpage().then((String value) => {
    //print("isExpire in checkstatus: "+ isExpire.toString()),
      if(value == 'expire'){
        setState((){
          // isExpire = 1; removed for now, expire will not be set on backend , this does not work
        })
      }
    } );
  }
  List createList() {
    //Check if user has submitted an assessment
    if(widget.isHealth != null){//If there is data
      widget.isHealth? healthStatus ='Healthy' : healthStatus = 'Unhealthy';
    }
    //List of pages from bottom navigation bar
    var _page = [new AssessmentPage(healthStatus: healthStatus),
      new mailPage(),
      new MePage()];
    //print("isExpire in createlist: "+ isExpire.toString());
    if(isExpire == 1){
      _page[0] = new AssessmentPage(healthStatus: 'Unknown');
    }
    return _page;
  }

  //Tapped on bottom navigation bar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement setState
  super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(

      body:
          RefreshIndicator(
            onRefresh: checkStatus,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Container(
                child: createList()[_selectedIndex],
                height: MediaQuery.of(context).size.height,
              ),
            ),

            //Stack(children: createList()[_selectedIndex])
          ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment,size: 40,),
            title: Text('assessment'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail_outline,size: 40,),
            title: Text('mail'),

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline,size: 40,),
            title: Text('person'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
      ),
    );
  }
}