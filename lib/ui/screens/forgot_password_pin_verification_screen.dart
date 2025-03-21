



import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/ui/screens/login_screen.dart';
import 'package:task_manager/ui/screens/reset_password_screen.dart';


import 'package:task_manager/ui/widgets/screen_background.dart';


class ForgotPasswordPinVertifyScreen extends StatefulWidget {
  const ForgotPasswordPinVertifyScreen({super.key});

  @override
  State<ForgotPasswordPinVertifyScreen> createState() => _ForgotPasswordPinVertifyScreenState();
}

class _ForgotPasswordPinVertifyScreenState extends State<ForgotPasswordPinVertifyScreen> {
  final  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _pinCodeTEControler = TextEditingController();

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
                      'Pin Verification',
                      style: Theme.of(context).textTheme.titleLarge),
                  SizedBox(height: 4,),
                  Text(
                      'A 6 digit verification pin has been send to your email ',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.grey
                      )),
                  const SizedBox(height: 24,),
                  PinCodeTextField(
                    keyboardType: TextInputType.number,
                    length: 6,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                    selectedFillColor: Colors.white,
                      inactiveFillColor: Colors.white,
                    ),
                    animationDuration: Duration(milliseconds: 300),
                    backgroundColor: Colors.transparent,
                    enableActiveFill: true,

                    controller: _pinCodeTEControler,
                    onCompleted: (v) {
                      print("Completed");
                    },

                    appContext: context,

                  ),
                  const SizedBox(height: 24,),



                  ElevatedButton(


                    onPressed: _onTapSubmitButton,
                    child: Text('Verify'),
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
        Navigator.push(context, MaterialPageRoute(builder: (context)=> ResetPasswordScreen()));
    }

  void _onTapSignInButton(){

    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginScreen()),
        (pre)=> false,
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _pinCodeTEControler.dispose();
    super.dispose();
  }
}
