import 'dart:io';

import 'package:flutter/material.dart';
import 'API.dart' ;
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:connectivity/connectivity.dart';
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  ProgressDialog progressDialog;

bool _load = false;
   _logo() async {


     progressDialog.setMessage("Authenticating..");
    
 //print('connected');
// try {
//   print('connected');
//   final result = await InternetAddress.lookup('google.com');
//   if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//     print('connected');
//   }
// } on SocketException catch (_) {
//   print('not connected');
// }

     var connectivityResult=await (Connectivity().checkConnectivity());
     if(connectivityResult==ConnectivityResult.mobile || connectivityResult==ConnectivityResult.wifi)
     {
      progressDialog.show();
    print("conn");
   
    API.getting(username.text).then((response) async {
      if (response.status == "sucess") {
      final prefs=await SharedPreferences.getInstance();
      prefs.setBool('loginstatus',true );
      prefs.setString("uId", response.uid);
      progressDialog.hide();
        Navigator.pushReplacementNamed(context, './homepage');
      } else {
        progressDialog.hide();
        Toast.show("please enter valid username", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    });
     }
     else
     {
        print("no-conn");
      // progressDialog.hide();
       Toast.show("Please check your internet-connection", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
     }
  }

  TextEditingController username = new TextEditingController();

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  @override
  Widget build(BuildContext context) {

    progressDialog=ProgressDialog(context,ProgressDialogType.Normal);
    final userfield = TextField(
      controller: username,
      obscureText: false,
  
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 30),
        hintText: "UserName",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(45)),
      ),
    );
    final loginButton = Material(
      borderRadius: BorderRadius.circular(54),
      color: Colors.blue,
      child: MaterialButton(
        onPressed: _logo,
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
              color: Colors.white,
            )),
      ),
    );
    
    
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 200,
                child: Image.asset("images/logo.png"),
                ),
                // SizedBox(
                //   height: 4,
                // ),
                SizedBox(
                  height: 23,
                ),
                userfield,
                SizedBox(
                  height: 22                ),
                   SizedBox(
                  height: 0,width: 0          ),
                loginButton,
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
