import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/reusable_widgets/reusable_widget.dart';
import 'package:mobile_app/reusable_widgets/square_tile.dart';
import 'package:mobile_app/screens/auth_service.dart';

// import 'package:mobile_app/screens/gmail_login.dart';
import 'package:mobile_app/screens/home_screen.dart';
import 'package:mobile_app/screens/reset_password.dart';
import 'package:mobile_app/screens/signup_screen.dart';
import 'package:mobile_app/utils/color_utils.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          hexStringToColor("388E3C"),
          hexStringToColor("388E3C"),
          hexStringToColor("4CAF50")
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.1, 20, 0),
            child: Column(
              children: <Widget>[
                logoWidget("assets/images/dnsc_image.png"),
                const SizedBox(
                  height: 15,
                ),
                reusableTextField("Enter Username", Icons.person_outline, false,
                    _emailTextController),
                const SizedBox(
                  height: 15,
                ),
                reusableTextField("Enter Password", Icons.lock_outline, true,
                    _passwordTextController),
                const SizedBox(
                  height: 3,
                ),
                forgetPassword(context),
                firebasepButton(context, "Login", () {
                  FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _passwordTextController.text)
                      .then((value) {
                    // Show AwesomeDialog on successful login
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.SUCCES,
                      animType: AnimType.SCALE,
                      title: 'Login Successful',
                      desc: 'Welcome back, ${value.user!.email}!',
                      btnOkOnPress: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                      },
                    )..show();
                  }).onError((error, stackTrace) {
                    print("Error ${error.toString()}");
                    // Show AwesomeDialog for login error
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.ERROR,
                      animType: AnimType.SCALE,
                      title: 'Login Failed',
                      desc: 'Please check your email and password.',
                      btnOkOnPress: () {},
                    )..show();
                  });
                }),
                signUpOption(),
                login_fb(),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareTile(
                      onTap: () async {
                        try {
                          await AuthService().signInWithGoogle(context);

                          // Show AwesomeDialog on successful Google sign-in
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.SUCCES,
                            animType: AnimType.SCALE,
                            title: 'Google Login Successful',
                            desc:
                                'You have successfully logged in with Google!',
                            btnOkOnPress: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()));
                            },
                          )..show();
                        } catch (error) {
                          print("Unexpected error: $error");
                        }
                      },
                      imagePath: 'assets/images/google.png',
                    ),
                    // SizedBox(
                    //   height: 25,
                    // ),
                    // SquareTile(onTap: () {}, imagePath: 'assets/images/fb.png'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Dont have account?",
            style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child: const Text(
            " Sign Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Row login_fb() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Or Continue With?",
            style: TextStyle(color: Colors.white70)),
      ],
    );
  }

  Widget forgetPassword(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: const Text(
          "Forgot Password?",
          style: TextStyle(color: Colors.white70),
          textAlign: TextAlign.right,
        ),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => ResetPassword())),
      ),
    );
  }

  Future logout() async {
    await FirebaseAuth.instance.signOut();
    AwesomeDialog(
      context: context,
      dialogType: DialogType.WARNING,
      animType: AnimType.SCALE,
      title: 'Logout',
      desc: 'You have been logged out successfully!',
      btnOkOnPress: () {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Log Out')));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignInScreen()),
        );
      },
    )..show();
  }
}
