import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import '../database/expenseService.dart';
import '../models/expenseModel.dart';

class ExpenseAnalytics extends StatefulWidget {
  final String u_name;
  const ExpenseAnalytics({Key? key, required this.u_name}) : super(key: key);

  @override
  State<ExpenseAnalytics> createState() => _ExpenseAnalyticsState();
}

class _ExpenseAnalyticsState extends State<ExpenseAnalytics> {
  List<String> month = ['January','Febraury','March','April','May','June','July','August','September','October','November','December'];
  int m = DateTime.now().month;

  DateTime selectedDate = DateTime.now();

  ExpenseService _expenseService = ExpenseService();

  List<ExpenseModel> _expenseList = <ExpenseModel>[];
  var cash = 0,upi = 0,debit = 0,credit = 0,net = 0,cheque = 0,dd = 0;

  var nessTtl = 0,fixedTtl = 0,emergencyTtl = 0,unNessTtl = 0,ttl = 0;

  List<String> ness = ['Food','Fuel','Clothes','Fee','Studies'];
  List<String> fixed = ['Groceries','Fruits & Vegetables','Provisional Items','Dairy Products','Rent','Insurance','Tax','EMI','Phone Recharge','Electricity Bill','Gas Bill','Cable Bill'];
  List<String> emergency = ['Emergency','Pharmacy Products','Health Care','Hospital Fare'];

  @override
  initState() {
    super.initState();
    getAllExpenses();
  }

  getAllExpenses() async{

    fixedTtl = 0;
    nessTtl = 0;
    unNessTtl = 0;
    emergencyTtl = 0;
    ttl = 0;

    cash = 0;
    upi = 0;
    debit = 0;
    credit = 0;
    net = 0;
    cheque = 0;
    dd = 0;

    var expenses = await _expenseService.ReadAllExpense(widget.u_name,m);
    _expenseList = <ExpenseModel>[];
    expenses.forEach((expense){
      setState(() {
        var expenseModel = ExpenseModel();
        expenseModel.id = expense['id'];
        expenseModel.u_name = expense['u_name'];
        expenseModel.exp_name = expense['exp_name'];
        expenseModel.exp_amt = expense['exp_amt'];
        expenseModel.exp_date = expense['exp_date'];
        expenseModel.exp_type = expense['exp_type'];
        if(ness.contains(expenseModel.exp_type)){
          nessTtl += expenseModel.exp_amt!;
        }
        else if(fixed.contains(expenseModel.exp_type)){
          fixedTtl += expenseModel.exp_amt!;
        }
        else if(emergency.contains(expenseModel.exp_type)){
          emergencyTtl += expenseModel.exp_amt!;
        }
        else{
          unNessTtl += expenseModel.exp_amt!;
        }

        expenseModel.exp_trans = expense['exp_trans'];

        if(expenseModel.exp_trans == 'Cash'){
          cash += expenseModel.exp_amt!;
        }
        else if(expenseModel.exp_trans == 'UPI'){
          upi += expenseModel.exp_amt!;
        }
        else if(expenseModel.exp_trans == 'Credit Card'){
          credit += expenseModel.exp_amt!;
        }
        else if(expenseModel.exp_trans == 'Debit Card'){
          debit += expenseModel.exp_amt!;
        }
        else if(expenseModel.exp_trans == 'Net Banking'){
          net += expenseModel.exp_amt!;
        }
        else if(expenseModel.exp_trans == 'Cheque'){
          cheque += expenseModel.exp_amt!;
        }
        else if(expenseModel.exp_trans == 'DD'){
          dd += expenseModel.exp_amt!;
        }
        _expenseList.add(expenseModel);
      });
    });
  }

  bool empty = false;

  @override
  Widget build(BuildContext context) {
    ttl = nessTtl + unNessTtl + fixedTtl + emergencyTtl;

    setState(() {
      empty = _expenseList.isEmpty;
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Analytics",style: TextStyle(
          color: Colors.black,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
        ),),
        backgroundColor: const Color(0xFFffb700),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.all(8.0),
                child: Text('${month[m-1]} Month Expense Stat',style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  fontSize: 16.0,
                ),),
              ),
            ),
            Row(
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
                            const Text('Necessary Expenses',textAlign: TextAlign.center,style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              letterSpacing: 0.8,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                            ),),
                            Text('₹ $nessTtl',style: const TextStyle(
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
                            const Text('Unnecessary Expenses',textAlign: TextAlign.center,style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              letterSpacing: 0.8,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                            ),),
                            Text('₹ $unNessTtl',style: const TextStyle(
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
            Row(
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
                              colors: [Color(0xFF219ebc),Color(0xFF48cae4),Color(0xFFbde0fe)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            )
                        ),
                        height: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Fixed Expenses Total',textAlign: TextAlign.center,style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              letterSpacing: 0.8,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                            ),),
                            Text('₹ $fixedTtl',style: const TextStyle(
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
                              colors: [Color(0xFFffaa00),Color(0xFFffd000),Color(0xFFffea00)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            )
                        ),
                        height: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Emergency Expenses',textAlign: TextAlign.center,style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              letterSpacing: 0.8,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                            ),),
                            Text('₹ $emergencyTtl',style: const TextStyle(
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
            const SizedBox(height: 15.0,),
            Container(
              height: 300,
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                      child: empty ? emptyChart() :
                      PieChart(
                        PieChartData(
                          sections: [
                            PieChartSectionData(
                              color: const Color(0xFF52b788),
                              value: nessTtl.toDouble().roundToDouble(),
                              radius: 50,
                                title: '${(ttl != 0 ? ((nessTtl / ttl) * 100).round() : "N/A")}%',
                              // title: ' ${((nessTtl/ttl)*100).round()}%',
                              titleStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                              )
                            ),
                            PieChartSectionData(
                              color: const Color(0xFFef6351),
                              value: unNessTtl.toDouble().roundToDouble(),
                              radius: 50,
                                title: '${(ttl != 0 ? ((unNessTtl / ttl) * 100).round() : "N/A")}%',
                              // title: ' ${((unNessTtl/ttl)*100).round()}%',
                                titleStyle: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                )
                            ),
                            PieChartSectionData(
                              color: const Color(0xFF219ebc),
                              value: fixedTtl.toDouble().roundToDouble(),
                              radius: 50,
                              title: '${(ttl != 0 ? ((fixedTtl / ttl) * 100).round() : "N/A")}%',
                                titleStyle: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                )
                            ),
                            PieChartSectionData(
                              color: const Color(0xFFffaa00),
                              value: emergencyTtl.toDouble().roundToDouble(),
                              radius: 50,
                                title: '${(ttl != 0 ? ((emergencyTtl / ttl) * 100).round() : "N/A")}%',
                              // title: ' ${((emergencyTtl/ttl)*100).round()}%',
                                titleStyle: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                )
                            ),
                          ]
                        ),
                      )
                  ),
                ],
              ),
            ),
            Container(
              height: 150,
              margin: const EdgeInsets.all(25.0),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 10.0,
                        backgroundColor: Color(0xFF52b788),
                      ),
                      Text(' -> Necessary Expenses',style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                      ),),
                    ],
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 10.0,
                        backgroundColor: Color(0xFFef6351),
                      ),
                      Text(' -> Unnecessary Expenses',style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                      ),),
                    ],
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 10.0,
                        backgroundColor: Color(0xFF219ebc),
                      ),
                      Text(' -> Fixed Expenses',style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                      ),),
                    ],
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 10.0,
                        backgroundColor: Color(0xFFffaa00),
                      ),
                      Text(' -> Emergency Expenses',style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                      ),),
                    ],
                  )
                ],
              ),
            ),
            Row(
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
                              colors: [Color(0xFF007200),Color(0xFF38b000),Color(0xFF9ef01a)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            )
                        ),
                        height: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Expenses By Cash',textAlign: TextAlign.center,style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              letterSpacing: 0.8,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                            ),),
                            Text('₹ $cash',style: const TextStyle(
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
                              colors: [Color(0xFF023e8a),Color(0xFF0077b6),Color(0xFF48cae4)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            )
                        ),
                        height: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Expenses by UPI',textAlign: TextAlign.center,style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              letterSpacing: 0.8,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                            ),),
                            Text('₹ $upi',style: const TextStyle(
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
            Row(
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
                              colors: [Color(0xFFcb997e),Color(0xFFddbea9),Color(0xFFffe8d6)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            )
                        ),
                        height: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Expenses By Card',textAlign: TextAlign.center,style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              letterSpacing: 0.8,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                            ),),
                            Row(
                              children: [
                                Container(
                                  child: const Expanded(
                                    child: Center(
                                      child: Text('Credit ',style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0,
                                      ),),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: const Expanded(
                                    child: Center(
                                      child: Text('Debit ',style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0,
                                      ),),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Expanded(
                                    child: Center(
                                      child: Text('₹ $debit',style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0,
                                      ),),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Expanded(
                                    child: Center(
                                      child: Text('₹ $credit',style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0,
                                      ),),
                                    ),
                                  ),
                                ),
                              ],
                            )
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
                              colors: [Color(0xFF6b9080),Color(0xFFa4c3b2),Color(0xFFcce3de)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            )
                        ),
                        height: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Expenses by Net Banking',textAlign: TextAlign.center,style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              letterSpacing: 0.8,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                            ),),
                            Text('₹ $net',style: const TextStyle(
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
            Row(
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
                              colors: [Color(0xFF595959),Color(0xFFa5a5a5),Color(0xFFcccccc)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            )
                        ),
                        height: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Expenses By Cheque',textAlign: TextAlign.center,style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              letterSpacing: 0.8,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                            ),),
                            Text('₹ $cheque',style: const TextStyle(
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
                              colors: [Color(0xFFff82a9),Color(0xFFff82a9),Color(0xFFffc0be)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            )
                        ),
                        height: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Expenses by DD',textAlign: TextAlign.center,style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              letterSpacing: 0.8,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                            ),),
                            Text('₹ $dd',style: const TextStyle(
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
            const SizedBox(height: 15.0,),
            Container(
              height: 300,
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                      child: empty ? emptyChart() :
                      PieChart(
                        PieChartData(
                            sections: [
                              PieChartSectionData(
                                  color: const Color(0xFF38b000),
                                  value: cash.toDouble().roundToDouble(),
                                  radius: 50,
                                  title: '${(ttl != 0 ? ((cash / ttl) * 100).round() : "N/A")}%',
                                  // title: ' ${((nessTtl/ttl)*100).round()}%',
                                  titleStyle: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                  )
                              ),
                              PieChartSectionData(
                                  color: const Color(0xFF0077b6),
                                  value: upi.toDouble().roundToDouble(),
                                  radius: 50,
                                  title: '${(ttl != 0 ? ((upi / ttl) * 100).round() : "N/A")}%',
                                  // title: ' ${((unNessTtl/ttl)*100).round()}%',
                                  titleStyle: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                  )
                              ),
                              PieChartSectionData(
                                  color: const Color(0xFFcb997e),
                                  value: debit.toDouble().roundToDouble() + credit.toDouble().roundToDouble(),
                                  radius: 50,
                                  title: '${(ttl != 0 ? (((credit + debit) / ttl) * 100).round() : "N/A")}%',
                                  titleStyle: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                  )
                              ),
                              PieChartSectionData(
                                  color: const Color(0xFF6b9080),
                                  value: net.toDouble().roundToDouble(),
                                  radius: 50,
                                  title: '${(ttl != 0 ? ((net / ttl) * 100).round() : "N/A")}%',
                                  // title: ' ${((emergencyTtl/ttl)*100).round()}%',
                                  titleStyle: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                  )
                              ),
                              PieChartSectionData(
                                  color: const Color(0xFFa5a5a5),
                                  value: cheque.toDouble().roundToDouble(),
                                  radius: 50,
                                  title: '${(ttl != 0 ? ((cheque / ttl) * 100).round() : "N/A")}%',
                                  // title: ' ${((emergencyTtl/ttl)*100).round()}%',
                                  titleStyle: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                  )
                              ),
                              PieChartSectionData(
                                  color: const Color(0xFFff82a9),
                                  value: dd.toDouble().roundToDouble(),
                                  radius: 50,
                                  title: '${(ttl != 0 ? ((dd / ttl) * 100).round() : "N/A")}%',
                                  // title: ' ${((emergencyTtl/ttl)*100).round()}%',
                                  titleStyle: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                  )
                              ),
                            ]
                        ),
                      )
                  ),
                ],
              ),
            ),
            Container(
              height: 250,
              margin: const EdgeInsets.all(25.0),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 10.0,
                        backgroundColor: Color(0xFF38b000),
                      ),
                      Text(' -> Expenses by Cash',style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                      ),),
                    ],
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 10.0,
                        backgroundColor: Color(0xFF0077b6),
                      ),
                      Text(' -> Expenses by UPI',style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                      ),),
                    ],
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 10.0,
                        backgroundColor: Color(0xFFcb997e),
                      ),
                      Text(' -> Expenses by Card',style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                      ),),
                    ],
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 10.0,
                        backgroundColor: Color(0xFF6b9080),
                      ),
                      Text(' -> Expenses by Net Banking',style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                      ),),
                    ],
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 10.0,
                        backgroundColor: Color(0xFFa5a5a5),
                      ),
                      Text(' -> Expenses by Cheque',style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                      ),),
                    ],
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 10.0,
                        backgroundColor: Color(0xFFff82a9),
                      ),
                      Text(' -> Expenses by DD',style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                      ),),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFffb700),
        onPressed: () {
          selectMonth(context);
        },
        child: const Icon(Icons.filter_alt_outlined,color: Colors.black,),
      ),
    );
  }

  Future<void> selectMonth(BuildContext context) async {
    DateTime? picked = await showMonthPicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2022),
      lastDate: DateTime(2024),
      headerColor: const Color(0xFFffb700),
      headerTextColor: Colors.black,
      selectedMonthBackgroundColor: const Color(0xFFffb700),
      selectedMonthTextColor: Colors.black,
      unselectedMonthTextColor: Colors.grey,
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        m = picked.month;
        getAllExpenses();
        empty = _expenseList.isEmpty;
      });
    }
  }

  emptyChart(){
    return Container(
      height: 200,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'images/empty_expAnalytics.jpg',
          ),
          fit: BoxFit.fitHeight,
        )
      ),
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(25.0),
          padding: const EdgeInsets.all(25.0),
          child: Text("No Expenses has been recorded on ${month[m-1]} Month, please check it for other months",style: const TextStyle(
            color: Colors.black,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),),
        ),
      ),
    );
  }

  emptyTable(){
    return Container(
      height: 200,
      decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'images/empty_expAnalytics.jpg',
            ),
            fit: BoxFit.fitHeight,
          )
      ),
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(25.0),
          padding: const EdgeInsets.all(25.0),
          child: Text("No Necessary Expenses has been recorded on ${month[m-1]} Month, please check it for other months",style: const TextStyle(
            color: Colors.black,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),),
        ),
      ),
    );
  }
}
