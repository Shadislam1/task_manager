



import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/ui/screens/login_screen.dart';


import 'package:task_manager/ui/widgets/screen_background.dart';


class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _newPasswordTEControler = TextEditingController();
  final TextEditingController _confirmNewPasswordTEControler = TextEditingController();

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
                      'Set Password',
                      style: Theme.of(context).textTheme.titleLarge),
                  SizedBox(height: 4,),
                  Text(
                      'Set a new password minimum length of 6 letters ',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.grey
                      )),
                  const SizedBox(height: 24,),
                  TextFormField(
                    controller: _newPasswordTEControler,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: 'New Password',
                    ),
                  ),
                  SizedBox(height: 8,),
                  TextFormField(
                    controller: _confirmNewPasswordTEControler,
                    decoration: InputDecoration(
                      hintText: ' Confirm New Password',
                    ),
                  ),
                  const SizedBox(height: 24,),



                  ElevatedButton(


                    onPressed: _onTapSubmitButton,
                    child: Text('Confirm'),
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
                              TextSpan(
                                text: "Don't have  account ? ",

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

    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginScreen()),
          (pre)=> false,
    );
  }

  void _onTapSignInButton(){

    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginScreen()),
          (pre)=> false,
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _newPasswordTEControler.dispose();
    _confirmNewPasswordTEControler.dispose();
    super.dispose();
  }

}
