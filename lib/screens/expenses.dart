import 'dart:math';
import 'package:expense_tracker/database/expenseService.dart';
import 'package:expense_tracker/incomes/viewAllIncome.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import '../expenses/addExpense.dart';
import '../expenses/updateExpense.dart';
import '../models/expenseModel.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class Expenses extends StatefulWidget {
  final String u_name;
  const Expenses({Key? key, required this.u_name}) : super(key: key);

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  ExpenseService _expenseService = ExpenseService();
  List<ExpenseModel> _expenseList = <ExpenseModel>[];

  List<String> month = ['January','Febraury','March','April','May','June','July','August','September','October','November','December'];
  int m = DateTime.now().month;

  late var total = 0;

  DateTime selectedDate = DateTime.now();

  @override
  initState() {
    super.initState();
    getAllExpenses();
    showAllExpenses(context);
  }

  bool isLoaded = false,check = false;

  getAllExpenses() async{
    total = 0;
    var expenses = await _expenseService.ReadAllExpense(widget.u_name,m);
    _expenseList = <ExpenseModel>[];
    expenses.forEach((expense){
      setState(() {
        var expenseModel = ExpenseModel();
        expenseModel.id = expense['id'];
        expenseModel.u_name = expense['u_name'];
        expenseModel.exp_name = expense['exp_name'];
        expenseModel.exp_amt = expense['exp_amt'];
        total += expenseModel.exp_amt!;
        expenseModel.exp_date = expense['exp_date'];
        expenseModel.exp_type = expense['exp_type'];
        expenseModel.exp_trans = expense['exp_trans'];
        _expenseList.add(expenseModel);
        isLoaded = true;
      });
    });
  }

  showAllExpenses(BuildContext context) {
    return ListView.builder(
        itemCount: _expenseList.length,
        itemBuilder: (context, index){
          return Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 10,
            margin: const EdgeInsets.only(bottom: 10,top: 10),
            child: ListTile(
                contentPadding: const EdgeInsets.all(8.0),
              title: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_expenseList[index].exp_date!,style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                      ),),
                      Text('₹${_expenseList[index].exp_amt}',style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                      ),),
                    ],
                  ),
                  const SizedBox(height: 10.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_expenseList[index].exp_name!,style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                      ),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateExpense(expenseModel: _expenseList[index],))).then((data){
                                  if(data != null){
                                    getAllExpenses();
                                  }
                                });
                              },
                              icon: const Icon(Icons.edit_note_sharp,color: Colors.green,size: 30.0,)
                          ),
                          IconButton(
                              onPressed: (){
                                deleteExpense(context, _expenseList[index].id!, _expenseList[index].exp_amt! ,widget.u_name);
                              },
                              icon: const Icon(Icons.delete_outline,color: Colors.red,size: 30.0,)
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 10.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_expenseList[index].exp_type!,style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                      ),),
                      Text(_expenseList[index].exp_trans!,style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                      ),),
                    ],
                  ),
                  const SizedBox(height: 10.0,),
                ],
              )
            ),
          );
        }
    );
  }


  @override
  Widget build(BuildContext context) {

    if(isLoaded && _expenseList.length == 0){
      check = true;
    }

    return Scaffold(
      body: Visibility(
          visible: isLoaded,
          replacement: Center(
            child: check ? const CircularProgressIndicator(color: Colors.deepOrange,) : emptyExpenses(),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 5.0,
                ),
                Text('${month[m-1]} Month Expenses',style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),),
                Container(
                  margin: const EdgeInsets.only(left: 15.0,right: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Ink(
                        decoration: const ShapeDecoration(
                          color: Color(0xFFffb700),
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                          onPressed: () {
                            selectMonth(context);
                          },
                          icon: const Icon(Icons.filter_alt_outlined, color: Colors.black),
                        ),
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFffb700),
                          ),
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ViewAllIncome(u_name: widget.u_name,)));
                          },
                          child: const Text("Incomes",style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                          ),)
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Container(
                  height: 580,
                  margin: const EdgeInsets.only(left: 15.0,right: 15.0,top: 2.0,bottom: 2.0),
                  padding: const EdgeInsets.all(5.0),
                  child: _expenseList.isEmpty ? emptyExpenses() : showAllExpenses(context),
                )
              ],
            ),
          )
      ),
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${month[m-1]} Month Total',style: const TextStyle(
              color: Colors.black,
              // fontSize: 10.0,
              fontFamily: 'Poppins',
            ),),
            Text('₹ $total',style: const TextStyle(
              color: Colors.green,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),)
          ],
        )
      ],
    );
  }

  deleteExpense(BuildContext context,int id,int amt,String u_name){
    return showDialog(
        context: context,
        builder: (param){
          return AlertDialog(
            title: const Text("Do You Want to Delete this Expense",style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.black,
            ),),
            actions: [
              TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel",style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                  ),),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: () async{
                  var result = await _expenseService.DeleteExpense(id, u_name);

                  if(result != null){
                    Toast.show(
                      'Expense Deleted Successfully',
                      duration: 3,
                      gravity: Toast.bottom,
                      backgroundColor: Colors.green,
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                      )
                    );

                    total -= amt;

                    Navigator.pop(context);

                    getAllExpenses();

                    if(_expenseList.length == 1){
                      setState(() {
                        emptyExpenses();
                      });
                    }
                  }
                  else{
                    Toast.show(
                      'Oops!!, Expense not Deleted ',
                      duration: 3,
                      gravity: Toast.bottom,
                      backgroundColor: Colors.red,
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                        )
                    );
                  }
                },
                child: const Text("Delete",style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                ),),
              ),
            ],
          );
        }
    );
  }

  emptyExpenses() {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Image(
                image: AssetImage(
                  'images/empty_expense.jpg',
                ),
                fit: BoxFit.fill,
                height: 250.0,
            ),
            const SizedBox(height: 20),
            const Text(
              'Empty Expenses for this Month',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Add Your Daily Expenses',
              style: TextStyle(
                color: Colors.grey,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFffb700)
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddExpense(u_name: widget.u_name,))).then((data){
                  if(data != null){
                    getAllExpenses();
                  }
                });
              },
              child: const Text('Add Expense',style: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
              ),),
            ),
          ],
        ),
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
      });
    }
  }
}
