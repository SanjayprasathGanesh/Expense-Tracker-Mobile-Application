import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import '../database/incomeService.dart';
import '../models/incomeModel.dart';

class UpdateIncome extends StatefulWidget {
  final IncomeModel incomeModel;
  const UpdateIncome({Key? key,required this.incomeModel}) : super(key: key);

  @override
  State<UpdateIncome> createState() => _UpdateIncomeState();
}

class _UpdateIncomeState extends State<UpdateIncome> {
  TextEditingController inc_name = TextEditingController();
  TextEditingController inc_date = TextEditingController();
  TextEditingController inc_amt = TextEditingController();

  IncomeService _incomeService = IncomeService();

  String selectedType = 'Salary';
  String selectedTrans = 'Cash';

  bool validateName = false,validateDate = false,validateAmt = false,validateType  = false,validateTrans = false;

  @override
  void initState() {
    super.initState();
    inc_name.text = widget.incomeModel.inc_name!;
    inc_date.text = widget.incomeModel.inc_date!;
    inc_amt.text = widget.incomeModel.inc_amt!.toString();
    selectedType = widget.incomeModel.inc_type!;
    selectedTrans = widget.incomeModel.inc_trans!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Incomes",style: TextStyle(
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
                    label: const Text("Enter Income Name",style: TextStyle(
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
                    errorText: validateName ? ' Empty Income Name Field' : null,
                  ),
                  keyboardType: TextInputType.text,
                  controller: inc_name,
                  cursorColor: Colors.yellow,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                TextField(
                  decoration: InputDecoration(
                    label: const Text("Enter Income Date",style: TextStyle(
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
                    errorText: validateDate ? ' Empty Income Date Field' : null ,
                    suffixIcon: const Icon(Icons.date_range_outlined,color: Colors.black,),
                  ),
                  keyboardType: TextInputType.text,
                  controller: inc_date,
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
                    label: const Text("Enter Income Amount",style: TextStyle(
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
                    errorText: validateAmt ? ' Empty Income Amount Field'  : null ,
                  ),
                  keyboardType: TextInputType.number,
                  controller: inc_amt,
                  cursorColor: Colors.yellow,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Text("Select Income Type",
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
                const Text("Select Income Transaction",
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
                                inc_name.clear();
                                inc_amt.clear();
                                inc_date.clear();
                                selectedType = 'Salary';
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
                                validateName = inc_name.text.isNotEmpty;
                                validateDate = inc_date.text.isNotEmpty;
                                validateAmt = inc_amt.text.isNotEmpty;
                                validateType = selectedType.isNotEmpty;
                                validateTrans = selectedTrans.isNotEmpty;
                              });
                              if(validateName && validateDate && validateAmt && validateType && validateTrans){

                                var incomeModel = IncomeModel();
                                incomeModel.id = widget.incomeModel.id!;
                                incomeModel.u_name = widget.incomeModel.u_name;
                                incomeModel.inc_name = inc_name.text.toString();
                                incomeModel.inc_date = inc_date.text.toString();
                                incomeModel.inc_amt = int.parse(inc_amt.text.toString());
                                incomeModel.inc_type = selectedType.toString();
                                incomeModel.inc_trans = selectedTrans.toString();
                                var result = await _incomeService.UpdateIncome(incomeModel);

                                ToastContext().init(context);
                                if(result != null){
                                  Toast.show(
                                    "Income Updated Successfully",
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
                                    "Sorry,Income Not Updated Successfully",
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
      inc_date.text = _picked.toString().split(" ")[0];
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
              'Salary',
              'Rent',
              'Business Profit',
              'FD Interest',
              'Stocks',
              'Trading',
              'Others',
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