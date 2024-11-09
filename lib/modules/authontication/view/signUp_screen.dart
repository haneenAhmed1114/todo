import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/models/user_data_model.dart';
import 'package:todo_application/modules/authontication/provider/auth_provider.dart';
import 'package:todo_application/modules/authontication/view/login_screen.dart';
import 'package:todo_application/modules/home_screen/home_screen.dart';
import 'package:todo_application/shared/remote/firebase_services.dart';
import 'package:todo_application/shared/utils/app_colors.dart';

import '../../../shared/reusable_components/custom_auth_textField.dart';
import '../../../shared/reusable_components/custom_elevated_button.dart';
import '../../../shared/reusable_components/task_provider.dart';

class SignupScreen extends StatefulWidget {
  static const String routeName ='signUpScreen';

   SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isPassword = false ;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.whiteAppColor,
      body:SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height*0.1,
              ),
              Image.asset('assets/images/logoAutho.png',width: 120),
              const SizedBox(
                height: 20.0,
              ),
              const Text(
                'please enter your e-mail address \n and enter your password',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.greyAppColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Pacifico',
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              CustomAuthTextfield(
                  hintText: 'Enter your name',
                  prefixIcon: Icons.person,
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  validator: (p0) {
                    if(p0==null || p0.isEmpty)
                    {
                      return 'email musn\'t be empty';
                    }
                    else if(p0.length<7)
                    {
                      return 'email musn\'t be less than 7 characters';
                    }
                    else
                    {
                      return null ;
                    }
                  },
              ),
              CustomAuthTextfield(
                hintText: 'Enter your email',
                prefixIcon: Icons.email_outlined,
                controller: emailController ,
                keyboardType: TextInputType.emailAddress,
                validator: (p0) {
                  if(isValidEmail(p0 ?? ''))
                  {
                    return null;
                  }
                  else
                  {
                    return 'Invalid Email';
                  }
                },
              ),
              CustomAuthTextfield(
                hintText: 'Enter your password',
                prefixIcon: Icons.lock_outline_rounded,
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
                suffixIcon: isPassword ? Icons.visibility_off: Icons.visibility,
                isPassword: isPassword,
                suffixPressed: ()
                {
                  setState(() {
                    isPassword=!isPassword;
                  });
                },
                validator:(p0) {
            if(p0==null || p0.isEmpty)
            {
            return 'password musn\'t be empty';
            }
            else if(p0.length<7)
            {
            return 'password musn\'t be less than 7 characters';
            }
            else
            {
            return null ;
            }
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.2,
              ),
              SizedBox(
                width: 220.0,
                height: 50.0,
                child:  Provider.of<localAuthProvider>(context).loading ? Center(child: CircularProgressIndicator()) : CustomElevatedButton(onPressed: ()async
                {
                  if(formKey.currentState!.validate())
                    {
                    await Provider.of<localAuthProvider>(context,listen: false).register(UserDataModel(
                         name: nameController.text,
                         email: emailController.text),
                         passwordController.text).then((value) {
                       if(Provider.of<localAuthProvider>(context,listen:false).userDataModel!=null)
                      {
                       // Provider.of<TaskProvider>(context,listen: false).getTasksByDate();
                        Navigator.of(context).pushNamed(HomeScreen.routeName);
                      }
                       },
                    );
                    }
                }, text:'Register',),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Have an account?'),
                  TextButton(onPressed: () {
                    Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
                  }, child: Text('Login',),),
                ],
              ),
              Row(
                children: [
                  Expanded(child: Divider(indent: 10,endIndent: 10,),),
                  Text('OR'),
                  Expanded(child: Divider(indent: 10,endIndent: 10,),),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton.filled(onPressed: () {}, icon: Icon(Icons.facebook , color: AppColors.blackAppColor,),style: IconButton.styleFrom(backgroundColor: AppColors.textFieldLightColor),),
                  IconButton.filled(onPressed: () {}, icon: Icon(Icons.facebook ,color: AppColors.blackAppColor,),style: IconButton.styleFrom(backgroundColor: AppColors.textFieldLightColor)),
                  IconButton.filled(onPressed: () {}, icon: Icon(FontAwesomeIcons.google,color: AppColors.blackAppColor,),style: IconButton.styleFrom(backgroundColor: AppColors.textFieldLightColor),),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
  bool isValidEmail(String inputEmail)
  {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(inputEmail);
  }
  register()async
  {
    try
    {
     await FirebaseServices.register(UserDataModel(name: nameController.text,email: emailController.text), passwordController.text);
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
