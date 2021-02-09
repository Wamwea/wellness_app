import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/login_screen.dart';
import 'package:wellness_app/Models/thoughtBubbleModel.dart';
import 'package:wellness_app/Models/userModel.dart';

final userProvider = ChangeNotifierProvider<UserModel>((reference) {
  return UserModel();
});
final thoughtFeedProvider =
    ChangeNotifierProvider<ThoughtBubbleModel>((reference) {
  return ThoughtBubbleModel();
});

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)),
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
