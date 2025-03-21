
import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/splash_screen.dart';
class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorSchemeSeed:Colors.green,
        inputDecorationTheme:InputDecorationTheme(
          fillColor: Colors.white,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          hintStyle: TextStyle(
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
          border: _getZeroBorder(),
          enabledBorder: _getZeroBorder(),
          errorBorder: _getZeroBorder(),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              fixedSize: Size.fromWidth(double.maxFinite),
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              )
          ),
        ),
        textTheme:TextTheme(
          titleLarge:  TextStyle(
            fontSize: 24,fontWeight: FontWeight.w600,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,fontWeight: FontWeight.w600,
          ),
        )
        ),

      home: SplashScreen(),
      );
  }
  OutlineInputBorder _getZeroBorder(){
    return OutlineInputBorder(
      borderSide: BorderSide.none,
    );
  }
}
