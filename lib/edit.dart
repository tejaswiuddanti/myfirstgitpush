import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:polling/API.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import 'AddQuestionsProvider.dart';
import 'Models/QuestionsModel.dart';

class Edit extends StatefulWidget {
  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
    Question mquestion;
String qid;
bool yes=true;
    

   TextEditingController textEditingController= TextEditingController();

   TextEditingController optionAController; 
   TextEditingController optionDController ;
   TextEditingController optionBController ;
   TextEditingController optionCController ;

  addQuestion(int i) async {
    if (textEditingController.text.length < 10) {
      Toast.show("Question should contain atleast 10 characters", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
    else if(optionAController.text.isEmpty){
      Toast.show("Question should have atleast two options", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
    else if(optionBController.text.isEmpty){
      Toast.show("Question should have atleast two options", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
     else {
       
      progressDialog.setMessage("please wait...");
      // progressDialog.show();
      var optiona=optionAController.text;
      var optionb=optionBController.text;
     var optionc=optionCController.text.isEmpty?"NA":optionCController.text;
    var optiond=optionDController.text.isEmpty?"NA":optionDController.text;
      await API.updateQuestionwithOptions( qid,textEditingController.text,optiona,optionb,optionc,optiond).then((response) {
        if (response.status == 'update') {
          //   progressDialog.hide();
           Navigator.of(context).pushNamedAndRemoveUntil('./homepage', (Route<dynamic> route)=>false);
        } else {
          Toast.show("sorry something went wrong", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        }
      });
    }
  }

  ProgressDialog progressDialog;
  




  
  @override
  Widget build(BuildContext context) {
    mquestion=ModalRoute.of(context).settings.arguments;
    print(mquestion);
 if(yes){   
textEditingController.text=mquestion.question;
yes=false;
 }  
     optionAController= TextEditingController(text:mquestion.optionA);
      optionBController= TextEditingController(text:mquestion.optionB);
       optionCController= TextEditingController(text:mquestion.optionC);
        optionDController= TextEditingController(text:mquestion.optionD);
    progressDialog = ProgressDialog(context, ProgressDialogType.Normal);

    final appState = Provider.of<AddQuestionProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Wanna post a Question?"),
      ),
      floatingActionButton: appState.optiond
          ? SizedBox(
              height: 0,
              width: 0,
            )
          : FloatingActionButton(
             child: Icon(Icons.add),
              onPressed: () => appState.showAnother(),
            ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CupertinoTextField(
                placeholder: "Enter your question",
                controller: textEditingController,
              ),
              TextField(
                controller: optionAController,
              ),
              TextField(controller: optionBController),
              appState.optionc
                  ? TextField(controller: optionCController)
                  : SizedBox(
                      height: 0,
                      width: 0,
                    ),
              appState.optiond
                  ? TextField(controller: optionDController)
                  : SizedBox(
                      height: 0,
                      width: 0,
                    ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed:()=> addQuestion(appState.geti),
              )
            ],
          ),
        ),
      ),
    );
  }
}
