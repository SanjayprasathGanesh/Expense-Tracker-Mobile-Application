import 'package:expense_tracker/database/leaveService.dart';
import 'package:expense_tracker/models/leaveModel.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class ViewLeaveTracker extends StatefulWidget {
  final String u_name;
  const ViewLeaveTracker({Key? key, required this.u_name}) : super(key: key);

  @override
  State<ViewLeaveTracker> createState() => _ViewLeaveTrackerState();
}

class _ViewLeaveTrackerState extends State<ViewLeaveTracker> {

  LeaveService _leaveService = LeaveService();

  List<LeaveModel> _leaveList = <LeaveModel>[];

  List<String> month = ['January','Febraury','March','April','May','June','July','August','September','October','November','December'];
  int m = DateTime.now().month;
  
  var total = 0;

  bool isLoaded = false, check = false;

  @override
  initState(){
    super.initState();
    getAllLeave();
    showLeaves(context);
  }
  
  getAllLeave() async{
    total = 0;
    var leave = await _leaveService.ReadAllLeave(widget.u_name, m);
    _leaveList = <LeaveModel>[];
    leave.forEach((l){
      setState(() {
        var leaveModel = LeaveModel();
        leaveModel.id = l['id'];
        leaveModel.u_name = l['u_name'];
        leaveModel.from_date = l['from_date'];
        leaveModel.to_date = l['to_date'];
        leaveModel.from_day = l['from_day'];
        leaveModel.to_day = l['to_day'];
        leaveModel.type = l['type'];
        leaveModel.sub = l['sub'];
        leaveModel.ttl_days = l['ttl_days'];
        total += leaveModel.ttl_days!;
        _leaveList.add(leaveModel);
      });
    });
  }

  showLeaves(BuildContext context){
    return ListView.builder(
        itemCount: _leaveList.length,
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
                      Text(_leaveList[index].from_date!,style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontSize: 15.0,
                      ),),
                      Text(_leaveList[index].to_date!,style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontSize: 15.0,
                      ),)
                    ],
                  ),
                  const SizedBox(height: 10.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_leaveList[index].from_day!,style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontSize: 15.0,
                      ),),
                      Text(_leaveList[index].to_day!,style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontSize: 15.0,
                      ),)
                    ],
                  ),
                  const SizedBox(height: 10.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Leave Total : ${_leaveList[index].ttl_days!.toString()} days',style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontSize: 15.0,
                      ),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: (){
                                updateLeaveDays(context, _leaveList[index].id!, _leaveList[index].u_name!, _leaveList[index].from_date!, _leaveList[index].to_date!, _leaveList[index].from_day!, _leaveList[index].to_day!, _leaveList[index].type!, _leaveList[index].sub!, _leaveList[index].ttl_days!.toString());
                              },
                              icon: const Icon(Icons.edit_note_sharp,color: Colors.green,size: 30.0,)
                          ),
                          IconButton(
                              onPressed: (){
                                deleteLeave(context, _leaveList[index].id!,_leaveList[index].u_name!, _leaveList[index].ttl_days!);
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
                      Text(_leaveList[index].type! == null ? '-' : _leaveList[index].type!,style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontSize: 15.0,
                      ),),
                      Text(_leaveList[index].sub!,style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontSize: 15.0,
                      ),),
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

    if(isLoaded && _leaveList.isEmpty){
      check = true;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFffb700),
        title: const Text("Leave Days Tracker",style: TextStyle(
          color: Colors.black,
          fontFamily: 'Poppins',
          fontSize: 17.0,
          fontWeight: FontWeight.bold,
        ),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text('${month[m-1]} Leave Days',style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'Poppins',
            ),),
            Container(
              height: 750,
              margin: const EdgeInsets.all(12.0),
              child: _leaveList.isEmpty ? emptyLeave() : showLeaves(context),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFffb700),
        onPressed: (){
          addLeaveDays(context);
        },
        child: const Icon(Icons.add,size: 30.0,color: Colors.black,),
      ),
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Total Leave Days on ${month[m-1]} : ",style: const TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins',
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),),
            Text('$total',style: const TextStyle(
              color: Colors.blue,
              fontFamily: 'Poppins',
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),),
          ],
        )
      ],
    );
  }

  addLeaveDays(BuildContext context){
    TextEditingController from_date = TextEditingController();
    TextEditingController to_date = TextEditingController();
    TextEditingController from_day = TextEditingController();
    TextEditingController to_day = TextEditingController();
    TextEditingController ttlDays = TextEditingController();
    TextEditingController type = TextEditingController();
    TextEditingController sub = TextEditingController();
    String selected_type = 'Function';

    setState(() {
      type.text = selected_type;
    });

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
              value: selected_type,
              onChanged: (String? newValue) {
                setState(() {
                  selected_type = newValue!;
                  type.text = selected_type;
                });
              },
              isExpanded: true,
              items: <String>[
                'Function',
                'Outing',
                'Personal Works',
                'Emergency Leave',
                'Not Feeling well',
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

    bool validateFromDate = false, validateToDate = false,validateTtlDays = false,validateSub = false;

    List<String> days = ['','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'];

    void updateTotalDays() {
      if (from_date.text.isNotEmpty && to_date.text.isNotEmpty) {
        DateTime fromDate = DateTime.parse(from_date.text);
        DateTime toDate = DateTime.parse(to_date.text);

        if (fromDate.isAfter(toDate)) {
          ttlDays.text = "Invalid";
        }
        else {
          Duration duration = toDate.difference(fromDate);
          int difference = duration.inDays + 1;
          if (difference == 1) {
            ttlDays.text = "1";
          } else {
            ttlDays.text = difference.toString();
          }
        }
      }
    }

    selectFromDate() async{
      DateTime? selected = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(DateTime.now().year),
          lastDate: DateTime(DateTime.now().year+1),
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
          from_date.text = selected.toString().split(" ")[0];
          from_day.text = days[selected.weekday];
          updateTotalDays();
        });
      }
    }

    selectToDate() async{
      DateTime? selected = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(DateTime.now().year),
          lastDate: DateTime(DateTime.now().year+1),
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
          to_date.text = selected.toString().split(" ")[0];
          to_day.text = days[selected.weekday];
          updateTotalDays();
        });
      }
    }

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: const Color(0xFFffc8dd),
        builder: (param){
          return SingleChildScrollView(
            child: Container(
              height: 700,
              margin: const EdgeInsets.all(15.0),
              width: double.infinity,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Record Your Leave Days',style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),),
                      IconButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.clear_outlined,color: Colors.black,size: 30.0,)
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            label: const Text("Select From Date",style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                            ),),
                            errorText: validateFromDate ? 'Empty From Date Field' : null,
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
                          controller: from_date,
                          readOnly: true,
                          onTap: (){
                            selectFromDate();
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            label: const Text("Select To Date",style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                            ),),
                            errorText: validateToDate ? 'Empty To Date Field' : null,
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
                          controller: to_date,
                          readOnly: true,
                          onTap: (){
                            selectToDate();
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            label: const Text("From Day",style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
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
                          controller: from_day,
                          keyboardType: TextInputType.datetime,
                          readOnly: true,
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            label: const Text("To Day",style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
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
                          controller: to_day,
                          keyboardType: TextInputType.datetime,
                          readOnly: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            label: const Text("Select the Type",style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                            ),),
                            // errorText: validateType ? 'Empty From Date Field' : null,
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
                          controller: type,
                          readOnly: true,
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                          child: selectType()
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      label: const Text("Enter the Reason",style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
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
                      errorText: validateSub ? 'Empty Reason Field' : null,
                    ),
                    controller: sub,
                    maxLines: 3,
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      label: const Text("Total Days",style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
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
                    keyboardType: TextInputType.number,
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
                              from_date.clear();
                              to_date.clear();
                              from_day.clear();
                              to_day.clear();
                              sub.clear();
                              type.clear();
                              ttlDays.clear();
                            });
                          },
                          child: const Text("Clear",style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                          ),)
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          onPressed: (){
                            setState(() {
                              validateFromDate = from_date.text.isEmpty;
                              validateToDate = to_date.text.isEmpty;
                              validateSub = sub.text.isEmpty;
                              validateTtlDays = ttlDays.text.isEmpty && ttlDays.text.toString() != 'Invalid';
                            });

                            ToastContext().init(context);

                            if(!validateFromDate && !validateToDate && !validateSub && !validateTtlDays && ttlDays.text.toString() != 'Invalid'){
                              var leaveModel = LeaveModel();
                              leaveModel.u_name = widget.u_name;
                              leaveModel.from_date = from_date.text;
                              leaveModel.to_date = to_date.text;
                              leaveModel.from_day = from_day.text;
                              leaveModel.to_day = to_day.text;
                              leaveModel.type = type.text;
                              leaveModel.sub = sub.text;
                              leaveModel.ttl_days = int.parse(ttlDays.text);

                              var result = _leaveService.AddLeave(leaveModel);

                              if(result != null){
                                Toast.show(
                                  'Leave Days has been added successfully',
                                  duration: 3,
                                  backgroundColor: Colors.green,
                                  textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                  ),
                                  gravity: Toast.bottom,
                                );

                                Navigator.pop(context);

                                setState(() {
                                  getAllLeave();
                                });
                              }
                              else{
                                Toast.show(
                                  'OOPs,Leave Days not added successfully',
                                  duration: 3,
                                  backgroundColor: Colors.red,
                                  textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                  ),
                                  gravity: Toast.bottom,
                                );
                              }
                            }
                            else if(ttlDays.text.toString() == 'Invalid'){
                              Toast.show(
                                'Invalid Dates',
                                duration: 3,
                                backgroundColor: Colors.red,
                                textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Poppins',
                                ),
                                gravity: Toast.bottom,
                              );
                            }
                            else{
                              Toast.show(
                                'Empty Fields',
                                duration: 3,
                                backgroundColor: Colors.red,
                                textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Poppins',
                                ),
                                gravity: Toast.bottom,
                              );
                            }
                          },
                          child: const Text("Save",style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
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

  updateLeaveDays(BuildContext context,int id, String u_name, String fromDate, String toDate, String fromDay, String toDay, String t, String reason, String ttl){
    TextEditingController from_date = TextEditingController();
    TextEditingController to_date = TextEditingController();
    TextEditingController from_day = TextEditingController();
    TextEditingController to_day = TextEditingController();
    TextEditingController ttlDays = TextEditingController();
    TextEditingController type = TextEditingController();
    TextEditingController sub = TextEditingController();

    String selected_type = t;

    setState(() {
      from_date.text = fromDate;
      to_date.text = toDate;
      from_day.text = fromDay;
      to_day.text = toDay;
      ttlDays.text = ttl;
      sub.text = reason;
      type.text = selected_type;
    });

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
              value: selected_type,
              onChanged: (String? newValue) {
                setState(() {
                  selected_type = newValue!;
                  type.text = selected_type;
                });
              },
              isExpanded: true,
              items: <String>[
                'Function',
                'Outing',
                'Personal Works',
                'Emergency Leave',
                'Not Feeling well',
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

    bool validateFromDate = false, validateToDate = false,validateTtlDays = false,validateSub = false;

    List<String> days = ['','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'];

    void updateTotalDays() {
      if (from_date.text.isNotEmpty && to_date.text.isNotEmpty) {
        DateTime fromDate = DateTime.parse(from_date.text);
        DateTime toDate = DateTime.parse(to_date.text);

        if (fromDate.isAfter(toDate)) {
          ttlDays.text = "Invalid";
        }
        else {
          Duration duration = toDate.difference(fromDate);
          int difference = duration.inDays + 1;
          if (difference == 1) {
            ttlDays.text = "1";
          } else {
            ttlDays.text = difference.toString();
          }
        }
      }
    }

    selectFromDate() async{
      DateTime? selected = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(DateTime.now().year),
          lastDate: DateTime(DateTime.now().year+1),
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
          from_date.text = selected.toString().split(" ")[0];
          from_day.text = days[selected.weekday];
          updateTotalDays();
        });
      }
    }

    selectToDate() async{
      DateTime? selected = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(DateTime.now().year),
          lastDate: DateTime(DateTime.now().year+1),
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
          to_date.text = selected.toString().split(" ")[0];
          to_day.text = days[selected.weekday];
          updateTotalDays();
        });
      }
    }

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: const Color(0xFFffc8dd),
        builder: (param){
          return SingleChildScrollView(
            child: Container(
              height: 700,
              margin: const EdgeInsets.all(15.0),
              width: double.infinity,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Update Your Leave Days',style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),),
                      IconButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.clear_outlined,color: Colors.black,size: 30.0,)
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            label: const Text("Select From Date",style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                            ),),
                            errorText: validateFromDate ? 'Empty From Date Field' : null,
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
                          controller: from_date,
                          readOnly: true,
                          onTap: (){
                            selectFromDate();
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            label: const Text("Select To Date",style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                            ),),
                            errorText: validateToDate ? 'Empty To Date Field' : null,
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
                          controller: to_date,
                          readOnly: true,
                          onTap: (){
                            selectToDate();
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            label: const Text("From Day",style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
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
                          controller: from_day,
                          keyboardType: TextInputType.datetime,
                          readOnly: true,
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            label: const Text("To Day",style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
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
                          controller: to_day,
                          keyboardType: TextInputType.datetime,
                          readOnly: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            label: const Text("Select the Type",style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                            ),),
                            // errorText: validateType ? 'Empty From Date Field' : null,
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
                          controller: type,
                          readOnly: true,
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                          child: selectType()
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      label: const Text("Enter the Reason",style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
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
                      errorText: validateSub ? 'Empty Reason Field' : null,
                    ),
                    controller: sub,
                    maxLines: 3,
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      label: const Text("Total Days",style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
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
                    keyboardType: TextInputType.number,
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
                              from_date.clear();
                              to_date.clear();
                              from_day.clear();
                              to_day.clear();
                              sub.clear();
                              ttlDays.clear();
                            });
                          },
                          child: const Text("Clear",style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                          ),)
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          onPressed: (){
                            setState(() {
                              validateFromDate = from_date.text.isEmpty;
                              validateToDate = to_date.text.isEmpty;
                              validateSub = sub.text.isEmpty;
                              validateTtlDays = ttlDays.text.isEmpty && ttlDays.text.toString() != 'Invalid';
                            });

                            ToastContext().init(context);

                            if(!validateFromDate && !validateToDate && !validateSub && !validateTtlDays && ttlDays.text.toString() != 'Invalid'){
                              var leaveModel = LeaveModel();
                              leaveModel.id = id;
                              leaveModel.u_name = u_name;
                              leaveModel.from_date = from_date.text;
                              leaveModel.to_date = to_date.text;
                              leaveModel.from_day = from_day.text;
                              leaveModel.to_day = to_day.text;
                              leaveModel.type = type.text;
                              leaveModel.sub = sub.text;
                              leaveModel.ttl_days = int.parse(ttlDays.text);

                              var result = _leaveService.UpdateLeave(leaveModel);

                              if(result != null){
                                Toast.show(
                                  'Leave Days has been updated successfully',
                                  duration: 3,
                                  backgroundColor: Colors.green,
                                  textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                  ),
                                  gravity: Toast.bottom,
                                );

                                Navigator.pop(context);

                                setState(() {
                                  getAllLeave();
                                });
                              }
                              else{
                                Toast.show(
                                  'OOPs,Leave Days not updated successfully',
                                  duration: 3,
                                  backgroundColor: Colors.red,
                                  textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                  ),
                                  gravity: Toast.bottom,
                                );
                              }
                            }
                            else if(ttlDays.text.toString() == 'Invalid'){
                              Toast.show(
                                'Invalid Dates',
                                duration: 3,
                                backgroundColor: Colors.red,
                                textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Poppins',
                                ),
                                gravity: Toast.bottom,
                              );
                            }
                            else{
                              Toast.show(
                                'Empty Fields',
                                duration: 3,
                                backgroundColor: Colors.red,
                                textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Poppins',
                                ),
                                gravity: Toast.bottom,
                              );
                            }
                          },
                          child: const Text("Update",style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
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

  deleteLeave(BuildContext context,int id,String u_name, int ttl_days){
    return showDialog(
        context: context,
        builder: (param){
          return AlertDialog(
            title: const Text("Do You Want to Delete this Leave",style: TextStyle(
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
                  var result = await _leaveService.DeleteLeave(id, u_name);

                  if(result != null){
                    Toast.show(
                        'Leave on this Date has been Deleted Successfully',
                        duration: 3,
                        gravity: Toast.bottom,
                        backgroundColor: Colors.green,
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                        )
                    );
                    total -= ttl_days;

                    Navigator.pop(context);

                    getAllLeave();

                    if(_leaveList.length == 1){
                      setState(() {
                        emptyLeave();
                      });
                    }
                  }
                  else{
                    Toast.show(
                        'Oops!!, this Leave Date is not Deleted ',
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

  emptyLeave() {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Image(
              image: AssetImage(
                'images/empty1.jpg',
              ),
              fit: BoxFit.fill,
              height: 250.0,
            ),
            const SizedBox(height: 20),
            const Text(
              'Empty Leave Days for this Month',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Add Your Leave Days',
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
                addLeaveDays(context);
              },
              child: const Text('Add Diary',style: TextStyle(
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
