import 'package:flutter/material.dart';
import 'package:polling/addQuestions.dart';
import 'package:polling/poll.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './homepage.dart';
import './login.dart';
import 'package:provider/provider.dart';

import 'AddQuestionsProvider.dart';
import 'edit.dart';
void main() => runApp(MyApp());



class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

Widget  go=Login();
@override
void initState()
{
   
  super.initState();
login();
   

}
 Future login() async
 {
   SharedPreferences prefs = await SharedPreferences.getInstance();
   var status=prefs.getBool('loginstatus')??false;
   if(status){
  setState(() {
    go=MyHomePage();
  });
 }}

  @override
  Widget build(BuildContext context) {

    
    return MultiProvider(
  providers: [
     ChangeNotifierProvider(
        builder: (_)=>AddQuestionProvider(),
      ),
  ],
          child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Polling',
        theme: ThemeData(
        primarySwatch: Colors.blue,
        ),
       
         home:go ,
         routes: <String,WidgetBuilder>{
           './homepage':(BuildContext context)=>MyHomePage(),
           './addQuestions':(BuildContext context)=>AddQuestions(),
            './poll':(BuildContext context)=>Poll(),
            './edit':(BuildContext context)=>Edit(),
            './login':(BuildContext context)=>Login(),
         },
      ),
    );
  }
}
