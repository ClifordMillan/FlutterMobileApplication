import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/reusable_widgets/square_tile.dart';
import 'package:mobile_app/screens/enroll_screen.dart';
import 'package:mobile_app/screens/grade.dart';
import 'package:mobile_app/screens/signin_screen.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:mobile_app/utils/color_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dashboard",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 5, 145, 47),
      ),
      
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
           
              colors: [
                hexStringToColor("FAFAFA"),
                hexStringToColor("FAFAFA"),
                hexStringToColor("4CAF50"),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          
          child: ListView(
            children: [
              DrawerHeader(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CircleAvatar(
                      maxRadius: 32,
                      
                      child: Text(
                        FirebaseAuth.instance.currentUser!.email
                            .toString()[0]
                            .toUpperCase(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    
                    Text(FirebaseAuth.instance.currentUser!.email.toString())
                  ],
                ),
              ),
              ListTile(
                onTap: () {
                  // showLogoutConfirmation();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
                leading: Icon(Icons.dashboard),
                title: Text("Dashboard"),
              ),
              ListTile(
                onTap: () {
                  // showLogoutConfirmation();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Enroll_Screen()),
                  );
                },
                leading: Icon(Icons.schedule),
                title: Text("Schedule"),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>GradeScreen()),
                  );
                },
                leading: Icon(Icons.grade),
                title: Text("Grade"),
              ),
              ListTile(
                onTap: () {
                  showLogoutConfirmation();
                },
                leading: Icon(Icons.logout_outlined),
                title: Text("Logout"),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            hexStringToColor("FAFAFA"),
            hexStringToColor("FAFAFA"),
            hexStringToColor("FAFAFA")
          ]),
        ),
        padding: EdgeInsets.all(16.0),
        child: Card(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            side:
                BorderSide(color: Color.fromARGB(255, 5, 168, 10), width: 2.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Student Information",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),

                Divider(),
                ListTile(
                  title: Text("Student ID No: 2021-01790"),
                ),
                ListTile(
                  title: Text("Student Name: MILLAN CLIFORD MANDABON"),
                ),
                ListTile(
                  title: Text(
                      "Program/Degree: Bachelor of Science in Information Technology"),
                ),
                ListTile(
                  title: Text("Year Level: Third Year"),
                ),
                ListTile(
                  title: Text(
                      "Student Status: ENROLLED for School Year 2023-2024 First Semester."),
                ),
                ListTile(
                  title: Text("Email Address: taskspeed2002@gmail.com"),
                ),
                ListTile(
                  title: Text("Mobile No.: 09639275314"),
                ),
                ListTile(
                  title: Text(
                      "Address: Purok-5 New Maligaya Ising Carmen ising ising ising ising ising , 0, , 8104"),
                ),
                // Divider(),
                // Center(
                //   child: Text("- No data available. Please update your personal information -"),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future logout() async {
    await FirebaseAuth.instance.signOut();
  }

  void showLogoutConfirmation() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.WARNING,
      animType: AnimType.SCALE,
      title: 'Logout',
      desc: 'Are you sure you want to log out?',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        // User confirmed, log out
        logout();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Logged Out')));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignInScreen()),
        );
      },
    )..show();
  }
}
