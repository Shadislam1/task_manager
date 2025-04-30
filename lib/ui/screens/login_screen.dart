
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/data/models/login_model.dart';
import 'package:task_manager/ui/controllers/auth_controller.dart';
import 'package:task_manager/ui/screens/main_bottom_nav_screen.dart';
import 'package:task_manager/ui/screens/register_screen.dart';
import 'package:task_manager/ui/widgets/centered_circular_progress_indicator.dart';

import 'package:task_manager/ui/widgets/screen_background.dart';

import '../../data/service/network_client.dart';
import '../../data/utils/urls.dart';
import '../widgets/snack_bar_message.dart';
import 'forgot_password_verify_email_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTEControler = TextEditingController();
  final TextEditingController _passwordTEControler = TextEditingController();
  bool _logInProgress = false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ScreenBackground(
          child: Padding(

            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 80,),
                  Text('Get Started with', style: Theme
                      .of(context)
                      .textTheme
                      .titleLarge),
                  const SizedBox(height: 24,),
                  TextFormField(
                    controller: _emailTEControler,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(

                      hintText: 'Email',



                    ),
                    // validator: (String? value){
                    //   String email = value?.trim() ?? '';
                    //   if(EmailValidator.validate(email)==false){
                    //     return 'Enter a valid email';
                    //   }
                    //   return null;
                    // },
                  ),
                  const SizedBox(height: 24,),

                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: _passwordTEControler,
                    decoration: InputDecoration(

                      hintText: 'Password',

                    ),
                    // validator: (String? value){
                    //   if(value?.trim().isEmpty ?? true ||( value!.length<6)){
                    //     return 'Enter your password more than 6 letters';
                    //   }
                    //   return null;
                    // },
                  ),
                  SizedBox(height: 16,),

                  Visibility(
                    visible: _logInProgress == false,
                    replacement: CenteredCircularProgressIndicator(),
                    child: ElevatedButton(
                    
                      onPressed: _onTapSignInButton,
                      child: Icon(Icons.arrow_circle_right_outlined),
                    ),
                  ),

                  const SizedBox(height: 32,),
                  Center(
                    child: Column(
                      children: [
                        TextButton(onPressed: _onTapForgotPasswordButton,
                          child: Text('Forgot Password'),
                        ),
                        RichText(
                            text: TextSpan(
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                                children: [
                                  TextSpan(text: "Don't have  account ? ",

                                  ),

                                  TextSpan(text: "Sign Up",
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = _onTapSignUpButton,
                                  ),

                                ]
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
  void _onTapSignInButton(){
      if(_formKey.currentState!.validate()){
        _login();
      }
    
  }

  Future<void> _login() async {
    _logInProgress = true;
    setState(() {

    });
    Map<String, dynamic> requestBody ={
      "email": _emailTEControler.text.trim(),
      "password": _passwordTEControler.text,
    };
    NetworkResponse response = await NetworkClient.postRequest(
        url: Urls.loginUrl,
        body:requestBody );
    _logInProgress = false;
    setState(() {

    });

    if(response.isSuccess){
      LoginModel loginModel = LoginModel.fromJson(response.data!);
      //todo  save token local database
        AuthController.saveUserInformation(loginModel.token, loginModel.userModel);
      //todo save local database
      // todo login in or not
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context)=> const MainBottomNavScreen()),
            (predicate)=> false,
      );
    }else{
      showSnackBarMessage(context, response.errorMessage,true);
    }

  }
  void _onTapForgotPasswordButton(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=> ForgotPasswordVertifyEmailScreen()));
  }
    void _onTapSignUpButton(){
        
      Navigator.push(context, MaterialPageRoute(builder: (context)=> RegisterScreen()));
    }
@override
  void dispose() {
    // TODO: implement dispose
  _emailTEControler.dispose();
  _passwordTEControler.dispose();
    super.dispose();
  }
}
