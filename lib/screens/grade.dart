import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:mobile_app/reusable_widgets/logo_tile.dart';
// import 'package:mobile_app/reusable_widgets/square_tile.dart';
import 'package:mobile_app/screens/enroll_screen.dart';
import 'package:mobile_app/screens/home_screen.dart';

import 'package:mobile_app/screens/signin_screen.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:mobile_app/utils/color_utils.dart';

class GradeScreen extends StatefulWidget {
  const GradeScreen({super.key});

  @override
  State<GradeScreen> createState() => _GradeScreenState();
}

class _GradeScreenState extends State<GradeScreen> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        title: Text(
          "Grade",
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
                    //  SizedBox(
                    //    height: 25,
                    //  ),
                
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
                    MaterialPageRoute(builder: (context) => GradeScreen()),
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
      body: SingleChildScrollView(
        
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(label: Text('Subject Code')),
            DataColumn(label: Text('Description')),
            DataColumn(label: Text('Grade Status')),
          ],
          rows: [
            DataRow(cells: [
              DataCell(Text('GEELECT3')),
              DataCell(Text('Philippine Popular Culture')),
              DataCell(Text('1.5')),
            ]),
            DataRow(cells: [
              DataCell(Text('IT311')),
              DataCell(Text('Networking 2')),
              DataCell(Text('2.5')),
            ]),
            DataRow(cells: [
              DataCell(Text('IT312')),
              DataCell(Text('Integrative Programming and Technologies 1')),
              DataCell(Text('5.0')),
            ]),
            DataRow(cells: [
              DataCell(Text('ITELEC4')),
              DataCell(Text('Platform Technologies')),
              DataCell(Text('2.75')),
            ]),
            DataRow(cells: [
              DataCell(Text('ITSPEC2')),
              DataCell(Text('Project Management')),
              DataCell(Text('3.0')),
            ]),
            DataRow(cells: [
              DataCell(Text('MS 221')),
              DataCell(Text('	Quantitative Methods')),
              DataCell(Text('4.0')),
             
            ]),
           
          ],
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
