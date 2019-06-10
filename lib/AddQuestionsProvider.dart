import 'package:flutter/foundation.dart';

class AddQuestionProvider extends ChangeNotifier
{
  bool optionc=false;
  bool optiond=false;
  int i=2;

   showAnother(){
    i++;
    if(i==3)
    {
      optionc=true;
    }else{
      optiond=true;
    }
    notifyListeners();
  }

  bool get showOptione=>optionc;
   bool get showOptionr=>optiond;
  int get geti=>i;
   initValues(){
     optionc=false;
     optiond=false;
     i=2;
     notifyListeners();
   }
}