import 'package:expense_tracker/database/userService.dart';
import 'package:expense_tracker/settingsScreens/changePsw.dart';
import 'package:expense_tracker/sideScreens/updateUserProfile.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  final String u_name;
  const UserProfile({Key? key, required this.u_name}) : super(key: key);


  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

  TextEditingController name = TextEditingController();
  TextEditingController phoneNo = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController maritalStatus = TextEditingController();
  TextEditingController type = TextEditingController();
  TextEditingController psw = TextEditingController();

  UserService _userService = UserService();

  @override
  initState(){
    super.initState();
    getUser();
  }

  getUser() async{
    var user = await _userService.ReadUser(widget.u_name);
    user.forEach((u){
      setState(() {
        name.text = u['name'];
        phoneNo.text = u['phoneNo'];
        age.text = u['age'].toString();
        dob.text = u['dob'];
        gender.text = u['gender'];
        email.text = u['email'];
        maritalStatus.text = u['marital_status'];
        type.text = u['type'];
        psw.text = u['psw'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFffb700),
        title: const Text("User Profile",style: TextStyle(
          color: Colors.black,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
          fontSize: 17.0
        ),),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const SizedBox(height: 10.0,),
              const Center(
                child: CircleAvatar(
                  backgroundColor: Colors.orange,
                  radius: 80.0,
                  child: Icon(Icons.person_sharp,size: 60.0,color: Colors.black,),
                ),
              ),
              const SizedBox(height: 20.0,),
              TextField(
                decoration: InputDecoration(
                  label: const Text("Name",style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontSize: 14.0,
                  ),),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.deepOrange,
                    )
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.orange,
                      )
                  ),
                ),
                controller: name,
                keyboardType: TextInputType.text,
                readOnly: true,
              ),
              const SizedBox(
                height: 15.0,
              ),
              TextField(
                decoration: InputDecoration(
                  label: const Text("Age",style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontSize: 14.0,
                  ),),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.deepOrange,
                      )
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.orange,
                      )
                  ),
                ),
                controller: age,
                keyboardType: TextInputType.number,
                readOnly: true,
              ),
              const SizedBox(
                height: 15.0,
              ),
              TextField(
                decoration: InputDecoration(
                  label: const Text("DOB",style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontSize: 14.0,
                  ),),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.deepOrange,
                      )
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.orange,
                      )
                  ),
                ),
                controller: dob,
                keyboardType: TextInputType.datetime,
                readOnly: true,
              ),
              const SizedBox(
                height: 15.0,
              ),
              TextField(
                decoration: InputDecoration(
                  label: const Text("Phone Number",style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontSize: 14.0,
                  ),),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.deepOrange,
                      )
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.orange,
                      )
                  ),
                ),
                controller: phoneNo,
                keyboardType: TextInputType.phone,
                readOnly: true,
              ),
              const SizedBox(
                height: 15.0,
              ),
              TextField(
                decoration: InputDecoration(
                  label: const Text("Gender",style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontSize: 14.0,
                  ),),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.deepOrange,
                      )
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.orange,
                      )
                  ),
                ),
                controller: gender,
                keyboardType: TextInputType.text,
                readOnly: true,
              ),
              const SizedBox(
                height: 15.0,
              ),
              TextField(
                decoration: InputDecoration(
                  label: const Text("E-mail",style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontSize: 14.0,
                  ),),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.deepOrange,
                      )
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.orange,
                      )
                  ),
                ),
                controller: email,
                keyboardType: TextInputType.emailAddress,
                readOnly: true,
              ),
              const SizedBox(
                height: 15.0,
              ),
              TextField(
                decoration: InputDecoration(
                  label: const Text("Marital Status",style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontSize: 14.0,
                  ),),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.deepOrange,
                      )
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.orange,
                      )
                  ),
                ),
                controller: maritalStatus,
                keyboardType: TextInputType.text,
                readOnly: true,
              ),
              const SizedBox(
                height: 15.0,
              ),
              TextField(
                decoration: InputDecoration(
                  label: const Text("Type",style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontSize: 14.0,
                  ),),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.deepOrange,
                      )
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.orange,
                      )
                  ),
                ),
                controller: type,
                keyboardType: TextInputType.text,
                readOnly: true,
              ),
              const SizedBox(
                height: 15.0,
              ),
              TextField(
                decoration: InputDecoration(
                  label: const Text("Password",style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontSize: 14.0,
                  ),),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.deepOrange,
                      )
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.orange,
                      )
                  ),
                ),
                controller: psw,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                readOnly: true,
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Divider(
                indent: 60.0,
                endIndent: 5.0,
                thickness: 2.0,
                color: Colors.black,
              ),
              ListTile(
                leading: const Icon(Icons.lock_clock_outlined,color: Colors.red,),
                title: const Text("Change Password",style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  fontSize: 15.0,
                ),),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePassword(u_name: widget.u_name,)));
                },
              ),
              const Divider(
                indent: 60.0,
                endIndent: 5.0,
                thickness: 2.0,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFffb700),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateUserProfile(u_name: widget.u_name))).then((data){
            if(data != null){
              getUser();
            }
          });
        },
        tooltip: 'Update Your User Profile',
        child: const Icon(Icons.update_rounded,color: Colors.black,),
      ),
    );
  }
}
