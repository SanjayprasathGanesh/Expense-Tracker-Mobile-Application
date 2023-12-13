import 'package:expense_tracker/database/userService.dart';
import 'package:expense_tracker/login/setUserProfile.dart';
import 'package:expense_tracker/login/userLogin.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class UserSignup extends StatefulWidget {
  const UserSignup({super.key});

  @override
  State<UserSignup> createState() => _UserSignupState();
}

class _UserSignupState extends State<UserSignup> {

  TextEditingController u_name = TextEditingController();
  TextEditingController psw = TextEditingController();
  TextEditingController c_psw = TextEditingController();

  UserService _userService = UserService();

  bool validateName = false, validatePsw = false, validateCPsw = false, showPsw = false, showCPsw = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50.0,
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.all(10.0),
              height: 280,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  image: const DecorationImage(
                    image: AssetImage(
                      'images/signup.jpg',
                    ),
                    fit: BoxFit.fill,
                    filterQuality: FilterQuality.high,
                  )
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      children: [
                        Container(
                          // margin: const EdgeInsets.only(top: 15.0,left: 15.0),
                          height: 60,
                          width: 70,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  'images/expLogo.png',
                                ),
                                fit: BoxFit.fitHeight,
                                filterQuality: FilterQuality.high,
                              )
                          ),
                        ),
                        Container(
                          child: const Text('Expense Tracker',style: TextStyle(
                            color: Colors.deepOrange,
                            fontFamily: 'Poppins',
                            fontSize: 8.0,
                            fontWeight: FontWeight.bold,
                          ),),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Text('Signup Now',style: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.8
            ),),
            const SizedBox(
              height: 5.0,
            ),
            const Text('Please fill the details and create the account',style: TextStyle(
                color: Colors.grey,
                fontFamily: 'Poppins',
                fontSize: 10.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.8
            ),),
            Container(
              margin: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      label: const Text("Enter the User Name",style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontSize: 14.0
                      ),),
                      errorText: validateName ? 'Empty User Name Field' : null,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: const BorderSide(
                            color: Colors.black,
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: const BorderSide(
                            color: Colors.deepOrange,
                          )
                      ),
                    ),
                    controller: u_name,
                    keyboardType: TextInputType.text,
                    cursorColor: Colors.deepOrange,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Stack(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          label: const Text("Enter the Password",style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: 14.0
                          ),),
                          errorText: validatePsw ? 'Empty Password Field' : null,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: const BorderSide(
                                color: Colors.black,
                              )
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: const BorderSide(
                                color: Colors.deepOrange,
                              )
                          ),
                          // suffix:
                        ),
                        controller: psw,
                        keyboardType: TextInputType.text,
                        cursorColor: Colors.deepOrange,
                        obscureText: !showPsw,
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          margin: const EdgeInsets.all(7.0),
                          child: IconButton(
                            onPressed: (){
                              setState(() {
                                showPsw = !showPsw;
                              });
                            },
                            icon: showPsw ? const Icon(Icons.visibility_off,color: Colors.black,size: 25.0,) : const Icon(Icons.visibility_outlined,color: Colors.black,size: 25.0,),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Stack(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          label: const Text("Confirm your Password",style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: 14.0
                          ),),
                          errorText: validateCPsw ? 'Empty Confirm Password Field' : null,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: const BorderSide(
                                color: Colors.black,
                              )
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: const BorderSide(
                                color: Colors.deepOrange,
                              )
                          ),
                          // suffix:
                        ),
                        controller: c_psw,
                        keyboardType: TextInputType.text,
                        cursorColor: Colors.deepOrange,
                        obscureText: !showCPsw,
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          margin: const EdgeInsets.all(7.0),
                          child: IconButton(
                            onPressed: (){
                              setState(() {
                                showCPsw = !showCPsw;
                              });
                            },
                            icon: showCPsw ? const Icon(Icons.visibility_off,color: Colors.black,size: 25.0,) : const Icon(Icons.visibility_outlined,color: Colors.black,size: 25.0,),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(left: 30.0,right: 30.0,top: 10.0,bottom: 10.0),
              height: 45.0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    )
                ),
                onPressed: () async{
                  ToastContext().init(context);
                  setState(() {
                    validateName = u_name.text.isEmpty;
                    validatePsw = psw.text.isEmpty;
                    validateCPsw = c_psw.text.isEmpty;
                  });

                  if(psw.text.toString() == c_psw.text.toString()){
                    if(!validateName && !validatePsw && !validateCPsw){

                      bool valName = validateUName(u_name.text);
                      bool valPsw = isPasswordValid(psw.text);

                      if(valName && valPsw){
                        var check = await _userService.CheckUser(u_name.text, psw.text);

                        if(check.toString().length == 2){
                          Toast.show(
                            'User Created Successfully',
                            textStyle: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: 13.0,
                            ),
                            duration: 2,
                            gravity: Toast.bottom,
                            backgroundColor: Colors.green,
                          );
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SetUserProfile(u_name: u_name.text, psw: psw.text,)));
                        }
                        else{
                          if(!valName && valPsw){
                            Toast.show(
                              'User Not Found',
                              textStyle: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                fontSize: 13.0,
                              ),
                              duration: 2,
                              gravity: Toast.bottom,
                              backgroundColor: Colors.red,
                            );
                          }
                          else if(valName & !valPsw){
                            Toast.show(
                              'Invalid Password',
                              textStyle: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                fontSize: 13.0,
                              ),
                              duration: 2,
                              gravity: Toast.bottom,
                              backgroundColor: Colors.red,
                            );
                          }
                          else{
                            Toast.show(
                              'Invalid User',
                              textStyle: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                fontSize: 13.0,
                              ),
                              duration: 2,
                              gravity: Toast.bottom,
                              backgroundColor: Colors.red,
                            );
                          }
                        }
                      }
                      else{
                        if(valName && !valPsw){
                          Toast.show(
                            'Validation Errors',
                            textStyle: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: 13.0,
                            ),
                            duration: 2,
                            gravity: Toast.bottom,
                            backgroundColor: Colors.red,
                          );
                          showValidation(context);
                        }
                        else if(!valName && valPsw){
                          Toast.show(
                            'Validation Errors',
                            textStyle: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: 13.0,
                            ),
                            duration: 2,
                            gravity: Toast.bottom,
                            backgroundColor: Colors.red,
                          );
                          showNameValidation(context);
                        }
                        else{
                          Toast.show(
                            'Validation Errors on both UserName & Psw',
                            textStyle: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: 13.0,
                            ),
                            duration: 2,
                            gravity: Toast.bottom,
                            backgroundColor: Colors.red,
                          );
                        }
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
                        duration: 2,
                        gravity: Toast.bottom,
                        backgroundColor: Colors.red,
                      );
                    }
                  }
                  else{
                    Toast.show(
                      'Missmatching Password',
                      textStyle: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontSize: 13.0,
                      ),
                      duration: 2,
                      gravity: Toast.bottom,
                      backgroundColor: Colors.red,
                    );
                  }
                },
                child: const Text('Signup',style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),),
              ),
            ),
            InkWell(
              child: const Text("Already have an account ? Login",style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const UserLogin()));
              },
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 20,
                  width: 20,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              'images/insta.png'
                          )
                      )
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Container(
                  height: 20,
                  width: 20,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              'images/facebook.png'
                          )
                      )
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Container(
                  height: 20,
                  width: 20,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              'images/twitter.png'
                          )
                      )
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }

  bool validateUName(String u_name){
    String s = u_name;

    String s1 = s.replaceAll(RegExp(r'[^0-9]'), '');
    String s2 = s.replaceAll(RegExp(r'[^A-Za-z]'), '');
    String s3 = s.replaceAll(RegExp(r'[A-Za-z0-9]'), '');

    if(s.startsWith(RegExp(r'[a-z]')) && s.length >= 7 && s1.length == 2 && s2.length >= 2 && s3.length == 1){
      return true;
    }
    return false;
  }

  bool isPasswordValid(String password) {
    String upper = password.replaceAll(RegExp(r'[^A-Z]'), '');
    String lower = password.replaceAll(RegExp(r'[^a-z]'), '');
    String num = password.replaceAll(RegExp(r'[^0-9]'), '');
    String spl = password.replaceAll(RegExp(r'[A-Za-z0-9]'), '');

    if((password.startsWith(RegExp(r'[a-zA-Z]')) || password.startsWith(RegExp(r'[0-9]'))) && upper.length >= 1 && lower.length >= 1 && num.length >= 2 && spl.length == 1 && password.length >= 8){
      return true;
    }
    return false;
  }

  showNameValidation(BuildContext context){
    return showDialog(
        context: context,
        builder: (param){
          return AlertDialog(
            title: const Text('Validation Details for a UserName Creation',style: TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins',
            ),),
            content: Container(
              height: 380,
              child: const Column(
                children: [
                  Text('User name Must only start with a alphabet of Lower Case',style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                  ),),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text('User name length must be minimum of 7',style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                  ),),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text('User name must contain 2 Numbers and a Special Character',style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                  ),),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text('User name must not have a upper case in it',style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                  ),),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text('Eg : abcdef_12',style: TextStyle(
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
