import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About Us",style: TextStyle(
          color: Colors.black,
          fontSize: 17.0,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
        ),),
        backgroundColor: const Color(0xFFffb700),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('images/sanjay.jpg'),
            ),
            SizedBox(height: 16.0),
            Text(
              'Author Name: Sanjay Prasath Ganesh',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Designation: App Developer',
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.grey,
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Roles in App Designing',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              ' - Developed all aspects of the app',
              style: TextStyle(
                fontSize: 15.0,
                fontFamily: 'Poppins',
              ),
            ),
            // Add more roles as needed
            SizedBox(height: 16.0),
            Text(
              'Additional Points',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              ' - Passionate about creating user-friendly experiences',
              style: TextStyle(
                fontSize: 15.0,
                fontFamily: 'Poppins',
              ),
            ),
            Text(
              ' - Committed to delivering high-quality software',
              style: TextStyle(
                fontSize: 15.0,
                fontFamily: 'Poppins',
              ),
            ),
            // Add more points as needed
            SizedBox(height: 16.0),
            Text(
              'Studies',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              ' - Bachelor\'s in Computer Science, at Sri Shakthi Institute of Engineering and Technology',
              style: TextStyle(
                fontSize: 15.0,
                fontFamily: 'Poppins',
              ),
            ),
            // Add more study details as needed
          ],
        ),
      ),
    );
  }
}
