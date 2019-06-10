import 'package:flutter/material.dart';
import 'package:polling/API.dart';
import 'package:polling/Models/Answers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class AnsweredQuestions extends StatefulWidget {
  @override
  _AnsweredQuestionsState createState() => _AnsweredQuestionsState();
}

class _AnsweredQuestionsState extends State<AnsweredQuestions> {
  List<Answer> results = List();
   String uId;
  @override
  void initState() {
    super.initState();
    getResults();
      getuId();
  }
  getuId() async {
  SharedPreferences prefs=await SharedPreferences.getInstance();
     uId=prefs.getString('uId');
     print(uId);
}

  getResults() async {
    await API.getAnswerswithoptions().then((response) {
      setState(() {
        results = response.answers;
      });
    });
  }
show(String qid){
  print(qid);
 var alertDialog =AlertDialog( title: Text("Do you really want to delete?"),
   actions: <Widget>[
        
          FlatButton(
            child: const Text('No'),
            onPressed: () {
           //  Toast.show("deleted sucessfully", context,duration: Toast.LENGTH_LONG,gravity: Toast.BOTTOM);
             Navigator.pop(context);
                         },
                       ),
                       FlatButton(
                         child: const Text('YES'),
                         onPressed: () {
                     API.deleteQuestion(qid).then((response){
                      print(response.message);
                    if(response.message=='deleted'){
                       getResults();
                         Toast.show("deleted sucessfully", context,duration: Toast.LENGTH_LONG,gravity: Toast.BOTTOM);
                         }
                         else {Toast.show("sorry some thing went wrong try checking your internet connection", context,duration: Toast.LENGTH_LONG,gravity: Toast.BOTTOM);}
                     });
                       Navigator.pop(context);
                         },),
               ]);
               showDialog(
                 context: context,
                 builder: (BuildContext context)=>alertDialog
               
               );
             }
             
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
          future: API.getAnswerswithoptions(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: Text("Loading..."),
                ),
              );
            } else {
              print(snapshot.data.answers.length);
              return ListView.builder(
                  itemCount: snapshot.data.answers.length,
                  itemBuilder: (context, index) {
                  
                    return Card(
                      child: Column(
                        children: <Widget>[
                          ListTile(title: Text("Q:" + snapshot.data.answers[index].question),
                          trailing:(uId==snapshot.data.answers[index].createdBy)? IconButton(icon: Icon(Icons.delete_outline),onPressed: ()=>show(snapshot.data.answers[index].id),):SizedBox(height: 0,width: 0,) ,),
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(snapshot
                                        .data.answers[index].optionA +'('+snapshot
                                        .data.answers[index]. acount+')'+
                                    "(" +
                                    snapshot.data.answers[index].percentageA +
                                    ")"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(snapshot
                                        .data.answers[index].optionB +'('+snapshot
                                        .data.answers[index]. bcount+')'+
                                    "(" +
                                    snapshot.data.answers[index].percentageB +
                                    ")"),
                              ),
                              snapshot.data.answers[index].optionC != "NA"
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          snapshot.data.answers[index].optionC +'('+snapshot
                                        .data.answers[index]. ccount+')'+
                                              "(" +
                                              snapshot.data.answers[index]
                                                  .percentageC +
                                              ")"),
                                    )
                                  : SizedBox(
                                      height: 0,
                                      width: 0,
                                    ),
                              snapshot.data.answers[index].optionD != "NA"
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          snapshot.data.answers[index].optionD +'('+snapshot
                                        .data.answers[index]. dcount+')'+
                                              "(" +
                                              snapshot.data.answers[index]
                                                  .percentageD +
                                              ")"),
                                    )
                                  : SizedBox(
                                      height: 0,
                                      width: 0,
                                    ),
                                Text("Your Ans:" +
                                  snapshot.data.answers[index].answer)
                            ],
                          )
                        ],
                      ),
                    );
                  });
            }
          }),
    );
  }
}
