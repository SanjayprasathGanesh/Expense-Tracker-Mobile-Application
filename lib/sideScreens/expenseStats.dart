import 'package:expense_tracker/database/expenseService.dart';
import 'package:expense_tracker/models/expenseModel.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import '../expenses/updateExpense.dart';

class ExpenseStats extends StatefulWidget {
  final String u_name;
  const ExpenseStats({Key? key, required this.u_name}) : super(key: key);

  @override
  State<ExpenseStats> createState() => _ExpenseStatsState();
}

class _ExpenseStatsState extends State<ExpenseStats> {

  ExpenseService _expenseService = ExpenseService();

  TextEditingController date = TextEditingController();
  TextEditingController amt = TextEditingController();
  String selectedCat = 'Date';

  List<String> type = ['Food', 'Hotel Food', 'Online Food Order', 'Snacks', 'Fuel',
    'Maintenence', 'Fruits & Vegetables', 'Groceries', 'Dairy Products', 'Provisional Items',
    'Health Care', 'Stationary', 'Fees', 'Studies', 'Clothes', 'Rent', 'Service', 'Insurance',
    'Tax', 'EMI', 'Phone Recharge', 'WIFI', 'Electricity Bill', 'Water Bill', 'Cable Bill',
    'Gas Bill', 'Maid Salary', 'Beauty & Parlour', 'Cosmetics', 'Pooja Items', 'Donation',
    'Subscription', 'Appliances', 'Gadgets', 'Online Shopping', 'Travelling fare', 'Taxi Fare',
    'Personal', 'Emergency', 'Pharmacy Products', 'Hospital Fare', 'Others'];

  List<String> trans = ['Cash', 'UPI', 'Credit Card', 'Debit Card', 'Net Banking'];

  String selectedType = 'Food';
  String selectedTransaction = 'Cash';

  bool validateDate = false, validateAmt = false,isFound = false,isLoaded = false;

  Future<DateTime?> selectDate() async{
    DateTime? selected = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime.now(),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: const ColorScheme.light(
                primary: Color(0xFFffb700),
                onPrimary: Colors.white,
                surface: Colors.teal,
                onSurface: Colors.white,
              ),
              buttonTheme: const ButtonThemeData(
                textTheme: ButtonTextTheme.primary,
              ),
            ),
            child: child!,
          );
        },
    );

    if(selected != null){
      date.text = selected.toString().split(" ")[0];
    }
  }

  var expense;
  List<ExpenseModel> _expenseList = <ExpenseModel>[];
  var total = 0;

  @override
  initState(){
    super.initState();
    getAllExpenses();
    showExpenses(context);
  }

  getAllExpenses() async{
    total = 0;
    var expenses = expense;
    _expenseList = <ExpenseModel>[];
    expenses.forEach((expense){
      var expenseModel = ExpenseModel();
      expenseModel.id = expense['id'];
      expenseModel.u_name = expense['u_name'];
      expenseModel.exp_name = expense['exp_name'];
      expenseModel.exp_date = expense['exp_date'];
      expenseModel.exp_amt = expense['exp_amt'];
      total += expenseModel.exp_amt!;
      expenseModel.exp_type = expense['exp_type'];
      expenseModel.exp_trans = expense['exp_trans'];
      _expenseList.add(expenseModel);
    });
  }

  showExpenses(BuildContext context) {
    return ListView.builder(
        itemCount: _expenseList.length,
        itemBuilder: (context, index){
          return Padding(
            padding: const EdgeInsets.only(left: 15.0,right: 15.0,top: 5.0),
            child: Card(
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
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Stat",style: TextStyle(
          color: Colors.black,
          fontFamily: 'Poppins',
          fontSize: 17.0,
          fontWeight: FontWeight.bold,
        ),),
        backgroundColor: const Color(0xFFffb700),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10.0,right: 10.0,top: 5.0,bottom: 5.0),
              padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 5.0,bottom: 5.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(),
                            fixedSize: const Size(150, 40),
                            backgroundColor: selectedCat == 'Date' ? Colors.yellowAccent : Colors.transparent,
                          ),
                          onPressed: (){
                            setState(() {
                              selectedCat = 'Date';
                              _expenseList.clear();
                              total = 0;
                            });
                          },
                          child: const Text("Date",style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                          ),)
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(),
                            fixedSize: const Size(150, 40),
                            backgroundColor: selectedCat == 'Amount' ? Colors.yellowAccent : Colors.transparent,
                          ),
                          onPressed: (){
                            setState(() {
                              selectedCat = 'Amount';
                              _expenseList.clear();
                              total = 0;
                            });
                          },
                          child: const Text("Amount",style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                          ),)
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10.0,right: 10.0),
              padding: const EdgeInsets.only(left: 10.0,right: 10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(),
                            fixedSize: const Size(150, 40),
                            backgroundColor: selectedCat == 'Type' ? Colors.yellowAccent : Colors.transparent,
                          ),
                          onPressed: (){
                            setState(() {
                              selectedCat = 'Type';
                              _expenseList.clear();
                              total = 0;
                            });
                          },
                          child: const Text("Type",style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                          ),)
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(),
                            fixedSize: const Size(150, 40),
                            backgroundColor: selectedCat == 'Transaction' ? Colors.yellowAccent : Colors.transparent,
                          ),
                          onPressed: (){
                            setState(() {
                              selectedCat = 'Transaction';
                              _expenseList.clear();
                              total = 0;
                            });
                          },
                          child: const Text("Transaction",style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                          ),)
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Column(
                        children: [
                          if (selectedCat == 'Date')
                            Container(
                              height: 50.0,
                              child: TextField(
                                decoration: InputDecoration(
                                  label: Text("Enter $selectedCat Value",style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                    fontSize: 13.0,
                                  ),),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.orange,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  errorText: validateDate ? 'Empty Date Field' : null,
                                ),
                                controller: date,
                                keyboardType: TextInputType.datetime,
                                onTap: (){
                                  selectDate();
                                },
                              ),
                            ),
                          if(selectedCat == 'Amount')
                            Container(
                              height: 50,
                              child: TextField(
                                decoration: InputDecoration(
                                  label: Text("Enter $selectedCat Value",style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                    fontSize: 13.0,
                                  ),),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.orange,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  errorText: validateAmt ? 'Empty Amount Field' : null,
                                ),
                                controller: amt,
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          if (selectedCat == 'Type')
                            Container(
                              height: 70,
                              width: double.infinity,
                              padding: const EdgeInsets.all(10.0),
                              child: DropdownButton<String>(
                                value: selectedType,
                                hint: const Text('Select Type'),
                                onChanged: (String? value){
                                  setState(() {
                                    selectedType = value!;
                                  });
                                },
                                items: type.map((String type) {
                                  return DropdownMenuItem<String>(
                                    value: type,
                                    child: Text(type),
                                  );
                                }).toList(),
                              ),
                            ),
                          if (selectedCat == 'Transaction')
                            Container(
                              height: 70,
                              width: double.infinity,
                              padding: const EdgeInsets.all(10.0),
                              child: DropdownButton<String>(
                                value: selectedTransaction,
                                hint: const Text('Select Transaction'),
                                onChanged: (String? value) {
                                  setState(() {
                                    selectedTransaction = value!;
                                  });
                                },
                                items: trans.map((String transaction) {
                                  return DropdownMenuItem<String>(
                                    value: transaction,
                                    child: Text(transaction),
                                  );
                                }).toList(),
                              ),
                            ),
                        ],
                      )
                  ),
                  const SizedBox(width: 10.0,),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      onPressed: () async{

                        ToastContext().init(context);
                        setState(() {
                          date.text.isEmpty ? validateDate = true : validateDate = false;
                          amt.text.isEmpty ? validateAmt = true : validateAmt = false;
                        });

                        if(selectedCat == 'Date' && !validateDate){
                          var dateSearch = await _expenseService.GetExpenseByDate(widget.u_name, date.text);
                          expense = dateSearch;
                          if(expense.toString().length > 2){
                            setState(() {
                              getAllExpenses();
                              isFound = true;
                              isLoaded = true;
                            });
                          }
                          else{
                            setState(() {
                              isFound = false;
                              isLoaded = true;
                            });
                          }
                        }
                        else if(selectedCat == 'Amount' && !validateAmt){
                          var amtSearch = await _expenseService.GetExpenseByAmt(widget.u_name, int.parse(amt.text));
                          expense = amtSearch;
                          if(expense.toString().length > 2){
                            setState(() {
                              getAllExpenses();
                              isFound = true;
                              isLoaded = true;
                            });
                          }
                          else{
                            setState(() {
                              isFound = false;
                              isLoaded = true;
                            });
                          }
                        }
                        else if(selectedCat == 'Type'){
                          var amtSearch = await _expenseService.GetExpenseByType(widget.u_name, selectedType);
                          expense = amtSearch;
                          if(expense.toString().length > 2){
                            setState(() {
                              getAllExpenses();
                              isFound = true;
                              isLoaded = true;
                            });
                          }
                          else{
                            setState(() {
                              isFound = false;
                              isLoaded = true;
                            });
                          }
                        }
                        else if(selectedCat == 'Transaction'){
                          var amtSearch = await _expenseService.GetExpenseByTrans(widget.u_name, selectedTransaction);
                          expense = amtSearch;
                          if(expense.toString().length > 2){
                            setState(() {
                              getAllExpenses();
                              isFound = true;
                              isLoaded = true;
                            });
                          }
                          else{
                            setState(() {
                              isFound = false;
                              isLoaded = true;
                            });
                          }
                        }
                        else{
                          Toast.show(
                            'No Filter Applied',
                            duration: 5,
                            backgroundColor: Colors.red,
                            textStyle: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                            )
                          );
                        }
                      },
                      child: const Icon(Icons.search,color: Colors.black,),
                  )
                ],
              ),
            ),
            Container(
              height: 500,
              child: isLoaded ? isFound ? showExpenses(context) : emptyExpenses() : const SizedBox(height: 100,),
            )
          ],
        ),
      ),
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Expenses by $selectedCat",style: const TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins',
            ),),
            Text("₹ $total",style: const TextStyle(
              color: Colors.green,
              fontFamily: 'Poppins',
            ),),
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
    total = 0;
    return Container(
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage(
                'images/noresult.jpg',
              ),
              fit: BoxFit.fill,
              height: 350.0,
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
