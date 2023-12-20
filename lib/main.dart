import 'package:flutter/material.dart';
import 'package:osb/common/app_colors.dart';
import 'package:osb/dashboard/dashboard_page.dart';
import 'package:osb/login/login_page.dart';
import 'package:flutter/services.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.colorBlack, // Set your desired color here
    ));
    return MaterialApp(
      theme: ThemeData(
         fontFamily: 'Poppins'
      ),
      home: const LoginPage(),
    );
  }
}
