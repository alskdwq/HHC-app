import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<String> post_initpage() async{
  final storage = FlutterSecureStorage();
  String userId;
  await storage.read(key: 'user_id').then((String value) => {
    userId = value
  });
//  print('checking user_id: '+userId);
  var data = {
    'user_id': userId
  };
  var response = await http.post("http://ec2-54-160-79-156.compute-1.amazonaws.com:8080/checkexp",
      body: json.encode(data), headers: {"Content-Type": "application/json"});
  print('questionnaire expire status: '+ response.body);
  return response.body;
}

Future<String> post_validate() async{
  final storage = FlutterSecureStorage();
  String userId;
  String token;
  await storage.read(key: 'user_id').then((String value) => {
    userId = value
  });
  await storage.read(key: 'token').then((String value) => {
    token = value
  });
  var data = {
    'user_id': userId,
    'token':token
  };
  var response = await http.post("http://ec2-54-160-79-156.compute-1.amazonaws.com:8080/validate",
      body: json.encode(data), headers: {"Content-Type": "application/json"});
  print('validate status: '+ response.body);
  return response.body;
}

Future<void> signout() async {
  final storage = FlutterSecureStorage();
  String userId;
  await storage.read(key: 'user_id').then((String value) => {
    userId = value
  });
  var data = {
    'user_id': userId,
  };
  final response = await http
      .post('http://ec2-54-160-79-156.compute-1.amazonaws.com:8080/signout',body: json.encode(data)
    );
  print('signed out');
  return response.body;
}