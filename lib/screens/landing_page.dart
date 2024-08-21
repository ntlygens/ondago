import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ondago/constants.dart';
import 'package:ondago/screens/home_page.dart';
import 'package:ondago/screens/login_page.dart';

Future () async {
  Firebase.initializeApp();
}

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});



  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, streamSnapshot) {
        if (streamSnapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("Error: ${streamSnapshot.error}"),
            ),
          );
        }

        if (streamSnapshot.connectionState == ConnectionState.active) {
          // get the user
          Object? user = streamSnapshot.data;
          // if user not logged in
          if(user == null) {
            print('no user found');
            return const LoginPage();
          } else {
            print('User exists');
            return const HomePage();
          }
        }

        return const Scaffold(
          body: Center(
            child: Text(
              "Initializing App.... ",
              style: Constants.regHeading,
            ),
          ),
        );
      },
    );

  }
}
