import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:polling/API.dart';
import 'package:polling/Models/QuestionsModel.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';


class Poll extends StatefulWidget {
  

   
  @override
  _PollState createState() => _PollState();
}

class _PollState extends State<Poll> {
String question;
ProgressDialog progressDialog;
 Question mquestion;

pollNo() async
{

   var connectivityResult=await (Connectivity().checkConnectivity());
     if(connectivityResult==ConnectivityResult.mobile || connectivityResult==ConnectivityResult.wifi)
     {
     
   
progressDialog.setMessage("Polling");
progressDialog.show();
await API.pollOpinion(mquestion.id, "NO").then((response)
{
  if(response.status=='sucess'){
  progressDialog.hide();
  Navigator.of(context).pop();
  }
  else
  {   progressDialog.hide();
     Toast.show("sorry", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  }
});}
else{
   Toast.show("Please check your internet-connection", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
}
}
pollOption(String option,String opinion) async
{
var connectivityResult=await (Connectivity().checkConnectivity());
     if(connectivityResult==ConnectivityResult.mobile || connectivityResult==ConnectivityResult.wifi)
     {
     
progressDialog.setMessage("Polling");
progressDialog.show();
await API.pollOpinionWithOptions(mquestion.id,option,opinion).then((response)
{
  if(response.status=='sucess'){
  progressDialog.hide();
  Navigator.of(context).pop();
  }
  else
  { progressDialog.hide();
     Toast.show("sorry", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  }
});
}
pollYes() async
{
   var connectivityResult=await (Connectivity().checkConnectivity());
     if(connectivityResult==ConnectivityResult.mobile || connectivityResult==ConnectivityResult.wifi)
     {
     
progressDialog.setMessage("Polling");
progressDialog.show();
await API.pollOpinion(mquestion.id,"YES").then((response)
{
  if(response.status=='sucess'){
  progressDialog.hide();
  Navigator.of(context).pop();
  }
  else
  { progressDialog.hide();
     Toast.show("sorry", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  }
});
}
else{
   Toast.show("Please check your internet-connection", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
}
}
}
 
  @override
  Widget build(BuildContext context) {
   mquestion=ModalRoute.of(context).settings.arguments;
    
    progressDialog=ProgressDialog(context,ProgressDialogType.Normal);
    return Scaffold(
      appBar: AppBar(
        title: Text("Question"),
      ),
          body: Container(
            
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(mquestion.question),
            SizedBox(
              height: 30,
            ),Column(
                
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
               
                Padding(
                  padding: EdgeInsets.all(10),
                                  child: RaisedButton(
                  
                    child: Text(mquestion.optionA),
                    onPressed:()=> pollOption("optionA",mquestion.optionA),
                  ),
                ),Padding(
                  padding: EdgeInsets.all(10),
                                  child: RaisedButton(
                     padding: EdgeInsets.all(10),
                    child: Text(mquestion.optionB),
                    onPressed:()=> pollOption("optionB",mquestion.optionB),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                                  child: mquestion.optionC=="NA"?SizedBox(height: 0,width: 0,):RaisedButton(
                     padding: EdgeInsets.all(10),
                    child: Text(mquestion.optionC),
                    onPressed:()=> pollOption("optionC",mquestion.optionC),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                                  child:mquestion.optionD=="NA"?SizedBox(height: 0,width: 0,): RaisedButton(
                     padding: EdgeInsets.all(10),
                    child: Text(mquestion.optionD),
                    onPressed:()=> pollOption("optionD",mquestion.optionD),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}