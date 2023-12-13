import 'package:expense_tracker/database/userService.dart';
import 'package:expense_tracker/extraFeatures/bikeAccessories.dart';
import 'package:expense_tracker/extraFeatures/healthTracker.dart';
import 'package:expense_tracker/extraFeatures/mileageCalculator.dart';
import 'package:expense_tracker/extraFeatures/remainder.dart';
import 'package:expense_tracker/login/userLogin.dart';
import 'package:expense_tracker/models/userModel.dart';
import 'package:expense_tracker/screens/analytics.dart';
import 'package:expense_tracker/screens/expenses.dart';
import 'package:expense_tracker/screens/home.dart';
import 'package:expense_tracker/screens/personal.dart';
import 'package:expense_tracker/screens/settings.dart';
import 'package:expense_tracker/screens/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
      MaterialApp(
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: Colors.black),
          ),
        ),
      )
  );
}

class ExpenseTracker extends StatefulWidget {
  final String u_name;
  const ExpenseTracker({Key? key, required this.u_name}) : super(key: key);

  @override
  State<ExpenseTracker> createState() => _ExpenseTrackerState();
}

class _ExpenseTrackerState extends State<ExpenseTracker> {
  late String uName = '';
  String email = '';

  @override
  void initState() {
    super.initState();
    uName = widget.u_name;
    getUser();
  }

  int index = 0;
  /*final pages = [
    Home(u_name: uName),
    const Expenses(),
    const Personal(),
    const Analytics(),
    const Settings(),
  ];*/

  List<Widget> get pages => [
    Home(u_name: uName),
    Expenses(u_name: uName),
    Personal(u_name: uName),
    Analytics(u_name: uName),
    Settings(u_name: uName),
  ];

  UserService _userService = UserService();

  getUser() async{
    var user = await _userService.ReadUser(uName);
    user.forEach((u){
      setState(() {
        var userModel = UserModel();
        userModel.email = u['email'];
        email = userModel.email!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    getUser();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Tracker",style: TextStyle(
          color: Colors.black,
          fontSize: 17.0,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
        ),),
        backgroundColor: const Color(0xFFffb700),
      ),
      body: pages[index],
      bottomNavigationBar: showBottomBar(),
      drawer: Drawer(
        backgroundColor: Colors.black,
        child: Stack(
          children: [
            ListView(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10.0), // Add margin
                  child: UserAccountsDrawerHeader(
                    accountName: Text(
                      widget.u_name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontSize: 13.0,
                      ),
                    ),
                    accountEmail: Text(
                      email,
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontSize: 13.0,
                      ),
                    ),
                    currentAccountPicture: const CircleAvatar(
                      backgroundColor: Colors.black,
                      child: Icon(Icons.person, color: Colors.orange),
                    ),
                    currentAccountPictureSize: const Size.square(72.0),
                    arrowColor: Colors.black,
                    decoration: const BoxDecoration(
                      color: Color(0xFFffb700),
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.directions_bike,color: Colors.orange,),
                  title: const Text("Mileage Calculator",style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                  ),),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MileageCalculator(u_name: widget.u_name,)));
                  },
                ),
                const Divider(
                  thickness: 2.0,
                  color: Colors.grey,
                ),
                ListTile(
                  leading: const Icon(Icons.health_and_safety_outlined,color: Colors.orange,),
                  title: const Text("Health Tracker",style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                  ),),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HealthTracker(u_name: widget.u_name,)));
                  },
                ),
                const Divider(
                  thickness: 2.0,
                  color: Colors.grey,
                ),
                ListTile(
                  leading: const Icon(Icons.electric_bike,color: Colors.orange,),
                  title: const Text("My Bike",style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                  ),),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyBike(u_name: widget.u_name,)));
                  },
                ),
                const Divider(
                  thickness: 2.0,
                  color: Colors.grey,
                ),
                ListTile(
                  leading: const Icon(Icons.notification_add_outlined,color: Colors.orange,),
                  title: const Text("Remainder",style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                  ),),
                  onTap: (){
                    ToastContext().init(context);
                    Toast.show(
                      'Premium Account Required to Unlock this Feature',
                      duration: 5,
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      )
                    );
                  },
                  tileColor: Colors.grey,
                  trailing: const Icon(Icons.workspace_premium,color: Colors.yellow,),
                ),
                const Divider(
                  thickness: 2.0,
                  color: Colors.grey,
                ),
                ListTile(
                  leading: const Icon(Icons.nightlight_round,color: Colors.orange,),
                  title: const Text("Sleep Tracker",style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                  ),),
                  onTap: (){
                    ToastContext().init(context);
                    Toast.show(
                        'Premium Account Required to Unlock this Feature',
                        duration: 5,
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        )
                    );
                  },
                  tileColor: Colors.grey,
                  trailing: const Icon(Icons.workspace_premium,color: Colors.yellow,),
                ),
                const Divider(
                  thickness: 2.0,
                  color: Colors.grey,
                ),
                const SizedBox(
                  height: 150,
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 130,
                alignment: Alignment.bottomRight,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.logout_sharp,color: Colors.red,),
                      title: const Text("Log Out",style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                      ),),
                      onTap: (){
                        logout(context);
                      },
                    ),
                    const Divider(
                      color: Colors.black,
                      thickness: 2.0,
                    ),
                    ListTile(
                      leading: const Icon(Icons.delete_outline,color: Colors.red,),
                      title: const Text("Delete Account",style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                      ),),
                      onTap: (){
                        deleteAccount(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  showBottomBar() {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFc36f09),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      padding: const EdgeInsets.all(5.0),
      height: 80,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              IconButton(
                  onPressed: (){
                    setState(() {
                      index = 0;
                    });
                  },
                  icon: Icon(Icons.home_outlined,color: index != 0 ? Colors.black : Colors.yellow,),
                  iconSize: 25.0,
              ),
              Text("Home",style: TextStyle(
                color: index == 0 ? Colors.amber : Colors.black,
                fontSize: 11.0,
                fontFamily: 'Poppins',
              ),)
            ],
          ),
          Column(
            children: [
              IconButton(
                  onPressed: (){
                    setState(() {
                      index = 1;
                    });
                  },
                  icon: Icon(Icons.account_balance_wallet_outlined,color: index != 1 ? Colors.black : Colors.yellow,)
              ),
              Text("Expenses",style: TextStyle(
                color: index == 1 ? Colors.amber : Colors.black,
                fontSize: 11.0,
                fontFamily: 'Poppins',
              ),)
            ],
          ),
          Column(
            children: [
              IconButton(
                  onPressed: (){
                    setState(() {
                      index = 2;
                    });
                  },
                  icon: Icon(Icons.person_pin,color: index != 2 ? Colors.black : Colors.yellow,)
              ),
              Text("Personal",style: TextStyle(
                color: index == 2 ? Colors.amber : Colors.black,
                fontSize: 11.0,
                fontFamily: 'Poppins',
              ),)
            ],
          ),
          Column(
            children: [
              IconButton(
                  onPressed: (){
                    setState(() {
                      index = 3;
                    });
                  },
                  icon: Icon(Icons.analytics_outlined,color: index != 3 ? Colors.black : Colors.yellow,)
              ),
              Text("Analytics",style: TextStyle(
                color: index == 3 ? Colors.amber : Colors.black,
                fontSize: 11.0,
                fontFamily: 'Poppins',
              ),)
            ],
          ),
          Column(
            children: [
              IconButton(
                  onPressed: (){
                    setState(() {
                      index = 4;
                    });
                  },
                  icon: Icon(Icons.settings,color: index != 4 ? Colors.black : Colors.yellow,)
              ),
              Text("Settings",style: TextStyle(
                color: index == 4 ? Colors.amber : Colors.black,
                fontSize: 11.0,
                fontFamily: 'Poppins',
              ),)
            ],
          )
        ],
      ),
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

  deleteAccount(BuildContext context){
    return showDialog(
        context: context,
        builder: (param) {
          return AlertDialog(
            title: const Text(
              'Do You want to Delete this Account',
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
                  onPressed: () async{
                    ToastContext().init(context);
                    var result = _userService.DeleteUser(widget.u_name);
                    if(result != null){
                      Toast.show(
                        'Account Deleted Successfully',
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontSize: 15.0,
                        ),
                        backgroundColor: Colors.yellow,
                      );
                      SystemNavigator.pop();
                    }
                    else{
                      Toast.show(
                        'Account not Deleted',
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontSize: 15.0,
                        ),
                        backgroundColor: Colors.red,
                      );
                    }
                  },
                  child: const Text('Delete')),
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
}
