import 'dart:math';
import 'dart:convert';
import 'package:demo/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(215, 117, 255, 1).withOpacity(0.5),
                  Color.fromRGBO(255, 188, 117, 1).withOpacity(0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0, 1],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20.0),
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 94.0),
                      //transform: Matrix4.rotation(-8*pi/180)
                      // ..translate(-10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.deepOrange.shade900,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 8,
                            color: Colors.black26,
                            offset: Offset(0, 2),
                          )
                        ],
                      ),
                      child: Text(
                        'Demo',
                        style: TextStyle(
                          color: Theme.of(context).accentTextTheme.title.color,
                          fontSize: 50,
                          fontFamily: 'Anton',
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: AuthCard(),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> with SingleTickerProviderStateMixin{
  final GlobalKey<FormState> _formKey = GlobalKey();
  final userNameController = TextEditingController();
  final userPasswordController = TextEditingController();
  final userFirstNameController = TextEditingController();
  final userLastNameController = TextEditingController();
  final userFacilityController = TextEditingController();
  final userPositionController = TextEditingController();
  AnimationController _controller;
  Animation<Size> _heightAnimation;
  final storage = FlutterSecureStorage();
  @override
  void initState(){
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 300,
        ),
    );
    _heightAnimation = Tween<Size>(
      begin: Size(double.infinity, 260), end: Size(double.infinity, 320))
      .animate(
        CurvedAnimation(
          parent: _controller,
          curve: Curves.fastOutSlowIn,
        ),
      );
    
  }
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;

  @override
  void dispose(){
    super.dispose();
    _controller.dispose();
  }

  Future<void> _submit() async {
  
    if (!_formKey.currentState.validate()) {
      // Invalid!
      print("Invalid!!");
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (_authMode == AuthMode.Login) {
      // log user in
      const url = 'http://ec2-54-160-79-156.compute-1.amazonaws.com:8080/signin';
      print("Log user in..");
      try {
        Map<String, String> headers = {"Content-Type":"application/json"};
        
        final response = await http
            .post(url, headers:headers,
                body: jsonEncode(<String, String>
                  {
                    'username': userNameController.text,
                    'password': userPasswordController.text,
                  }
                ),);
        if(response.body.toString() == 'logged'){// remove denied
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MyApp()), (route) => route == null);
        }
        final responseData = response.body;
        print("response from server\n" + responseData);
      } catch (error) {
        throw error;
      }
    } else {
      //sign user up
      const url = 'http://ec2-54-160-79-156.compute-1.amazonaws.com:8080/signup';
      print("Sign user up..");
      try {
        Map<String, String> headers = {"Content-Type":"application/json"};
        
        final response = await http
            .post(url, headers:headers,
                body: jsonEncode(
                  {
                    'email': userNameController.text,
                    'password': userPasswordController.text,
                    'position': userPositionController.text,
                    'facility': userFacilityController.text,
                    'first': userFirstNameController.text,
                    'last': userLastNameController.text,
                  }
                ),)
        
        ;
        final responseData = response.body;
        Map jsonData = json.decode(responseData);
        await storage.write(key: "token", value: jsonData['token'].toString());
        await storage.write(key: "user_id", value: jsonData['user_id'].toString());
        await storage.write(key: "name", value: jsonData['first'].toString()+' '+jsonData['last'].toString());
        print("response from server\n" + responseData);
        showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text('Success'),
                  content: Text('Sign Up Complete!'),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Okay'),
                      onPressed: () {
                        Navigator.of(ctx).pop();
                        setState(() {
                          _authMode = AuthMode.Login;
                        });
                        _controller.reverse();
                      },
                    )
                  ],
                ));
      } catch (error) {
        throw error;
      }

    }
    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: AnimatedBuilder(animation: _heightAnimation, builder: (ctx,  ch) => Container(
        //height: _authMode == AuthMode.Signup ? 500 : 260,
        height: _heightAnimation.value.height,
        constraints:
            BoxConstraints(minHeight: _heightAnimation.value.height),
        width: deviceSize.width * 0.75,
        padding: EdgeInsets.all(16.0),
        child: ch), 
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'E-mail'),
                  controller: userNameController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@')) {
                      return 'Invalid email!';
                    }
                  },
                  onSaved: (value) {
                    _authData['email'] = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  controller: userPasswordController,
                  validator: (value) {
                    if (value.isEmpty || value.length < 5) {
                      return 'Password is too short!';
                    }
                  },
                  onSaved: (value) {
                    _authData['password'] = value;
                  },
                ),
                if (_authMode == AuthMode.Signup)
              
                  TextFormField(
                    enabled: _authMode == AuthMode.Signup,
                    decoration: InputDecoration(labelText: 'Confirm Password'),
                    obscureText: true,
                    validator: _authMode == AuthMode.Signup
                        ? (value) {
                            if (value != userPasswordController.text) {
                              return 'Passwords do not match!';
                            }
                          }
                        : null,
                  ),
                

                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    enabled: _authMode == AuthMode.Signup,
                    decoration: InputDecoration(labelText: 'First Name'),
                    controller: userFirstNameController,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Invalid First Name';
                      }
                    },
                    // onSaved: (value){
                    //   _authData['email'] = value;
                    // },
                  ),
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Last Name'),
                    controller: userLastNameController,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Invalid Last Name';
                      }
                    },
                    // onSaved: (value){
                    //   _authData['email'] = value;
                    // },
                  ),
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Facility'),
                    controller: userFacilityController,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Invalid Facility';
                      }
                    },
                    // onSaved: (value){
                    //   _authData['email'] = value;
                    // },
                  ),
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Position'),
                    controller: userPositionController,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Invalid Position';
                      }
                    },
                    // onSaved: (value){
                    //   _authData['email'] = value;
                    // },
                  ),
                SizedBox(
                  height: 20,
                ),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  RaisedButton(
                    child:
                        Text(_authMode == AuthMode.Login ? 'LogIn' : 'Sign Up'),
                    onPressed: _submit,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                    color: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).primaryTextTheme.button.color,
                  ),
                FlatButton(
                  child: Text(
                      '${_authMode == AuthMode.Login ? 'SignUp' : 'LogIn'} Instead'),
                  onPressed: _switchAuthMode,
                  padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  textColor: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
