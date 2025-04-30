
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_manager/ui/controllers/auth_controller.dart';
import 'package:task_manager/ui/screens/login_screen.dart';
import 'package:task_manager/ui/screens/main_bottom_nav_screen.dart';

import '../utils/assets_path.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _moveToNextScreen();
  }
  Future<void> _moveToNextScreen() async {
    await Future.delayed(Duration(seconds: 2));

    final bool isLoggedIn = await AuthController.checkIfUserLoggedIn();
    Navigator.pushReplacement(
      context,
        MaterialPageRoute(
            builder: (context)=> isLoggedIn ? const MainBottomNavScreen(): const LoginScreen() ,
        ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SvgPicture.asset(
            width: double.maxFinite,
            height: double.maxFinite,
            AssetsPath.backgroundSvg,
            fit: BoxFit.cover,
          ),

          Center(
            child: SvgPicture.asset(
              width: 120,

              AssetsPath.logoSvg,

            ),
          ),
        ],

      ),
    );
  }
}
