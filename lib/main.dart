import 'package:flutter/material.dart';
import './screens/pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool? seenOnBoard;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //load onboard for the first time only

  SharedPreferences pref = await SharedPreferences.getInstance();
  seenOnBoard = pref.getBool('seenOnboard') ?? false;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: seenOnBoard == true ? const HomePage() : const OnboardingScreen(),
    );
  }
}
