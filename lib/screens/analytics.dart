import 'dart:math';
import 'package:expense_tracker/database/expenseService.dart';
import 'package:expense_tracker/database/incomeService.dart';
import 'package:expense_tracker/sideScreens/analysisTable.dart';
import 'package:expense_tracker/sideScreens/expenseAnalytics.dart';
import 'package:expense_tracker/sideScreens/expenseStats.dart';
import 'package:expense_tracker/sideScreens/incomeAnalytics.dart';
import 'package:expense_tracker/sideScreens/incomeStat.dart';
import 'package:expense_tracker/sideScreens/leaveAnalytics.dart';
import 'package:flutter/material.dart';
import '../models/expenseModel.dart';
import '../models/incomeModel.dart';

class Analytics extends StatefulWidget {
  final String u_name;
  const Analytics({Key? key, required this.u_name}) : super(key: key);

  @override
  State<Analytics> createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {

  List<String> month = ['January','Febraury','March','April','May','June','July','August','September','October','November','December'];
  int m = DateTime.now().month;

  ExpenseService _expenseService = ExpenseService();
  IncomeService _incomeService = IncomeService();

  List<ExpenseModel> _expenseList = <ExpenseModel>[];
  List<IncomeModel> _incomeList = <IncomeModel>[];
  late var exp_total = 0;
  late var inc_total = 0;

  @override
  initState() {
    super.initState();
    getAllExpenses();
    getIncomes();
  }

  getAllExpenses() async{
    exp_total = 0;
    var expenses = await _expenseService.ReadAllExpense(widget.u_name,m);
    _expenseList = <ExpenseModel>[];
    expenses.forEach((expense){
      setState(() {
        var expenseModel = ExpenseModel();
        expenseModel.id = expense['id'];
        expenseModel.u_name = expense['u_name'];
        expenseModel.exp_name = expense['exp_name'];
        expenseModel.exp_amt = expense['exp_amt'];
        exp_total += expenseModel.exp_amt!;
        expenseModel.exp_date = expense['exp_date'];
        expenseModel.exp_type = expense['exp_type'];
        expenseModel.exp_trans = expense['exp_trans'];
        _expenseList.add(expenseModel);
      });
    });
  }

  getIncomes() async{
    inc_total = 0;
    var incomes = await _incomeService.ReadAllIncome(widget.u_name, m);
    _incomeList = <IncomeModel>[];
    incomes.forEach((income){
      setState(() {
        var incomeModel = IncomeModel();
        incomeModel.id = income['id'];
        incomeModel.u_name = income['u_name'];
        incomeModel.inc_name = income['inc_name'];
        incomeModel.inc_date = income['inc_date'];
        incomeModel.inc_amt = income['inc_amt'];
        inc_total += incomeModel.inc_amt!;
        incomeModel.inc_type = income['inc_type'];
        incomeModel.inc_trans = income['inc_trans'];
        _incomeList.add(incomeModel);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10.0,
            ),
            Text('${month[m-1]} Month Stats',style: const TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              fontSize: 15.0,
            ),),
            Container(
              height: 150,
              width: double.infinity,
              margin: const EdgeInsets.all(15.0),
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(
                  color: Colors.black,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  Expanded(
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)
                        ),
                        child: Container(
                          margin: const EdgeInsets.all(5.0),
                          padding: const EdgeInsets.all(10.0),
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFF52b788),Color(0xFFb7e4c7),Color(0xFFd8f3dc)],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              )
                          ),
                          height: 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Incomes',textAlign: TextAlign.center,style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                letterSpacing: 0.8,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                              ),),
                              Text('₹ $inc_total',style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                              ),)
                            ],
                          ),
                        ),
                      )
                  ),
                  Expanded(
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)
                        ),
                        child: Container(
                          margin: const EdgeInsets.all(5.0),
                          padding: const EdgeInsets.all(10.0),
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFFef6351),Color(0xFFf7a399),Color(0xFFffe3e0)],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              )
                          ),
                          height: 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Expenses',textAlign: TextAlign.center,style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                letterSpacing: 0.8,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                              ),),
                              Text('₹ $exp_total',style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                              ),)
                            ],
                          ),
                        ),
                      )
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${month[m-1]} Month Status : ',style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15.0,
                ),),
                const SizedBox(width: 10.0,),
                Text(inc_total > exp_total ? 'Profit' : inc_total == exp_total && inc_total != 0 && exp_total != 0 ? 'Balanced' : inc_total - exp_total == 0 ? 'Empty' : 'Loss',style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15.0,
                ),),
              ],
            ),
            const Divider(thickness: 2.0,),
            Container(
              margin: const EdgeInsets.all(5.0),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                leading: const Icon(Icons.calendar_today,color: Colors.red,),
                title: const Text('Expenses Stats',style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                ),),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ExpenseStats(u_name: widget.u_name,)));
                },
              ),
            ),
            const Divider(thickness: 2.0,),
            Container(
              margin: const EdgeInsets.all(5.0),
              child: ListTile(
                leading: const Icon(Icons.account_balance_wallet_outlined,color: Colors.green,),
                title: const Text('Income Stats',style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                ),),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => IncomeStats(u_name: widget.u_name,)));
                },
              ),
            ),
            const Divider(thickness: 2.0,),
            Container(
              margin: const EdgeInsets.all(5.0),
              child: ListTile(
                leading: const Icon(Icons.area_chart,color: Colors.red,),
                title: const Text('Expense Analytics',style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                ),),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ExpenseAnalytics(u_name: widget.u_name,)));
                },
              ),
            ),
            const Divider(thickness: 2.0,),
            Container(
              margin: const EdgeInsets.all(5.0),
              child: ListTile(
                leading: const Icon(Icons.bar_chart,color: Colors.green,),
                title: const Text('Income Analytics',style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                ),),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => IncomeAnalytics(u_name: widget.u_name,)));
                },
              ),
            ),
            const Divider(thickness: 2.0,),
            Container(
              margin: const EdgeInsets.all(5.0),
              child: ListTile(
                leading: const Icon(Icons.table_chart_outlined,color: Colors.blue,),
                title: const Text('Analysis Table',style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                ),),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AnalysisTable(u_name: widget.u_name,)));
                },
              ),
            ),
            const Divider(thickness: 2.0,),
            Container(
              margin: const EdgeInsets.all(5.0),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                leading: const Icon(Icons.safety_check_sharp,color: Colors.purple,),
                title: const Text('Leave Analytics',style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                ),),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LeaveAnalytics(u_name: widget.u_name,)));
                },
              ),
            ),
            const Divider(thickness: 2.0,),
          ],
        ),
      )
    );
  }
}