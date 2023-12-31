import 'package:flutter/material.dart';
import 'package:osb/common/styles/app_colors.dart';
import 'package:osb/login/login_page.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'pages/dashboard/dashboard_page.dart';
import 'pages/employee/employee_page.dart';
import 'firebase/firebase_options.dart';

Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  

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
      home: const DashboardPage(),
    );
  }
}
