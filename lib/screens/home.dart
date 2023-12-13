import 'package:expense_tracker/incomes/addIncome.dart';
import 'package:expense_tracker/incomes/viewAllIncome.dart';
import 'package:flutter/material.dart';

import '../expenses/addExpense.dart';

class Home extends StatefulWidget {
  final String u_name;
  const Home({Key? key, required this.u_name}) : super(key : key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 150,
              margin: const EdgeInsets.all(15.0),
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(
                  color: Colors.black,
                  width: 2.0,
                ),
                gradient: const LinearGradient(
                  colors: [Color(0xFFedafb8),Color(0xFFffd6ff),Color(0xFFf7e1d7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              ),
              child: const Center(
                child: Text("Proceed to the next page to review the daily expenses and incomes you've recently entered -> ",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),),
              ),
            ),
            ListTile(
              title: Column(
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/home1.png'),
                          fit: BoxFit.fitWidth,
                        )
                    ),
                  ),
                  const SizedBox(height: 10.0,),
                  const Text('Effortlessly manage your finances with our intuitive expense tracker. Stay in control by easily recording and categorizing your daily expenses. Gain valuable insights into your spending habits, allowing you to make informed financial decisions. Our user-friendly interface ensures a seamless experience, helping you track your money with convenience. Start your journey towards financial wellness today!',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                  ),),
                ],
              ),
            ),
            const Divider(
              thickness: 2.0,
            ),
            const SizedBox(height: 10.0,),
            ListTile(
              title: Column(
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/home2.png'),
                          fit: BoxFit.fitWidth,
                        )
                    ),
                  ),
                  const SizedBox(height: 10.0,),
                  const Text('Unlock financial freedom with our cutting-edge expense tracker. Seamlessly monitor your spending patterns, set budget goals, and receive real-time updates on your financial health. Our secure platform ensures your data is protected while providing you with the tools you need for smarter money management. Take charge of your financial future and embark on a path towards financial success. Sign up now for a more prosperous tomorrow!',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                    ),),
                ],
              ),
            ),
            const Divider(
              thickness: 2.0,
            ),
            const SizedBox(height: 10.0,),
            ListTile(
              title: Column(
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/home3.png'),
                          fit: BoxFit.fitWidth,
                        )
                    ),
                  ),
                  const SizedBox(height: 10.0,),
                  const Text('Transform your financial habits with our powerful expense tracker. Effortlessly track your expenditures, analyze trends, and make informed decisions to achieve your savings goals. Our user-friendly app simplifies budgeting, giving you the clarity and control you need for a more secure financial future. Take the first step towards financial empowerment – start tracking your expenses with ease today',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                    ),),
                ],
              ),
            ),
            const Divider(
              thickness: 2.0,
            ),
            const SizedBox(height: 10.0,),
            ListTile(
              title: Column(
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/home4.png'),
                          fit: BoxFit.fitWidth,
                        )
                    ),
                  ),
                  const SizedBox(height: 10.0,),
                  const Text('Empower your financial journey with our comprehensive expense tracker. Gain a clear understanding of where your money goes, set personalized budgets, and watch your savings grow. Our intelligent features make tracking expenses a breeze, providing you with the insights needed to make sound financial decisions. Elevate your financial well-being – start using our expense tracker now and take control of your financial destiny.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                    ),),
                ],
              ),
            ),
            const Divider(
              thickness: 2.0,
            ),
            const SizedBox(height: 10.0,),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFFffb700),
          onPressed: (){
            showBottom();
          },
          child: const Icon(Icons.add,color: Colors.black,),
      ),
    );
  }

  showBottom() async{
    showModalBottomSheet(
        backgroundColor: Color(0xFFf9dc5c),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          )
        ),
        context: context,
        builder: (BuildContext context){
          return Container(
            height: 280,
            width: double.infinity,
            child: Column(
              children: [
                ListTile(
                  trailing: TextButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: const Text("Clear",style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                    ),),
                  ),
                ),
                ListTile(
                  title: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.attach_money),
                      SizedBox(width: 15.0,),
                      Text("Add Income",style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                      ),),
                    ],
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AddIncome(u_name: widget.u_name,))).then((data){
                      if(data != null){
                        Navigator.pop(context);
                      }
                    });
                  },
                ),
                const Divider(
                  height: 2.0,
                  thickness: 1.0,
                  color: Colors.black,
                ),
                ListTile(
                  title: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.account_balance_wallet),
                      SizedBox(width: 15.0,),
                      Text("Add Expense",style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                      ),),
                    ],
                  ),
                  onTap: (){
                    setState(() {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AddExpense(u_name: widget.u_name,))).then((data){
                        if(data != null){
                          Navigator.pop(context);
                        }
                      });
                    });

                  },
                ),
                const Divider(
                  height: 2.0,
                  thickness: 1.0,
                  color: Colors.black,
                ),
                ListTile(
                  title: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.interests_outlined),
                      SizedBox(width: 15.0,),
                      Text("View Incomes",style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                      ),),
                    ],
                  ),
                  onTap: (){
                    setState(() {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ViewAllIncome(u_name: widget.u_name,))).then((data){
                        if(data != null){
                          Navigator.pop(context);
                        }
                      });
                    });

                  },
                ),
                const Divider(
                  height: 2.0,
                  thickness: 1.0,
                  color: Colors.black,
                ),
              ],
            ),
          );
        }
    );
  }
}
