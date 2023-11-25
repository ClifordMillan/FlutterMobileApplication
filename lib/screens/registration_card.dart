import 'package:flutter/material.dart';

class RegistrationCard extends StatelessWidget {
  final String studentName;
  final String studentNo;
  final String course;
  final String yearLevel;
  final String schoolYear;
  final String semester;
  final String dateEnrolled;
  final String section;

  const RegistrationCard({
    Key? key,
    required this.studentName,
    required this.studentNo,
    required this.course,
    required this.yearLevel,
    required this.schoolYear,
    required this.semester,
    required this.dateEnrolled,
    required this.section,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: Colors.green, width: 2.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Student Name:', style: TextStyle(fontSize: 16.0)),
            Text(studentName),
            SizedBox(height: 8.0),
            Text('Student No:', style: TextStyle(fontSize: 16.0)),
            Text(studentNo),
            SizedBox(height: 8.0),
            Text('Course:', style: TextStyle(fontSize: 16.0)),
            Text(course),
            SizedBox(height: 8.0),
            Text('Year Level:', style: TextStyle(fontSize: 16.0)),
            Text(yearLevel),
            SizedBox(height: 8.0),
            Text('School Year:', style: TextStyle(fontSize: 16.0)),
            Text(schoolYear),
            SizedBox(height: 8.0),
            Text('Semester:', style: TextStyle(fontSize: 16.0)),
            Text(semester),
            SizedBox(height: 8.0),
            Text('Date Enrolled:', style: TextStyle(fontSize: 16.0)),
            Text(dateEnrolled),
            SizedBox(height: 8.0),
            Text('Section:', style: TextStyle(fontSize: 16.0)),
            Text(section),
          ],
        ),
      ),
    );
  }
}