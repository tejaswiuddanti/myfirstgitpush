import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'API.dart';
import 'AddQuestionsProvider.dart';
import 'Models/QuestionsModel.dart';

class Questions extends StatefulWidget {
  @override
  _QuestionsState createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  List<Question> questions = List();
  ProgressDialog progressDialog;
  String uId;
  @override
  initState() {
    getuId();
    super.initState();
    // getQuestions();
  }

  getuId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uId = prefs.getString('uId');
    print(uId);
  }

  getQuestions() {
    API.getQuestionswithOptions().then((response) {
      List<Question> questionsupdated = response.questions;

      setState(() {
        questions = questionsupdated;
        print("objectfired");
      });
    });
  }

  show(String qid) {
    print(qid);
    var alertDialog = AlertDialog(
        title: Text("Do you really want to delete?"),
        actions: <Widget>[
          FlatButton(
            child: const Text('No'),
            onPressed: () {
              //
              Navigator.pop(context);
            },
          ),
          FlatButton(
            child: const Text('YES'),
            onPressed: () {
              API.deleteQuestion(qid).then((response) {
                if (response.message == 'deleted') {
                  getQuestions();
                  Toast.show("deleted sucessfully", context,
                      duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                } else {
                  Toast.show(
                      "sorry some thing went wrong try checking your internet connection",
                      context,
                      duration: Toast.LENGTH_LONG,
                      gravity: Toast.BOTTOM);
                }
              });
              Navigator.pop(context);
            },
          ),
        ]);
    showDialog(
        context: context, builder: (BuildContext context) => alertDialog);
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AddQuestionProvider>(context);
    return Scaffold(
      body: Container(
          child: FutureBuilder(
              future: API.getQuestionswithOptions(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Container(
                    child: Center(
                      child: Text("Loading..."),
                    ),
                  );
                } else {
                  questions = snapshot.data.questions;
                  return ListView.builder(
                      itemCount: questions.length,
                      itemBuilder: (context, index) {
                        print("createdby" + questions[index].createdBy);
                        return ListTile(
                          title: Text(questions[index].question),
                          trailing: (uId == questions[index].createdBy)
                              ? SizedBox(
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                IconButton(
                                                  icon: Icon(
                                                      Icons.delete_outline),
                                                  onPressed: () =>
                                                      show(questions[index].id),
                                                ),
                                                IconButton(
                                                  icon: Icon(Icons.edit),
                                                  onPressed: () => {
                                                        Navigator.pushNamed(
                                                          context,
                                                          './edit',
                                                           arguments:questions[index],)
                                                        .then((onValue) {
                                                          // appState.initValues();
                                                          getQuestions();
                                                        })
                                                      },
                                                ),
                                              ],
                                            ),
                                          ]),
                                    ],
                                  ),
                                  width: 100,
                                )
                              : SizedBox(
                                  height: 0,
                                  width: 0,
                                ),
                          //   ],
                          // ),
                          onTap: () {
                            Navigator.pushNamed(context, './poll',
                                    arguments: questions[index])
                                .then((onValue) {
                              getQuestions();
                            });
                          },
                        );
                      });
                }
              })),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.loupe),
        onPressed: () {
          Navigator.pushNamed(
            context,
            './addQuestions',
          ).then((onValue) {
            appState.initValues();
            getQuestions();
          });
        },
      ),
    );
  }
}
