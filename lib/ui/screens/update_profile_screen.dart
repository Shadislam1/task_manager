
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/data/models/user_model.dart';
import 'package:task_manager/ui/controllers/auth_controller.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/tm_app_bar.dart';

import '../../data/service/network_client.dart';
import '../../data/utils/urls.dart';
import '../widgets/snack_bar_message.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {

 final  TextEditingController _emailTEControler = TextEditingController();
 final  TextEditingController _firstNameTEControler = TextEditingController();
 final  TextEditingController _lastNameTEControler = TextEditingController();
 final  TextEditingController _mobileTEControler = TextEditingController();
 final  TextEditingController _passwordlTEControler = TextEditingController();
 final  ImagePicker _imagePickericker = ImagePicker();
 final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
 bool _updateProfileInProgress = false;
 XFile ? _pickedImage;

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserModel userModel = AuthController.userModel!;
    _emailTEControler.text = userModel.email;
    _firstNameTEControler.text = userModel.firstName;
    _lastNameTEControler.text = userModel.lastName;
    _mobileTEControler.text = userModel.mobile;

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(
        fromProfileScreen: true,
      ),
      body: ScreenBackground(
        
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32,),
                Text('Update Profile', style: Theme
                    .of(context)
                    .textTheme
                    .titleLarge),
                SizedBox(height: 24,),
                _buildPhotoPickerWidget(),
                const SizedBox(height: 8,),
                TextFormField(
                  //validation likhte hbe
                  controller: _emailTEControler,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  enabled: false,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                  ),
                ),
                const SizedBox(height: 8,),
                TextFormField(
                  controller: _firstNameTEControler,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: 'First name',
                  ),
                  validator: (String? value){
                    if(value?.trim().isEmpty ?? true){
                      return 'Enter your first name';
                    }
                    return null;
                  }
                ),

                const SizedBox(height: 8,),
                TextFormField(
                  controller: _lastNameTEControler,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: 'Last name',
                  ),
                    validator: (String? value){
                      if(value?.trim().isEmpty ?? true){
                        return 'Enter your last name';
                      }
                      return null;
                    }
                ),
                const SizedBox(height: 8,),
                TextFormField(
                  controller: _mobileTEControler,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    hintText: 'Phone ',
                  ),
                    validator: (String? value){
                      RegExp regExp = RegExp(r"^(?:\+?88|0088)?01[15-9]\d{8}$");
                      if(value?.trim().isEmpty ?? true){
                        return 'Enter your phoneNumber';
                      }
                      return null;
                    }
                ),
                const SizedBox(height: 8,),
                TextFormField(
                  obscureText: true,
                  controller: _passwordlTEControler,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: 'password',
                  ),
                ),
                SizedBox(height: 16,),

                Visibility(
                  visible: _updateProfileInProgress == false,
                  replacement: const CircularProgressIndicator(),
                  child: ElevatedButton(
                  
                    onPressed: _onTapSubmitButton,
                    child: Icon(Icons.arrow_circle_right_outlined),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

  }
  void _onTapSubmitButton(){
    if(_formKey.currentState!.validate()){
      _updateProfile();

    }
  }
 Future<void> _updateProfile() async{
   _updateProfileInProgress = true;
   setState(() {

   });
   Map<String, dynamic> requestBody ={
     "email": _emailTEControler.text.trim(),
     "firstName": _firstNameTEControler.text.trim(),
     "lastName": _lastNameTEControler.text.trim(),
     "mobile":_mobileTEControler.text.trim(),
     "password": _passwordlTEControler.text
   };
   if(_passwordlTEControler.text.isNotEmpty){
     requestBody["password"] = _passwordlTEControler.text;
   }
   if(_pickedImage != null){
    List<int> imageBytes = await _pickedImage!.readAsBytes();
    String encodedImage = base64Encode(imageBytes);
    requestBody['photo'] = encodedImage;
   }
   NetworkResponse response = await NetworkClient.postRequest(
       url: Urls.updateProfileUrl,
       body:requestBody );
   _updateProfileInProgress= false;
   setState(() {

   });

   if(response.isSuccess){
     //TODO update user data in cache
    _passwordlTEControler.clear();
     showSnackBarMessage(context, 'User data updated succesfully!');
   }else{
     showSnackBarMessage(context, response.errorMessage,true);
   }

 }

  Widget _buildPhotoPickerWidget() {
    return GestureDetector(
      onTap: _onTapPhotoPicker,
      child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        )
                      ),
                      alignment: Alignment.center,
                      child:Text('Photo',style: TextStyle(
                        color: Colors.white,
                      ),) ,
                    ),
                    const SizedBox(width: 8,),
                    Text(_pickedImage?.name??'Select your photo'),
                  ],
                ),
              ),
    );
  }
  Future<void> _onTapPhotoPicker() async {

   XFile? image = await _imagePickericker.pickImage(source: ImageSource.gallery);
   if(image!= null){
     _pickedImage = image;
     setState(() {

     });
   }

  }
}
