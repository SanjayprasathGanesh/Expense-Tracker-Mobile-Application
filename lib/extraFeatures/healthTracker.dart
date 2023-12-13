import 'package:expense_tracker/database/healthService.dart';
import 'package:expense_tracker/models/healthModel.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class HealthTracker extends StatefulWidget {
  final String u_name;
  const HealthTracker({Key? key, required this.u_name}) : super(key: key);

  @override
  State<HealthTracker> createState() => _HealthTrackerState();
}

class _HealthTrackerState extends State<HealthTracker> {

  HealthService _healthService = HealthService();
  List<String> month = ['January','Febraury','March','April','May','June','July','August','September','October','November','December'];
  int m = DateTime.now().month;
  List<String> days = ['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'];

  List<HealthModel> _healthList = <HealthModel>[];

  @override
  initState(){
    super.initState();
    getAllHealth();
    showHealth(context);
  }

  getAllHealth() async{
    var health = await _healthService.ReadAllHealth(widget.u_name, m);
    _healthList = <HealthModel>[];
    health.forEach((h){
      setState(() {
        var healthModel = HealthModel();
        healthModel.id = h['id'];
        healthModel.u_name = h['u_name'];
        healthModel.start_date = h['start_date'];
        healthModel.end_date = h['end_date'];
        healthModel.total_days = h['total_days'];
        _healthList.add(healthModel);
      });
    });
  }

  showHealth(BuildContext context){
    return ListView.builder(
        itemCount: _healthList.length,
        itemBuilder: (context, index){
          String d = DateTime.parse('${_healthList[index].start_date!} 00:00:00').add(const Duration(days: 26)).toString().split(" ")[0];
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
                      Text(_healthList[index].start_date!.toString(),style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontSize: 15.0
                      ),),
                      Text(_healthList[index].end_date!.toString(),style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontSize: 15.0
                      ),)
                    ],
                  ),
                  const SizedBox(height: 10.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text('${_healthList[index].total_days}',style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: 15.0
                          ),)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: (){
                                updateHealth(context, _healthList[index].id!, _healthList[index].u_name!, _healthList[index].start_date!, _healthList[index].end_date!, _healthList[index].total_days!);
                              },
                              icon: const Icon(Icons.edit_note_sharp,color: Colors.green,size: 30.0,)
                          ),
                          IconButton(
                              onPressed: (){
                                deleteHealth(context, _healthList[index].id!,_healthList[index].u_name!);
                              },
                              icon: const Icon(Icons.delete_outline,color: Colors.red,size: 30.0,)
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 10.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text('Next Expected on $d',style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontSize: 15.0,
                          ),),
                          const SizedBox(
                            width: 10.0,
                          ),
                          const Text('',style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontSize: 15.0,
                          ),),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15.0,
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFffb700),
        title: const Text("Health Tracker",style: TextStyle(
          color: Colors.black,
          fontFamily: 'Poppins',
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(15.0),
              height: 700,
              width: double.infinity,
              child: _healthList.isEmpty ? emptyHealth() : showHealth(context),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFffb700),
        onPressed: (){
          addHealth(context);
        },
        child: const Icon(Icons.add,color: Colors.black,),
      ),
    );
  }

  addHealth(BuildContext context){

    TextEditingController startDate = TextEditingController();
    TextEditingController endDate = TextEditingController();
    TextEditingController ttlDays = TextEditingController();

    bool validateStartDate = false, validateEndDate = false, validateTtlDays = false;

    void updateTotalDays() {
      if (startDate.text.isNotEmpty && endDate.text.isNotEmpty) {
        DateTime fromDate = DateTime.parse(startDate.text);
        DateTime toDate = DateTime.parse(endDate.text);

        if (fromDate.isAfter(toDate)) {
          ttlDays.text = "Invalid";
        }
        else {
          Duration duration = toDate.difference(fromDate);
          int difference = duration.inDays + 1;
          if (difference == 1) {
            ttlDays.text = "1";
          }
          else {
            ttlDays.text = difference.toString();
          }
        }
      }
    }

    selectStartDate() async{
      DateTime? selected = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(DateTime.now().year),
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
          }
      );

      if(selected != null){
        setState(() {
          startDate.text = selected.toString().split(" ")[0];
          updateTotalDays();
        });
      }
    }

    selectEndDate() async{
      DateTime? selected = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(DateTime.now().year),
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
          }
      );

      if(selected != null){
        setState(() {
          endDate.text = selected.toString().split(" ")[0];
          updateTotalDays();
        });
      }
    }

    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: const Color(0xFFb7e4c7),
        context: context,
        builder: (param){
          return SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(15.0),
              height: 500,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Add the Health Record',style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                      ),),
                      IconButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.clear, size: 30.0, color: Colors.black,)
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            label: const Text("Enter the Start Date",style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: 13.0,
                            ),),
                            errorText: validateStartDate ? 'Empty Start Date Field' : null,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                )
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  color: Color(0xFFe85d04),
                                )
                            ),
                          ),
                          controller: startDate,
                          readOnly: true,
                          onTap: (){
                            selectStartDate();
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            label: const Text("Enter the End Date",style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: 13.0,
                            ),),
                            errorText: validateEndDate ? 'Empty End Date Field' : null,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                )
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  color: Color(0xFFe85d04),
                                )
                            ),
                          ),
                          controller: endDate,
                          readOnly: true,
                          onTap: (){
                            selectEndDate();
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      label: const Text("Total Days",style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontSize: 13.0,
                      ),),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.black,
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Color(0xFFe85d04),
                          )
                      ),
                    ),
                    controller: ttlDays,
                    readOnly: true,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          onPressed: (){
                            setState(() {
                              startDate.clear();
                              endDate.clear();
                              ttlDays.clear();
                            });
                          },
                          child: const Text('Clear',style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontSize: 15.0,
                          ),)
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          onPressed: () async{
                            ToastContext().init(context);
                            setState(() {
                              validateStartDate = startDate.text.isEmpty;
                              validateEndDate = endDate.text.isEmpty;
                              validateTtlDays = ttlDays.text.isEmpty;
                            });

                            if(!validateStartDate && !validateEndDate && !validateTtlDays && ttlDays.text.toString() != 'Invalid'){
                              var healthModel = HealthModel();
                              healthModel.u_name = widget.u_name;
                              healthModel.start_date = startDate.text;
                              healthModel.end_date = endDate.text;
                              healthModel.total_days = int.parse(ttlDays.text.toString());

                              var result = await _healthService.AddHealth(healthModel);
                              if(result != null){
                                Toast.show(
                                    'Health Record Successfully Added',
                                    duration: 3,
                                    backgroundColor: Colors.green,
                                    gravity: Toast.bottom,
                                    textStyle: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Poppins',
                                    )
                                );

                                getAllHealth();

                                Navigator.pop(context);
                              }
                              else{
                                Toast.show(
                                    'Health Record not Added Today',
                                    duration: 3,
                                    backgroundColor: Colors.red,
                                    gravity: Toast.bottom,
                                    textStyle: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Poppins',
                                    )
                                );
                              }
                            }
                            else{
                              ToastContext().context;
                              Toast.show(
                                  'Empty Fields',
                                  duration: 3,
                                  backgroundColor: Colors.red,
                                  gravity: Toast.bottom,
                                  textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                  )
                              );
                            }
                          },
                          child: const Text('Save',style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontSize: 15.0,
                          ),)
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        }
    );
  }

  updateHealth(BuildContext context,int id, String u_name, String start, String end, int ttl){

    TextEditingController startDate = TextEditingController();
    TextEditingController endDate = TextEditingController();
    TextEditingController ttlDays = TextEditingController();

    bool validateStartDate = false, validateEndDate = false, validateTtlDays = false;

    setState(() {
      startDate.text = start;
      endDate.text = end;
      ttlDays.text = ttl.toString();
    });

    void updateTotalDays() {
      if (startDate.text.isNotEmpty && endDate.text.isNotEmpty) {
        DateTime fromDate = DateTime.parse(startDate.text);
        DateTime toDate = DateTime.parse(endDate.text);

        if (fromDate.isAfter(toDate)) {
          ttlDays.text = "Invalid";
        }
        else {
          Duration duration = toDate.difference(fromDate);
          int difference = duration.inDays + 1;
          if (difference == 1) {
            ttlDays.text = "1";
          }
          else {
            ttlDays.text = difference.toString();
          }
        }
      }
    }

    selectStartDate() async{
      DateTime? selected = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(DateTime.now().year),
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
          }
      );

      if(selected != null){
        setState(() {
          startDate.text = selected.toString().split(" ")[0];
          updateTotalDays();
        });
      }
    }

    selectEndDate() async{
      DateTime? selected = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(DateTime.now().year),
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
          }
      );

      if(selected != null){
        setState(() {
          endDate.text = selected.toString().split(" ")[0];
          updateTotalDays();
        });
      }
    }

    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: const Color(0xFFb7e4c7),
        context: context,
        builder: (param){
          return SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(15.0),
              height: 500,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Update the Health Record',style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                      ),),
                      IconButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.clear, size: 30.0, color: Colors.black,)
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            label: const Text("Enter the Start Date",style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: 13.0,
                            ),),
                            errorText: validateStartDate ? 'Empty Start Date Field' : null,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                )
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  color: Color(0xFFe85d04),
                                )
                            ),
                          ),
                          controller: startDate,
                          readOnly: true,
                          onTap: (){
                            selectStartDate();
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            label: const Text("Enter the End Date",style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: 13.0,
                            ),),
                            errorText: validateEndDate ? 'Empty End Date Field' : null,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                )
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  color: Color(0xFFe85d04),
                                )
                            ),
                          ),
                          controller: endDate,
                          readOnly: true,
                          onTap: (){
                            selectEndDate();
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      label: const Text("Total Days",style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontSize: 13.0,
                      ),),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.black,
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Color(0xFFe85d04),
                          )
                      ),
                    ),
                    controller: ttlDays,
                    readOnly: true,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          onPressed: (){
                            setState(() {
                              startDate.clear();
                              endDate.clear();
                              ttlDays.clear();
                            });
                          },
                          child: const Text('Clear',style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontSize: 15.0,
                          ),)
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          onPressed: () async{
                            ToastContext().init(context);
                            setState(() {
                              validateStartDate = startDate.text.isEmpty;
                              validateEndDate = endDate.text.isEmpty;
                              validateTtlDays = ttlDays.text.isEmpty;
                            });

                            if(!validateStartDate && !validateEndDate && !validateTtlDays && ttlDays.text.toString() != 'Invalid'){
                              var healthModel = HealthModel();
                              healthModel.id = id;
                              healthModel.u_name = u_name;
                              healthModel.start_date = startDate.text;
                              healthModel.end_date = endDate.text;
                              healthModel.total_days = int.parse(ttlDays.text.toString());

                              var result = await _healthService.UpdateHealth(healthModel);
                              if(result != null){
                                Toast.show(
                                    'Health Record Updated Successfully Added',
                                    duration: 3,
                                    backgroundColor: Colors.green,
                                    gravity: Toast.bottom,
                                    textStyle: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Poppins',
                                    )
                                );

                                Navigator.pop(context);

                                getAllHealth();
                              }
                              else{
                                Toast.show(
                                    'Health Record not updated Today',
                                    duration: 3,
                                    backgroundColor: Colors.red,
                                    gravity: Toast.bottom,
                                    textStyle: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Poppins',
                                    )
                                );
                              }
                            }
                            else{
                              ToastContext().context;
                              Toast.show(
                                  'Empty Fields',
                                  duration: 3,
                                  backgroundColor: Colors.red,
                                  gravity: Toast.bottom,
                                  textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                  )
                              );
                            }
                          },
                          child: const Text('Update',style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontSize: 15.0,
                          ),)
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        }
    );
  }

  deleteHealth(BuildContext context,int id,String u_name){
    return showDialog(
        context: context,
        builder: (param){
          return AlertDialog(
            title: const Text("Do You Want to Delete this Health Date",style: TextStyle(
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
                  ToastContext().init(context);
                  var result = await _healthService.DeleteHealth(id, u_name);

                  if(result != null){
                    Toast.show(
                        'Health Period on this Date has been Deleted Successfully',
                        duration: 3,
                        gravity: Toast.bottom,
                        backgroundColor: Colors.green,
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                        )
                    );
                    Navigator.pop(context);

                    getAllHealth();

                    if(_healthList.length == 1){
                      setState(() {
                        emptyHealth();
                      });
                    }
                  }
                  else{
                    Toast.show(
                        'Oops!!, this Health Date is not Deleted ',
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

  emptyHealth() {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Image(
              image: AssetImage(
                'images/emptyHealth.jpg',
              ),
              fit: BoxFit.fill,
              height: 250.0,
            ),
            const SizedBox(height: 20),
            const Text(
              'Empty Health Record for this Month',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Add Your Health Record',
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
                addHealth(context);
              },
              child: const Text('Add Health',style: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
              ),),
            ),
          ],
        ),
      ),
    );
  }
}
