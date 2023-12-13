import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import '../database/userService.dart';

class ChangePassword extends StatefulWidget {
  final String u_name;
  const ChangePassword({Key? key, required this.u_name}) : super(key : key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {

  TextEditingController currentPsw = TextEditingController();
  TextEditingController newPsw = TextEditingController();

  UserService _userService = UserService();
  String psw = '';

  bool validateCPsw = false, validateNPsw = false;

  @override
  initState(){
    super.initState();
    getUser();
  }

  getUser() async{
    var user = await _userService.ReadUser(widget.u_name);
    user.forEach((u){
      setState(() {
        psw = u['psw'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Password",style: TextStyle(
          color: Colors.black,
          fontSize: 17.0,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
        ),),
        backgroundColor: const Color(0xFFffb700),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  label: const Text("Current Password",style: TextStyle(
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
                  errorText: validateCPsw ? 'Empty Current Password Field' : null,
                ),
                controller: currentPsw,
                keyboardType: TextInputType.visiblePassword,
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                decoration: InputDecoration(
                  label: const Text("New Password",style: TextStyle(
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
                  errorText: validateNPsw ? 'Empty New Password Field' : null,
                ),
                controller: newPsw,
                keyboardType: TextInputType.visiblePassword,
              ),
              const SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: (){
                    ToastContext().init(context);
                    setState(() {
                      validateCPsw = currentPsw.text.isEmpty;
                      validateNPsw = newPsw.text.isEmpty;
                    });

                    if(!validateCPsw && !validateNPsw){
                      if(currentPsw.text == psw){
                        if(isPasswordValid(newPsw.text)){
                          var result = _userService.UpdatePsw(widget.u_name, newPsw.text.toString());
                          if(result != null){
                            Toast.show(
                              'Password Updated Successfully',
                              textStyle: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                fontSize: 13.0,
                              ),
                              duration: 3,
                              gravity: Toast.bottom,
                              backgroundColor: Colors.green,
                            );
                            Navigator.pop(context);
                          }
                          else{
                            Toast.show(
                              'OOPs, Password not updated',
                              textStyle: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                fontSize: 13.0,
                              ),
                              duration: 3,
                              gravity: Toast.bottom,
                              backgroundColor: Colors.red,
                            );
                          }
                        }
                        else{
                          Toast.show(
                            'Validation Errors',
                            textStyle: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: 13.0,
                            ),
                            duration: 3,
                            gravity: Toast.bottom,
                            backgroundColor: Colors.red,
                          );
                          showValidation(context);
                        }
                      }
                      else{
                        Toast.show(
                          'Mismatching Current Password',
                          textStyle: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontSize: 13.0,
                          ),
                          duration: 3,
                          gravity: Toast.bottom,
                          backgroundColor: Colors.red,
                        );
                      }
                    }
                    else{
                      Toast.show(
                        'Empty Fields',
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontSize: 13.0,
                        ),
                        duration: 3,
                        gravity: Toast.bottom,
                        backgroundColor: Colors.red,
                      );
                    }
                  },
                  child: const Text('Update Password',style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                  ),),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool isPasswordValid(String password) {
    String upper = password.replaceAll(RegExp(r'[^A-Z]'), '');
    String lower = password.replaceAll(RegExp(r'[^a-z]'), '');
    String num = password.replaceAll(RegExp(r'[^0-9]'), '');
    String spl = password.replaceAll(RegExp(r'[A-Za-z0-9]'), '');

    if(upper.length >= 1 && lower.length >= 1 && num.length >= 2 && spl.length == 1 && password.length >= 8){
      return true;
    }
    return false;
  }

  showValidation(BuildContext context){
    return showDialog(
        context: context,
        builder: (param){
          return AlertDialog(
            title: const Text('Validation Details for a Password Creation',style: TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins',
            ),),
            content: Container(
              height: 300,
              child: const Column(
                children: [
                  Text('Password Must contain a minimum length of 8 letters',style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                  ),),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text('Password must contain atleast a single upper and lower case letters',style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                  ),),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text('Password must contain 2 Numbers and a Special Character',style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                  ),),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text('Eg : AbcdeF^54',style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                  ),),
                  SizedBox(
                    height: 5.0,
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}
