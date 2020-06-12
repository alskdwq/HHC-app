import 'dart:convert';

import 'package:http/http.dart' as http;

Future<String> post_initpage(String userId) async{
  var data = {
    'user_id': userId
  };
  var response = await http.post("http://ec2-54-160-79-156.compute-1.amazonaws.com:8080/checkexp",
      body: json.encode(data), headers: {"Content-Type": "application/json"});

  return response.body;
}