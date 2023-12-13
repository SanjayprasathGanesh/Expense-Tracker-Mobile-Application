import 'package:expense_tracker/personal/viewDiary.dart';
import 'package:expense_tracker/personal/viewLeaveTracker.dart';
import 'package:flutter/material.dart';

class Personal extends StatefulWidget {
  final String u_name;
  const Personal({Key? key, required this.u_name}) : super(key: key);

  @override
  State<Personal> createState() => _PersonalState();
}

class _PersonalState extends State<Personal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(
                  color: Colors.black,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              margin: const EdgeInsets.only(left: 20.0,right: 20.0,top: 10.0,bottom: 10.0),
              padding: const EdgeInsets.all(15.0),
              height: 450,
              width: double.infinity,
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewDiary(u_name: widget.u_name,)));
                },
                child: const Column(
                  children: [
                    Text("Personal Dairy",textAlign: TextAlign.center,style: TextStyle(
                      color: Colors.purple,
                      fontFamily: 'Poppins',
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold
                    ),),
                    SizedBox(height: 10.0,),
                    Text("The new feature allows users to document their daily personal experiences and the reflections, "
                        "providing a space for them to capture the essence of each day. This "
                        "feature serves as a digital diary, enabling individuals to cherish and reflect upon the moments, "
                        "emotions, and insights that shape their daily existence. It adds a personal touch to the app, "
                        "fostering introspection and creating a valuable record of the user's unique life story. ->",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                    ),),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(
                  color: Colors.black,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              margin: const EdgeInsets.only(left: 20.0,right: 20.0,top: 10.0,bottom: 10.0),
              padding: const EdgeInsets.all(15.0),
              height: 450,
              width: double.infinity,
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewLeaveTracker(u_name: widget.u_name,)));
                },
                child: const Column(
                  children: [
                    Text("Leave Tracker",textAlign: TextAlign.center,style: TextStyle(
                      color: Colors.deepOrange,
                      fontFamily: 'Poppins',
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold
                    ),),
                    SizedBox(height: 10.0,),
                    Text("The leave tracker is an invaluable tool designed to efficiently manage and monitor an individual's "
                        "time off. With this feature, users can seamlessly record and keep track of their leave days, "
                        "providing a clear overview of their available time for leisure, vacations, or other personal "
                        "commitments. This user-friendly tracker simplifies the process of requesting and approving leaves, "
                        "streamlining communication between users and supervisors. -> ",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                    ),),
                  ],
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}
