import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../models/user_data_model.dart';
import '../../../shared/remote/firebase_services.dart';
import '../../../shared/utils/app_colors.dart';

class localAuthProvider with ChangeNotifier
{
  bool loading = false ;
  UserDataModel? userDataModel ;
  Future login(String email , String password)async
  {
    loading = true ;
    notifyListeners();
    try
    {
     userDataModel =  await FirebaseServices.login(email,password);
     notifyListeners();
     // Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
     loading = false ;
     notifyListeners();
    }
    catch(error)
    {
      loading = false ;
      notifyListeners();
      String? message ;
      if(error is FirebaseAuthException)
      {
        message = error.message;
      }
      Fluttertoast.showToast(
        msg: message ?? 'SomeThing Went Wrong',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.redAppColor,
        textColor: AppColors.whiteAppColor,
        fontSize: 16.0,
      );
    }
  }
  Future register(UserDataModel userDataModel, String password)async
  {
    try
    {
     userDataModel = await FirebaseServices.register(userDataModel,password);
     notifyListeners();
    }
    catch(error) {
      String? message;
      if (error is FirebaseAuthException) {
        message = error.message;
      }
      Fluttertoast.showToast(
        msg: message ?? 'SomeThing Went Wrong',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.redAppColor,
        textColor: AppColors.whiteAppColor,
        fontSize: 16.0,
      );
    };
  }
}