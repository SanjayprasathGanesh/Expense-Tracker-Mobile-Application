import 'package:expense_tracker/database/incomeService.dart';
import 'package:expense_tracker/incomes/addIncome.dart';
import 'package:expense_tracker/incomes/updateIncome.dart';
import 'package:expense_tracker/models/incomeModel.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class ViewAllIncome extends StatefulWidget {
  final String u_name;
  const ViewAllIncome({Key? key, required this.u_name}) : super(key: key);


  @override
  State<ViewAllIncome> createState() => _ViewAllIncomeState();
}

class _ViewAllIncomeState extends State<ViewAllIncome> {

  List<IncomeModel> _incomeList = <IncomeModel>[];
  IncomeService _incomeService = IncomeService();

  List<String> month = ['January','Febraury','March','April','May','June','July','August','September','October','November','December'];
  int m = DateTime.now().month;

  var total = 0;

  DateTime selectedDate = DateTime.now();

  @override
  initState(){
    super.initState();
    getIncomes();
    showAllIncome(context);
  }

  bool isLoaded = false, check = false;

  getIncomes() async{
    total = 0;
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
        total += incomeModel.inc_amt!;
        incomeModel.inc_type = income['inc_type'];
        incomeModel.inc_trans = income['inc_trans'];
        isLoaded = true;
        _incomeList.add(incomeModel);
      });
    });
  }

  showAllIncome(BuildContext context){
    return ListView.builder(
        itemCount: _incomeList.length,
        itemBuilder: (context, index){
          return Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            margin: const EdgeInsets.only(bottom: 10,top: 10),
            elevation: 10.0,
            child: ListTile(
              contentPadding: const EdgeInsets.all(8.0),
              title: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_incomeList[index].inc_date!,style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                      ),),
                      Text('₹ ${_incomeList[index].inc_amt}',style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                      ),)
                    ],
                  ),
                  const SizedBox(height: 10.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_incomeList[index].inc_name!,style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                      ),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateIncome(incomeModel: _incomeList[index],))).then((data){
                                  if(data != null){
                                    getIncomes();
                                  }
                                });
                              },
                              icon: const Icon(Icons.edit_note_sharp,color: Colors.green,size: 30.0,)
                          ),
                          IconButton(
                              onPressed: (){
                                deleteIncome(context, _incomeList[index].id!, _incomeList[index].inc_amt! , _incomeList[index].u_name!);
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
                      Text(_incomeList[index].inc_type!,style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                      ),),
                      Text(_incomeList[index].inc_trans!,style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                      ),)
                    ],
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {

    if(isLoaded && _incomeList.length == 0){
      check = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("User Incomes",style: TextStyle(
          color: Colors.black,
          fontSize: 17.0,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
        ),),
        backgroundColor: const Color(0xFFffb700),
      ),
      body: Visibility(
          visible: isLoaded,
          replacement: Center(
            child: check ? const CircularProgressIndicator() : emptyIncomes(),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 15.0,right: 10.0,top: 10.0,bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${month[m-1]} Month Incomes",style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),),
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
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(15.0),
                  height: 750,
                  child: _incomeList.isEmpty ? emptyIncomes() : showAllIncome(context),
                )
              ],
            ),
          ),
      ),
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${month[m-1]} Month Total Salary',style: const TextStyle(
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

  deleteIncome(BuildContext context,int id,int amt,String u_name){
    return showDialog(
        context: context,
        builder: (param){
          return AlertDialog(
            title: const Text("Do You Want to Delete this Income",style: TextStyle(
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
                  var result = await _incomeService.DeleteIncome(id, u_name);

                  if(result != null){
                    Toast.show(
                        'Income Deleted Successfully',
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

                    getIncomes();

                    if(_incomeList.length == 1){
                      setState(() {
                        emptyIncomes();
                      });
                    }
                  }
                  else{
                    Toast.show(
                        'Oops!!, Income not Deleted ',
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

  emptyIncomes() {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Image(
              image: AssetImage(
                'images/empty_income.jpg',
              ),
              fit: BoxFit.fill,
              height: 250.0,
            ),
            const SizedBox(height: 20),
            const Text(
              'Empty Incomes for this Month',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Add Your Monthly Incomes',
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddIncome(u_name: widget.u_name,))).then((data){
                  if(data != null){
                    getIncomes();
                  }
                });
              },
              child: const Text('Add Income',style: TextStyle(
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
        getIncomes();
      });
    }
  }
}
