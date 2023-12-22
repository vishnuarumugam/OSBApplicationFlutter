import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:osb/common/app_colors.dart';
import 'package:osb/firebase/firebase_options_1.dart';
import 'package:osb/login/login_page.dart';
import 'package:flutter/services.dart';


Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
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
      home: const LoginPage(),
    );
  }
}
