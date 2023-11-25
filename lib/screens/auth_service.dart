import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobile_app/screens/home_screen.dart';

class AuthService {
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication gAuth = await gUser!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

    

      print("Signed in with Google successfully");

      AwesomeDialog(
        context: context, // Make sure to use the correct context
        dialogType: DialogType.SUCCES, // Corrected typo from 'SUCCES' to 'SUCCESS'
        animType: AnimType.TOPSLIDE,
        title: 'Success',
        desc: 'Logged in with Google!',
        btnOkOnPress: () {},
      )..show();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    } catch (error) {
      print("Error signing in with Google: $error");

      AwesomeDialog(
        context: context, // Make sure to use the correct context
        dialogType: DialogType.ERROR,
        animType: AnimType.TOPSLIDE,
        title: 'Error',
        desc: 'Failed to sign in with Google. Please try again.',
        btnOkOnPress: () {},
      )..show();
    }
  }
}

void showSignInErrorDialog(BuildContext context) {
  AwesomeDialog(
    context: context, // Make sure to use the correct context
    dialogType: DialogType.ERROR,
    animType: AnimType.TOPSLIDE,
    title: 'Error',
    desc: 'Failed to sign in with Google. Please try again.',
    btnOkOnPress: () {},
  )..show();
}