import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseUtil().initializeApp();
  runApp(MultiProvider(providers: providers, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: customTheme(),
      home: const LoginPage(),
    );
  }
}
