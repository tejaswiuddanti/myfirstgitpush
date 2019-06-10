import 'package:flutter/material.dart';
import 'package:polling/answered.dart';
import 'package:polling/questions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
 
  @override
  Widget build(BuildContext context) {
    
     
    return 
    DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            actions: <Widget>[
              IconButton(icon: Icon(Icons.power_settings_new),
              onPressed: ()
              async {
                final prefs=await SharedPreferences.getInstance();
      prefs.setBool('loginstatus',false );
      Navigator.pushNamedAndRemoveUntil(context,'./login', (Route<dynamic> route) => false);
      
              },)
            ],
            bottom: TabBar(
              tabs: [
                Text("Questions"),
                Text("Answered Questions"),
              ],
            ),
            title: Text('Poll'),
          ),
          body: TabBarView(
            children: [
             Questions(),
             AnsweredQuestions(),
            
            ],
          ),
      //      floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.loupe),
      //   onPressed: () {
      //      Navigator.pushNamed(context, './addQuestions',
      //     ).then((onValue){
              
      //           });
      //   },
      // ),
        ),
    );
  }
}



