import 'package:expense_tracker/database/leaveService.dart';
import 'package:expense_tracker/models/leaveModel.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LeaveAnalytics extends StatefulWidget {
  final String u_name;
  const LeaveAnalytics({Key? key, required this.u_name}) : super(key: key);

  @override
  State<LeaveAnalytics> createState() => _LeaveAnalyticsState();
}

class _LeaveAnalyticsState extends State<LeaveAnalytics> {

  List<LeaveModel> _leaveList = <LeaveModel>[];
  LeaveService _leaveService = LeaveService();
  List<String> month = ['January','Febraury','March','April','May','June','July','August','September','October','November','December'];
  int m = DateTime.now().month;


  var function = 0,outing = 0,personal = 0,emergency = 0,feeling = 0,others = 0;

  @override
  initState(){
    super.initState();
    getAllLeave();
  }

  getAllLeave() async{
    function = 0;
    outing = 0;
    personal = 0;
    emergency = 0;
    feeling = 0;
    others = 0;

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
        if(leaveModel.type == 'Function'){
          function++;
        }
        else if(leaveModel.type == 'Outing'){
          outing++;
        }
        else if(leaveModel.type == 'Personal Works'){
          personal++;
        }
        else if(leaveModel.type == 'Emergency Leave'){
          emergency++;
        }
        else if(leaveModel.type == 'Not Feeling Well'){
          feeling++;
        }
        else if(leaveModel.type == 'Others'){
          others++;
        }
        leaveModel.sub = l['sub'];
        leaveModel.ttl_days = l['ttl_days'];
        _leaveList.add(leaveModel);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Leave Analytics",style: TextStyle(
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
            const SizedBox(
              height: 10.0,
            ),
            Text('${DateTime.now().year.toString()} Year Leave Analytics',style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),),
            const SizedBox(
              height: 20.0,
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
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Annual Leaves',textAlign: TextAlign.center,style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              letterSpacing: 0.8,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                            ),),
                            Text('84 days',style: TextStyle(
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
                            const Text('Your Leaves',textAlign: TextAlign.center,style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              letterSpacing: 0.8,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                            ),),
                            Text(_leaveList.length.toString(),style: const TextStyle(
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)
                  ),
                  child: Container(
                    width: 200,
                    margin: const EdgeInsets.all(5.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFFbc6c25),Color(0xFFdda15e),Color(0xFFffe6a7)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        )
                    ),
                    height: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Balance Leaves',textAlign: TextAlign.center,style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          letterSpacing: 0.8,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                        ),),
                        Text('${84 - _leaveList.length}',style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                        ),)
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 300,
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                      child: PieChart(
                        PieChartData(
                            sections: [
                              PieChartSectionData(
                                  color: const Color(0xFF52b788),
                                  value: function.toDouble().roundToDouble(),
                                  radius: 50,
                                  title: '${(function != 0 ? ((function / _leaveList.length) * 100).round() : "N/A")}%',
                                  titleStyle: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                  )
                              ),
                              PieChartSectionData(
                                  color: const Color(0xFFef6351),
                                  value: outing.toDouble().roundToDouble(),
                                  radius: 50,
                                  title: '${(outing != 0 ? ((outing / _leaveList.length) * 100).round() : "N/A")}%',
                                  titleStyle: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                  )
                              ),
                              PieChartSectionData(
                                  color: const Color(0xFF219ebc),
                                  value: personal.toDouble().roundToDouble(),
                                  radius: 50,
                                  title: '${(personal != 0 ? ((personal  / _leaveList.length) * 100).round() : "N/A")}%',
                                  titleStyle: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                  )
                              ),
                              PieChartSectionData(
                                  color: const Color(0xFFffaa00),
                                  value: emergency.toDouble().roundToDouble(),
                                  radius: 50,
                                  title: '${(emergency != 0 ? ((emergency  / _leaveList.length) * 100).round() : "N/A")}%',
                                  titleStyle: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                  )
                              ),
                              PieChartSectionData(
                                  color: const Color(0xFFffafcc),
                                  value: feeling.toDouble().roundToDouble(),
                                  radius: 50,
                                  title: '${(feeling != 0 ? ((feeling / _leaveList.length) * 100).round() : "N/A")}%',
                                  titleStyle: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                  )
                              ),
                              PieChartSectionData(
                                  color: const Color(0xFF582f0e),
                                  value: others.toDouble().roundToDouble(),
                                  radius: 50,
                                  title: '${(others != 0 ? ((others  / _leaveList.length) * 100).round() : "N/A")}%',
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
              height: 300,
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
                      Text(' -> Function Leaves',style: TextStyle(
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
                      Text(' -> Outing Leaves',style: TextStyle(
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
                      Text(' -> Personal Leaves',style: TextStyle(
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
                      Text(' -> Emergency Leaves',style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                      ),),
                    ],
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 10.0,
                        backgroundColor: Color(0xFFffafcc),
                      ),
                      Text(' -> Feeling Leaves',style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                      ),),
                    ],
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 10.0,
                        backgroundColor: Color(0xFF582f0e),
                      ),
                      Text(' -> Others Leaves',style: TextStyle(
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
                            const Text('Leave by Function',textAlign: TextAlign.center,style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              letterSpacing: 0.8,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                            ),),
                            Text('$function',style: const TextStyle(
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
                              colors: [Color(0xFFbf0603),Color(0xFFd62828),Color(0xFFdd2d4a)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            )
                        ),
                        height: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Leave by Outing',textAlign: TextAlign.center,style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              letterSpacing: 0.8,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                            ),),
                            Text('$outing',style: const TextStyle(
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
                              colors: [Color(0xFF023e8a),Color(0xFF0077b6),Color(0xFF00b4d8)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            )
                        ),
                        height: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Leave by Personal',textAlign: TextAlign.center,style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              letterSpacing: 0.8,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                            ),),
                            Text('$personal',style: const TextStyle(
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
                              colors: [Color(0xFFf77f00),Color(0xFFffbe0b),Color(0xFFfcbf49)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            )
                        ),
                        height: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Leave by Emergency',textAlign: TextAlign.center,style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              letterSpacing: 0.8,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                            ),),
                            Text('$emergency',style: const TextStyle(
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
                              colors: [Color(0xFFf28482),Color(0xFFffafcc),Color(0xFFffc8dd)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            )
                        ),
                        height: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Leave by Feelings',textAlign: TextAlign.center,style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              letterSpacing: 0.8,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                            ),),
                            Text('$feeling',style: const TextStyle(
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
                              colors: [Color(0xFF582f0e),Color(0xFF7f4f24),Color(0xFF936639)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            )
                        ),
                        height: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Leave by Others',textAlign: TextAlign.center,style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              letterSpacing: 0.8,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                            ),),
                            Text('$others',style: const TextStyle(
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
          ],
        ),
      ),
    );
  }
}
