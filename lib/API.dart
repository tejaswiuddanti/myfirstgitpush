import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:polling/Models/Answers.dart';
import 'package:polling/Models/LoginResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';


import 'Models/CommonResponse.dart';
import 'Models/QuestionsModel.dart';


const baseurl = "http://toobworks.com/flutter/";
class API {


  static Future getting(String username) async {
    var url = baseurl + "userlogin.php";
    final response = await http.post(url, body: {
      "username": username,
    });
    return compute(parsingLoginDetails, response.body);
  }

 
   static Future getQuestionswithOptions() async {

     SharedPreferences prefs=await SharedPreferences.getInstance();
    var uId=prefs.getString('uId');
    var url = baseurl + "get_questions_with_options.php";
    final response = await http.post(url, body: {
        "uId":uId,
    });
    return compute(parsingQues, response.body);
  }

   static Future pollOpinion(String id,String opinion) async {
     SharedPreferences prefs=await SharedPreferences.getInstance();
    var uId=prefs.getString('uId');
    var url = baseurl + "poll_opinion.php";
    final response = await http.post(url, body: {
        "qId":id,
        "opinion":opinion,
        "uId":uId
    });
    return compute(parsing, response.body);
  }

   static Future deleteQuestion(String qid) async {
    print(qid);
    var url = baseurl + "delete_question_with_options.php";
    final response = await http.post(url, body: {
        "qid":qid,   
    });
    return compute(parsing, response.body);
  }


static Future updateQuestionwithOptions(String qid,String question,String optionA,String optionB,String optionC,String optionD) async {
    var url = baseurl + "update_question_with_options.php";
   
     SharedPreferences prefs=await SharedPreferences.getInstance();
    var uId=prefs.getString('uId');
    
    final response = await http.post(url, body: {
       "uId":uId,
       "qid":qid,
       "question": question,
       "optionA":optionA,
       "optionB":optionB,
       "optionC":optionC,
       "optionD":optionD
       });
       return compute(parsing, response.body);
  }




  static Future pollOpinionWithOptions(String id,String option,String opinion ) async {
     SharedPreferences prefs=await SharedPreferences.getInstance();
    var uId=prefs.getString('uId');
    var url = baseurl + "poll_opinion_with_options.php";
    final response = await http.post(url, body: {
        "qId":id,
        "opinion":opinion,
        "option":option,
        "uId":uId
    });
    return compute(parsing, response.body);
  }

  
  static Future getAnswerswithoptions() async {

    var url = baseurl + "get_answers_with_options.php";
    SharedPreferences prefs=await SharedPreferences.getInstance();
    var uId=prefs.getString('uId');
    final response = await http.post(url, body: {
        "uId":uId,
    });
    return compute(parsingAnswers, response.body);
  }


  

   static Future addQuestionwithOptions(String question,String optionA,String optionB,String optionC,String optionD) async {
    var url = baseurl + "add_questions_with_options.php";
   
     SharedPreferences prefs=await SharedPreferences.getInstance();
    var uId=prefs.getString('uId');
    final response = await http.post(url, body: {
       "uId":uId,
       "question": question,
       "optionA":optionA,
       "optionB":optionB,
       "optionC":optionC,
       "optionD":optionD
       });
       return compute(parsing, response.body);
  }
}



CommonResponse parsing(String response) {
  final parsed = json.decode(response);
return CommonResponse.fromJson(parsed);
}

LoginResponse parsingLoginDetails(String response) {
  final parsed = json.decode(response);

  return LoginResponse.fromJson(parsed);
}

QuestionsModel parsingQues(String response) {

 
  final parsed = jsonDecode(response);


  return QuestionsModel.fromJson(parsed);
     
}

AnswersModel parsingAnswers(String response)
{
   final parsed = jsonDecode(response);


  return AnswersModel.fromJson(parsed);
}
