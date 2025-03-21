


import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:task_manager/ui/widgets/screen_background.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final  TextEditingController _emailTEControler = TextEditingController();
  final  TextEditingController _firstNameTEControler = TextEditingController();
  final  TextEditingController _lastNameTEControler = TextEditingController();
  final  TextEditingController _mobileTEControler = TextEditingController();
  final  TextEditingController _passwordlTEControler = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ScreenBackground(
          child: SingleChildScrollView(
            child: Padding(
              key: _formKey,
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 80,),
                    Text('Join With Us', style: Theme
                        .of(context)
                        .textTheme
                        .titleLarge),
                    const SizedBox(height: 24,),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailTEControler,
                      decoration: InputDecoration(
                        hintText: 'Email',
                      ),
                    ),
                    const SizedBox(height:8,),
                            
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      controller: _firstNameTEControler,
                      decoration: InputDecoration(
                            
                            
                        hintText: 'First Name',
                      ),
                    ),
                    const SizedBox(height:8,),
                            
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      controller: _lastNameTEControler,
                      decoration: InputDecoration(
                            
                            
                        hintText: 'Last Name',
                      ),
                    ),
                    const SizedBox(height:8,),
                            
                            
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.phone,
                      controller: _mobileTEControler,
                      decoration: InputDecoration(
                            
                            
                        hintText: 'Mobile',
                      ),
                    ),
                    const SizedBox(height:8,),
                            
                    TextFormField(

                      keyboardType: TextInputType.text,
                      controller: _passwordlTEControler,
                      decoration: InputDecoration(
                            
                            
                        hintText: 'Password',
                      ),
                    ),
                    const SizedBox(height:8,),
                            
                    SizedBox(height: 16,),
                            
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
                                TextSpan(text: " Already  Have  an account ? ",
                            
                                ),
                            
                                TextSpan(text: "Sign In",
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
          ),
        )
    );
  }

  void _onTapSubmitButton(){

  }

  void _onTapForgotPasswordButton(){

  }
  void _onTapSignInButton(){
    Navigator.pop(context);

  }

}
