


import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/forgot_password_pin_verification_screen.dart';
import 'package:task_manager/ui/screens/register_screen.dart';

import 'package:task_manager/ui/widgets/screen_background.dart';


class ForgotPasswordVertifyEmailScreen extends StatefulWidget {
  const ForgotPasswordVertifyEmailScreen({super.key});

  @override
  State<ForgotPasswordVertifyEmailScreen> createState() => _ForgotPasswordVertifyEmailScreenState();
}

class _ForgotPasswordVertifyEmailScreenState extends State<ForgotPasswordVertifyEmailScreen> {
  final  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTEControler = TextEditingController();

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
                  Text(
                      'Your Email Adress',
                      style: Theme.of(context).textTheme.titleLarge),
                  SizedBox(height: 4,),
                  Text(
                      'A 6 digit verification pin will be send to your email ',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.grey
                      )),
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



                  ElevatedButton(

                    onPressed: _onTapSubmitButton,
                    child: Icon(Icons.arrow_circle_right_outlined),
                  ),

                  const SizedBox(height: 32,),
                  Center(
                    child: RichText(
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
                                  ..onTap = _onTapSignInButton,
                              ),

                            ]
                        )),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }


  void _onTapSubmitButton(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=> ForgotPasswordPinVertifyScreen()));
  }
  void _onTapSignInButton(){

    Navigator.pop(context);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _emailTEControler.dispose();
    super.dispose();
  }

}
