import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import '../database/incomeService.dart';
import '../models/incomeModel.dart';

class IncomeAnalytics extends StatefulWidget {
  final String u_name;
  const IncomeAnalytics({Key? key, required this.u_name}) : super(key: key);

  @override
  State<IncomeAnalytics> createState() => _IncomeAnalyticsState();
}

class _IncomeAnalyticsState extends State<IncomeAnalytics> {
  List<String> month = ['January','Febraury','March','April','May','June','July','August','September','October','November','December'];
  int m = DateTime.now().month;

  DateTime selectedDate = DateTime.now();

  IncomeService _incomeService = IncomeService();

  List<IncomeModel> _incomeList = <IncomeModel>[];
  var cash = 0,upi = 0,debit = 0,credit = 0,net = 0,cheque = 0,dd = 0;

  var earnings = 0,side = 0,ttl = 0;

  List<String> _earningsList = ['Salary','Business Profit'];
  
  @override
  initState() {
    super.initState();
    getAllIncomes();
  }

  getAllIncomes() async{
    
    earnings = 0;
    side = 0;
    
    ttl = 0;

    cash = 0;
    upi = 0;
    debit = 0;
    credit = 0;
    net = 0;
    cheque = 0;
    dd = 0;

    var incomes = await _incomeService.ReadAllIncome(widget.u_name,m);
    _incomeList = <IncomeModel>[];
    incomes.forEach((income){
      setState(() {
        var incomeModel = IncomeModel();
        incomeModel.id = income['id'];
        incomeModel.u_name = income['u_name'];
        incomeModel.inc_name = income['inc_name'];
        incomeModel.inc_amt = income['inc_amt'];
        incomeModel.inc_date = income['inc_date'];
        incomeModel.inc_type = income['inc_type'];
        if(_earningsList.contains(incomeModel.inc_type)){
          earnings += incomeModel.inc_amt!;
        }
        else{
          side += incomeModel.inc_amt!;
        }

        incomeModel.inc_trans = income['inc_trans'];

        if(incomeModel.inc_trans == 'Cash'){
          cash += incomeModel.inc_amt!;
        }
        else if(incomeModel.inc_trans == 'UPI'){
          upi += incomeModel.inc_amt!;
        }
        else if(incomeModel.inc_trans == 'Credit Card'){
          credit += incomeModel.inc_amt!;
        }
        else if(incomeModel.inc_trans == 'Debit Card'){
          debit += incomeModel.inc_amt!;
        }
        else if(incomeModel.inc_trans == 'Net Banking'){
          net += incomeModel.inc_amt!;
        }
        else if(incomeModel.inc_trans == 'Cheque'){
          cheque += incomeModel.inc_amt!;
        }
        else if(incomeModel.inc_trans == 'DD'){
          dd += incomeModel.inc_amt!;
        }
        _incomeList.add(incomeModel);
      });
    });
  }

  bool empty = false;

  @override
  Widget build(BuildContext context) {
    ttl = earnings + side;

    setState(() {
      empty = _incomeList.isEmpty;
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Income Analytics",style: TextStyle(
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
                child: Text('${month[m-1]} Month Income Stat',style: const TextStyle(
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
                            const Text('Earning Incomes',textAlign: TextAlign.center,style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              letterSpacing: 0.8,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                            ),),
                            Text('₹ $earnings',style: const TextStyle(
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
                            const Text('Side Incomes',textAlign: TextAlign.center,style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              letterSpacing: 0.8,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                            ),),
                            Text('₹ $side',style: const TextStyle(
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
                                  value: earnings.toDouble().roundToDouble(),
                                  radius: 50,
                                  title: '${(ttl != 0 ? ((earnings / ttl) * 100).round() : "N/A")}%',
                                  // title: ' ${((nessTtl/ttl)*100).round()}%',
                                  titleStyle: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                  )
                              ),
                              PieChartSectionData(
                                  color: const Color(0xFFef6351),
                                  value: side.toDouble().roundToDouble(),
                                  radius: 50,
                                  title: '${(ttl != 0 ? ((side / ttl) * 100).round() : "N/A")}%',
                                  // title: ' ${((unNessTtl/ttl)*100).round()}%',
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 10.0,
                        backgroundColor: Color(0xFF52b788),
                      ),
                      Text(' -> Earning Incomes',style: TextStyle(
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
                      Text(' -> Side Incomes',style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                      ),),
                    ],
                  ),
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
                            const Text('Incomes By Cash',textAlign: TextAlign.center,style: TextStyle(
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
                            const Text('Incomes by UPI',textAlign: TextAlign.center,style: TextStyle(
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
                            const Text('Incomes By Card',textAlign: TextAlign.center,style: TextStyle(
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
                            const Text('Incomes by Net Banking',textAlign: TextAlign.center,style: TextStyle(
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
                            const Text('Incomes By Cheque',textAlign: TextAlign.center,style: TextStyle(
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
                            const Text('Incomes by DD',textAlign: TextAlign.center,style: TextStyle(
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
                      Text(' -> Incomes by Cash',style: TextStyle(
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
                      Text(' -> Incomes by UPI',style: TextStyle(
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
                      Text(' -> Incomes by Card',style: TextStyle(
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
                      Text(' -> Incomes by Net Banking',style: TextStyle(
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
                      Text(' -> Incomes by Cheque',style: TextStyle(
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
                      Text(' -> Incomes by DD',style: TextStyle(
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
        getAllIncomes();
        empty = _incomeList.isEmpty;
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
          child: Text("No Incomes has been recorded on ${month[m-1]} Month, please check it for other months",style: const TextStyle(
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
          child: Text("No Necessary Incomes has been recorded on ${month[m-1]} Month, please check it for other months",style: const TextStyle(
            color: Colors.black,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),),
        ),
      ),
    );
  }
}
