import 'dart:convert';

import 'package:chatbot_update/data/model/reply_model.dart';
import 'package:chatbot_update/data/model/sent_model.dart';
import 'package:chatbot_update/resources/strings/strings.dart';
import 'package:http/http.dart' as http;

abstract class Repository{
  Future<List<Reply>> getreplies(String sender,String message);
}

class RepositoryImplementation implements Repository{
  @override
  Future<List<Reply>> getreplies(String sender,String message) async {
    
      Sent sentMessage = Sent(sender,message);
      var _jsonMessage = jsonEncode(sentMessage);
       Map<String, String> requestHeaders = {
       'Content-type': 'application/json'
     };
      print(_jsonMessage);
      var jsonResponse;
      var response =await http.post(AppStrings.url,body: _jsonMessage,headers: requestHeaders);
      var statusCode = response.statusCode;
      print(statusCode);
      if(statusCode==200){
        jsonResponse = json.decode(utf8.decode(response.bodyBytes));
        var parsedResponse = ReplyArray.fromJson(jsonResponse);
        var list = parsedResponse.replies;
        return list;
      }
      else{
        throw Exception();
      }

  }

}