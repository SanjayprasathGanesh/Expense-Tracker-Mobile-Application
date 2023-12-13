import 'package:expense_tracker/login/userLogin.dart';
import 'package:expense_tracker/settingsScreens/aboutUs.dart';
import 'package:expense_tracker/settingsScreens/cards.dart';
import 'package:expense_tracker/settingsScreens/contactUs.dart';
import 'package:expense_tracker/settingsScreens/faq.dart';
import 'package:expense_tracker/settingsScreens/helpCentre.dart';
import 'package:expense_tracker/settingsScreens/termsAndConditions.dart';
import 'package:expense_tracker/settingsScreens/wallet.dart';
import 'package:expense_tracker/sideScreens/userProfile.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  final String u_name;
  const Settings({Key? key, required this.u_name}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              ListTile(
                title: const Text('User Profile',style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                ),),
                leading: const Icon(Icons.perm_identity,color: Colors.deepOrange,),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfile(u_name: widget.u_name,)));
                },
              ),
              const Divider(
                indent: 60.0,
                endIndent: 10.0,
                thickness: 2.0,
                color: Colors.black,
              ),
              ListTile(
                title: const Text('Cards',style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                ),),
                leading: const Icon(Icons.card_giftcard_outlined,color: Colors.pinkAccent,),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => GiftVoucher()));
                },
              ),
              const Divider(
                indent: 60.0,
                endIndent: 10.0,
                thickness: 2.0,
                color: Colors.black,
              ),
              ListTile(
                title: const Text('FAQ',style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                ),),
                leading: const Icon(Icons.help_outline,color: Colors.blue,),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FAQPage()));
                },
              ),
              const Divider(
                indent: 60.0,
                endIndent: 10.0,
                thickness: 2.0,
                color: Colors.black,
              ),
              ListTile(
                title: const Text('Contact Us',style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                ),),
                leading: const Icon(Icons.contact_mail_outlined,color: Colors.green,),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ContactUs(u_name: widget.u_name)));
                },
              ),
              const Divider(
                indent: 60.0,
                endIndent: 10.0,
                thickness: 2.0,
                color: Colors.black,
              ),
              ListTile(
                title: const Text('About Us',style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                ),),
                leading: const Icon(Icons.local_post_office_outlined,color: Colors.purple,),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUs()));
                },
              ),
              const Divider(
                indent: 60.0,
                endIndent: 10.0,
                thickness: 2.0,
                color: Colors.black,
              ),
              ListTile(
                title: const Text('User Manual',style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                ),),
                leading: const Icon(Icons.library_books,color: Colors.brown,),
                onTap: (){
                  pageOnProgress(context);
                },
              ),
              const Divider(
                indent: 60.0,
                endIndent: 10.0,
                thickness: 2.0,
                color: Colors.black,
              ),
              ListTile(
                title: const Text('Help Center',style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                ),),
                leading: const Icon(Icons.record_voice_over,color: Colors.red,),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HelpCentre(u_name: widget.u_name,)));
                },
              ),
              const Divider(
                indent: 60.0,
                endIndent: 10.0,
                thickness: 2.0,
                color: Colors.black,
              ),
              ListTile(
                title: const Text('Terms and Policies',style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                ),),
                leading: const Icon(Icons.bolt_outlined,color: Colors.indigo,),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => TermsAndConditions()));
                },
              ),
              const Divider(
                indent: 60.0,
                endIndent: 10.0,
                thickness: 2.0,
                color: Colors.black,
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(left: 30.0,right: 30.0,top: 10.0,bottom: 10.0),
                height: 40.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    )
                  ),
                  onPressed: (){
                    logout(context);
                  },
                  child: const Text('Log Out',style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.black,
                  ),),
                ),
              )
            ],
          ),
        ),
      )
    );
  }

  logout(BuildContext context){
    return showDialog(
        context: context,
        builder: (param) {
          return AlertDialog(
            title: const Text(
              'Do You want to Logout from this Account',
              style: TextStyle(color: Colors.black,
                fontFamily: 'Raleway',
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
            actions: [
              TextButton(
                  style: TextButton.styleFrom(
                      primary: Colors.white, // foreground
                      backgroundColor: Colors.red),
                  onPressed: (){
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const UserLogin()),
                          (route) => false,
                    );
                  },
                  child: const Text('Logout')),
              TextButton(
                  style: TextButton.styleFrom(
                      primary: Colors.white, // foreground
                      backgroundColor: Colors.green),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'))
            ],
          );
        }
    );
  }

  pageOnProgress(BuildContext context){
    return showDialog(
        context: context,
        builder: (param){
          return AlertDialog(
            title: const Text('Page on Progress',style: TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins',
            ),),
            content: Container(
              height: 200,
              child: const Column(
                children: [
                  Text('User Manual Page is in Under Developement, and will be published soon when our team is ready to serve with it',style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                  ),),
                  SizedBox(
                    height: 5.0,
                  ),
                  CircularProgressIndicator(
                    color: Colors.deepOrange,
                  )
                ],
              ),
            ),
          );
        }
    );
  }
}
