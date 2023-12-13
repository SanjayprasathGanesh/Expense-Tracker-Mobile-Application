import 'package:expense_tracker/database/userService.dart';
import 'package:expense_tracker/login/userSignup.dart';
import 'package:expense_tracker/main.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class UserLogin extends StatefulWidget {
  const UserLogin({super.key});

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {

  TextEditingController u_name = TextEditingController();
  TextEditingController psw = TextEditingController();

  UserService _userService = UserService();

  bool validateName = false, validatePsw = false, showPsw = false;

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
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  image: const DecorationImage(
                    image: AssetImage(
                      'images/login.jpg',
                    ),
                    fit: BoxFit.fill,
                    filterQuality: FilterQuality.high,
                  )
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topRight,
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
            const Text('Log In Now',style: TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins',
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
                letterSpacing: 0.8
            ),),
            const SizedBox(
              height: 5.0,
            ),
            const Text('Please login to continue using our app',style: TextStyle(
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
                  });
                  if(!validateName && !validatePsw){
                    var check = await _userService.CheckUser(u_name.text, psw.text);
                    print(check);

                    if(check.toString().length >= 3){
                      Toast.show(
                        'Logined Successfully',
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontSize: 13.0,
                        ),
                        duration: 2,
                        gravity: Toast.bottom,
                        backgroundColor: Colors.green,
                      );
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ExpenseTracker(u_name: u_name.text,)));
                    }
                    else{
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
                  }
                },
                child: const Text('Log In',style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),),
              ),
            ),
            InkWell(
              child: const Text("Don't have an account ? Sign up",style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const UserSignup()));
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
            )
          ],
        ),
      ),
    );
  }
}
