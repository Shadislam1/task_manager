
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/main_bottom_nav_screen.dart';
import 'package:task_manager/ui/screens/register_screen.dart';

import 'package:task_manager/ui/widgets/screen_background.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ScreenBackground(
          child: Padding(
            key: _formKey,
            padding: const EdgeInsets.all(16.0),
            child: Form(
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
                  ),
                  const SizedBox(height: 24,),

                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: _passwordTEControler,
                    decoration: InputDecoration(

                      hintText: 'Password',

                    ),
                  ),
                  SizedBox(height: 16,),

                  ElevatedButton(

                    onPressed: _onTapSignInButton,
                    child: Icon(Icons.arrow_circle_right_outlined),
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
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> const MainBottomNavScreen()),
        (predicate)=> false);
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
