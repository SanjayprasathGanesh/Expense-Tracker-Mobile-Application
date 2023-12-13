import 'package:expense_tracker/database/expenseService.dart';
import 'package:expense_tracker/models/expenseModel.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class AddExpense extends StatefulWidget {
  final String u_name;
  const AddExpense({Key? key, required this.u_name}) : super(key : key);

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {

  TextEditingController exp_name = TextEditingController();
  TextEditingController exp_date = TextEditingController();
  TextEditingController exp_amt = TextEditingController();

  ExpenseService _expenseService = ExpenseService();

  String selectedType = 'Food';
  String selectedTrans = 'Cash';

  bool validateName = false,validateDate = false,validateAmt = false,validateType  = false,validateTrans = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Expenses",style: TextStyle(
          color: Colors.black,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
          fontSize: 17.0,
        ),),
        backgroundColor: const Color(0xFFffb700),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            height: 670,
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(10.0),
            decoration: const BoxDecoration(
              color: Color(0xFFdf9a57),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 20.0,
                ),
                TextField(
                  decoration: InputDecoration(
                    label: const Text("Enter Expense Name",style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.yellow,
                    ),),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: const BorderSide(color: Colors.black)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.yellow),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    errorText: validateName ? ' Empty Expense Name Field' : null,
                  ),
                  keyboardType: TextInputType.text,
                  controller: exp_name,
                  cursorColor: Colors.yellow,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                TextField(
                  decoration: InputDecoration(
                      label: const Text("Enter Expense Date",style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.yellow,
                      ),),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(color: Colors.black)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.yellow),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      errorText: validateDate ? ' Empty Expense Date Field' : null ,
                      suffixIcon: const Icon(Icons.date_range_outlined,color: Colors.black,),
                  ),
                  keyboardType: TextInputType.text,
                  controller: exp_date,
                  cursorColor: Colors.yellow,
                  onTap: (){
                    selectDate();
                  },
                ),
                const SizedBox(
                  height: 10.0,
                ),
                TextField(
                  decoration: InputDecoration(
                    label: const Text("Enter Expense Amount",style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.yellow,
                    ),),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: const BorderSide(color: Colors.black)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.yellow),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    errorText: validateAmt ? ' Empty Expense Amount Field'  : null ,
                  ),
                  keyboardType: TextInputType.number,
                  controller: exp_amt,
                  cursorColor: Colors.yellow,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Text("Select Expense Type",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),),
                const SizedBox(
                  height: 8.0,
                ),
                selectType(),
                const SizedBox(
                  height: 10.0,
                ),
                const Text("Select Expense Transaction",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                  ),),
                const SizedBox(
                  height: 8.0,
                ),
                selectTrans(),
                const SizedBox(
                  height: 10.0,
                ),
                Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            onPressed: (){
                              setState(() {
                                exp_name.clear();
                                exp_amt.clear();
                                exp_date.clear();
                                selectedType = 'Food';
                                selectedTrans = 'Cash';
                              });
                            },
                            child: const Text("Clear",style: TextStyle(
                              fontFamily: 'Poppins'
                            ),)
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                            onPressed: () async{
                              setState(() {
                                validateName = exp_name.text.isNotEmpty;
                                validateDate = exp_date.text.isNotEmpty;
                                validateAmt = exp_amt.text.isNotEmpty;
                                validateType = selectedType.isNotEmpty;
                                validateTrans = selectedTrans.isNotEmpty;
                              });
                              if(validateName && validateDate && validateAmt && validateType && validateTrans){
                                var expenseModel = ExpenseModel();
                                expenseModel.u_name = widget.u_name;
                                expenseModel.exp_name = exp_name.text.toString();
                                expenseModel.exp_date = exp_date.text.toString();
                                expenseModel.exp_amt = int.parse(exp_amt.text.toString());
                                expenseModel.exp_type = selectedType.toString();
                                expenseModel.exp_trans = selectedTrans.toString();
                                var result = await _expenseService.AddExpense(expenseModel);
                                ToastContext().init(context);
                                if(result != null){
                                  Toast.show(
                                    "Expense Added Successfully",
                                    gravity: Toast.bottom,
                                    backgroundColor: Colors.green,
                                    duration: 3,
                                    textStyle: const TextStyle(
                                      fontFamily: 'Poppins',
                                    ),
                                  );
                                  Navigator.pop(context,result);
                                }
                                else{
                                  Toast.show(
                                    "Sorry,Expense Not Added Successfully",
                                    gravity: Toast.bottom,
                                    backgroundColor: Colors.red,
                                    duration: 3,
                                    textStyle: const TextStyle(
                                      fontFamily: 'Poppins',
                                    ),
                                  );
                                }
                              }
                              else{
                                Toast.show(
                                  "Some Empty Inputs",
                                  gravity: Toast.bottom,
                                  backgroundColor: Colors.red,
                                  duration: 3,
                                  textStyle: const TextStyle(
                                    fontFamily: 'Poppins',
                                  ),
                                );
                              }

                            },
                            child: const Text("Save",style: TextStyle(
                                fontFamily: 'Poppins'
                            ),)
                        )
                      ],
                    )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> selectDate() async{
    DateTime? _picked = await showDatePicker(
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

    if(_picked != null){
      exp_date.text = _picked.toString().split(" ")[0];
    }
  }

  selectType() {
    return Container(
      height: 90,
      width: double.infinity,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border.all(
          color: Colors.black,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(5.0)
      ),
      padding: const EdgeInsets.all(10.0),
      child: Column(
          children: [
            DropdownButton<String>(
              value: selectedType,
              onChanged: (String? newValue) {
                setState(() {
                  selectedType = newValue!;
                });
              },
              isExpanded: true,
              items: <String>[
                'Food',
                'Hotel Food',
                'Online Food Order',
                'Snacks',
                'Fuel',
                'Maintenence',
                'Fruits & Vegetables',
                'Groceries',
                'Dairy Products',
                'Provisional Items',
                'Health Care',
                'Stationary',
                'Fees',
                'Studies',
                'Clothes',
                'Rent',
                'Service',
                'Insurance',
                'Tax',
                'EMI',
                'Phone Recharge',
                'WIFI',
                'Electricity Bill',
                'Water Bill',
                'Cable Bill',
                'Gas Bill',
                'Maid Salary',
                'Beauty & Parlour',
                'Cosmetics',
                'Pooja Items',
                'Donation',
                'Subscription',
                'Appliances',
                'Gadgets',
                'Online Shopping',
                'Travelling fare',
                'Taxi Fare',
                'Personal',
                'Emerygency',
                'Pharmacy Products',
                'Hospital Fare',
                'Others,'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value,style: const TextStyle(
                    fontFamily: 'Poppins',
                  ),),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
          ],
      ),
    );
  }

  selectTrans() {
    return Container(
      height: 90,
      width: double.infinity,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(
            color: Colors.black,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(5.0)
      ),
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          DropdownButton<String>(
            value: selectedTrans,
            onChanged: (String? newValue) {
              setState(() {
                selectedTrans = newValue!;
              });
            },
            isExpanded: true,
            items: <String>[
              'Cash',
              'UPI',
              'Credit Card',
              'Debit Card',
              'Net Banking',
              'Cheque',
              'DD',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value,style: const TextStyle(
                  fontFamily: 'Poppins',
                ),),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
