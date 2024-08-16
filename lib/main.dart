import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ondago/screens/landing_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp( MainApp());
}

class MainApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.acmeTextTheme(
          Theme.of(context).textTheme,
        ),
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(
          primary: const Color(0xFFFF1E80),
          secondary: const Color(0xFF1EFF22),
        ),
      ),
      home: LandingPage(),
    );
  }
}
