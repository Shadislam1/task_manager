//
//
//
// import 'package:email_validator/email_validator.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:task_manager/data/service/network_client.dart';
// import 'package:task_manager/data/utils/urls.dart';
// import 'package:task_manager/ui/widgets/centered_circular_progress_indicator.dart';
//
// import 'package:task_manager/ui/widgets/screen_background.dart';
// import 'package:task_manager/ui/widgets/snack_bar_message.dart';
//
//
// class RegisterScreen extends StatefulWidget {
//   const RegisterScreen({super.key});
//
//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }
//
// class _RegisterScreenState extends State<RegisterScreen> {
//   final  TextEditingController _emailTEControler = TextEditingController();
//   final  TextEditingController _firstNameTEControler = TextEditingController();
//   final  TextEditingController _lastNameTEControler = TextEditingController();
//   final  TextEditingController _mobileTEControler = TextEditingController();
//   final  TextEditingController _passwordlTEControler = TextEditingController();
//   bool _registrationInProgress = false;
//
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: ScreenBackground(
//           child: SingleChildScrollView(
//             child: Padding(
//
//               padding: const EdgeInsets.all(16.0),
//               child: Form(
//                 key: _formKey,
//                 autovalidateMode: AutovalidateMode.onUserInteraction,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const SizedBox(height: 80,),
//                     Text('Join With Us', style: Theme
//                         .of(context)
//                         .textTheme
//                         .titleLarge),
//                     const SizedBox(height: 24,),
//                     TextFormField(
//                       textInputAction: TextInputAction.next,
//                       keyboardType: TextInputType.emailAddress,
//                       controller: _emailTEControler,
//                       decoration: InputDecoration(
//                         hintText: 'Email',
//                       ),
//                       validator: (String? value){
//                         String email = value?.trim() ?? '';
//                         if(EmailValidator.validate(email)==false){
//                           return 'Enter a valid email';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height:8,),
//
//                     TextFormField(
//                       textInputAction: TextInputAction.next,
//                       keyboardType: TextInputType.text,
//                       controller: _firstNameTEControler,
//                       decoration: InputDecoration(
//
//
//                         hintText: 'First Name',
//                       ),
//                       validator: (String? value){
//                         if(value?.trim().isEmpty ?? true){
//                           return 'Enter your first name';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height:8,),
//
//                     TextFormField(
//                       textInputAction: TextInputAction.next,
//                       keyboardType: TextInputType.text,
//                       controller: _lastNameTEControler,
//                       decoration: InputDecoration(
//
//
//                         hintText: 'Last Name',
//                       ),
//                       validator: (String? value){
//                         if(value?.trim().isEmpty ?? true){
//                           return 'Enter your last name';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height:8,),
//
//
//                     TextFormField(
//                       textInputAction: TextInputAction.next,
//                       keyboardType: TextInputType.phone,
//                       controller: _mobileTEControler,
//                       decoration: InputDecoration(
//
//
//                         hintText: 'Mobile',
//                       ),
//                       validator: (String? value){
//                         String phone = value?.trim() ?? '';
//                         RegExp regExp = RegExp(r"^(?:\+?88|0088)?01[15-9]\d{8}$");
//                         if(regExp.hasMatch(phone)== false){
//                           return 'Enter your  valid phone';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height:8,),
//
//                     TextFormField(
//
//                       keyboardType: TextInputType.text,
//                       controller: _passwordlTEControler,
//                       autovalidateMode: AutovalidateMode.onUserInteraction,
//                       decoration: InputDecoration(
//
//
//                         hintText: 'Password',
//                       ),
//                       validator: (String? value){
//                         if(value?.trim().isEmpty ?? true ||( value!.length<6)){
//                           return 'Enter your password more than 6 letters';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height:8,),
//
//                     SizedBox(height: 16,),
//
//                     Visibility(
//                       visible: _registrationInProgress == false,
//                       replacement: CenteredCircularProgressIndicator(),
//                       child: ElevatedButton(
//                         onPressed: _onTapSubmitButton,
//
//
//                         child: Icon(Icons.arrow_circle_right_outlined),
//                       ),
//                     ),
//
//                     const SizedBox(height: 32,),
//                     Center(
//                       child: RichText(
//                           text: TextSpan(
//                               style: TextStyle(
//                                 color: Colors.black54,
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 14,
//                               ),
//                               children: [
//                                 TextSpan(text: " Already  Have  an account ? ",
//
//                                 ),
//
//                                 TextSpan(text: "Sign In",
//                                   style: TextStyle(
//                                     color: Colors.green,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                   recognizer: TapGestureRecognizer()
//                                     ..onTap = _onTapSignInButton,
//                                 ),
//
//                               ]
//                           )),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         )
//     );
//   }
//
//   void _onTapSubmitButton(){
//     if(_formKey.currentState!.validate()){
//       _registerUser();
//     }
//
//   }
//   Future<void> _registerUser() async{
//     _registrationInProgress = true;
//     setState(() {
//
//     });
//     Map<String, dynamic> requestBody ={
//       "email": _emailTEControler.text.trim(),
//       "firstName": _firstNameTEControler.text.trim(),
//       "lastName": _lastNameTEControler.text.trim(),
//       "mobile":_mobileTEControler.text.trim(),
//       "password": _passwordlTEControler.text,
//     };
//     NetworkResponse response = await NetworkClient.postRequest(
//         url: Urls.registerUrl,
//         body:requestBody );
//     _registrationInProgress = false;
//     setState(() {
//
//     });
//
//     if(response.isSuccess){
//       _clearTextFields();
//      showSnackBarMessage(context, 'User registered succesfully!');
//     }else{
//       showSnackBarMessage(context, response.errorMessage,true);
//     }
//
//   }
//   void _clearTextFields(){
//     _emailTEControler.clear();
//     _passwordlTEControler.clear();
//     _mobileTEControler.clear();
//     _firstNameTEControler.clear();
//     _lastNameTEControler.clear();
//
//   }
//
//
//   void _onTapSignInButton(){
//     Navigator.pop(context);
//
//   }
//
// }

import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../data/service/network_client.dart';
import '../../data/utils/urls.dart';
import '../widgets/centered_circular_progress_indicator.dart';
import '../widgets/screen_background.dart';
import '../widgets/snack_bar_message.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _registrationInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 80),
                  Text(
                    'Join With Us',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailTEController,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                    ),
                    validator: (String? value) {
                      String email = value?.trim() ?? '';
                      if (EmailValidator.validate(email) == false) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: _firstNameTEController,
                    decoration: const InputDecoration(
                      hintText: 'First name',
                    ),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter your first name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: _lastNameTEController,
                    decoration: const InputDecoration(
                      hintText: 'Last name',
                    ),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter your last name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.phone,
                    controller: _mobileTEController,
                    decoration: const InputDecoration(
                      hintText: 'Mobile',
                    ),
                    validator: (String? value) {
                      String phone = value?.trim() ?? '';
                      RegExp regExp = RegExp(r"^(?:\+?88|0088)?01[15-9]\d{8}$");
                      if (regExp.hasMatch(phone) == false) {
                        return 'Enter your valid phone';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _passwordTEController,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                    ),
                    validator: (String? value) {
                      if ((value?.isEmpty ?? true) || (value!.length < 6)) {
                        return 'Enter your password more than 6 letters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Visibility(
                    visible: _registrationInProgress == false,
                    replacement: const CenteredCircularProgressIndicator(),
                    child: ElevatedButton(
                      onPressed: _onTapSubmitButton,
                      child: const Icon(Icons.arrow_circle_right_outlined),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        children: [
                          const TextSpan(text: "Already have an account? "),
                          TextSpan(
                            text: 'Sign In',
                            style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = _onTapSignInButton,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSubmitButton() {
    if (_formKey.currentState!.validate()) {
      _registerUser();
    }
  }

  Future<void> _registerUser() async {
    _registrationInProgress = true;
    setState(() {});
    Map<String, dynamic> requestBody = {
      "email": _emailTEController.text.trim(),
      "firstName": _firstNameTEController.text.trim(),
      "lastName": _lastNameTEController.text.trim(),
      "mobile": _mobileTEController.text.trim(),
      "password": _passwordTEController.text
    };
    NetworkResponse response = await NetworkClient.postRequest(
      url: Urls.registerUrl,
      body: requestBody,
    );
    _registrationInProgress = false;
    setState(() {});
    if (response.isSuccess) {
      _clearTextFields();
      showSnackBarMessage(context, 'User registered successfully!');
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
  }

  void _clearTextFields() {
    _emailTEController.clear();
    _firstNameTEController.clear();
    _lastNameTEController.clear();
    _mobileTEController.clear();
    _passwordTEController.clear();
  }

  void _onTapSignInButton() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
