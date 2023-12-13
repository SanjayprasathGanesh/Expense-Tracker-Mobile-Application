import 'package:expense_tracker/database/mileageService.dart';
import 'package:expense_tracker/models/mileageModel.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class MileageCalculator extends StatefulWidget {
  final String u_name;
  const MileageCalculator({Key? key, required this.u_name}) : super(key: key);

  @override
  State<MileageCalculator> createState() => _MileageCalculatorState();
}

class _MileageCalculatorState extends State<MileageCalculator> {

  MileageService _mileageService = MileageService();

  List<MileageModel> _mileageList = <MileageModel>[];

  List<String> month = ['January','Febraury','March','April','May','June','July','August','September','October','November','December'];
  int m = DateTime.now().month;
  List<String> days = ['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'];
  var prev = 0;

  @override
  initState(){
    super.initState();
    getPrevious();
    getAllMileage();
    showMileage(context);
  }

  getPrevious() async{
    var previous = await _mileageService.GetPrevious(widget.u_name, m);
    if(previous.toString().isEmpty){
      prev = 0;
    }
    else{
      previous.forEach((p){
        setState(() {
          prev = p['end_km'];
        });
      });
    }
  }

  getAllMileage() async{
    var mileage = await _mileageService.ReadAllMileage(widget.u_name, m);
    _mileageList = <MileageModel>[];
    mileage.forEach((m){
      setState(() {
        var mileageModel = MileageModel();
        mileageModel.id = m['id'];
        mileageModel.u_name = m['u_name'];
        mileageModel.start_km = m['start_km'];
        mileageModel.end_km = m['end_km'];
        mileageModel.litre = m['litre'];
        mileageModel.price = m['price'];
        mileageModel.date = m['date'];
        mileageModel.day = m['day'];
        _mileageList.add(mileageModel);
        getPrevious();
      });
    });
  }

  showMileage(BuildContext context){
    return ListView.builder(
        itemCount: _mileageList.length,
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
                      Text('Start Km - ${_mileageList[index].start_km!.toString()}',style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontSize: 15.0
                      ),),
                      Text('End Km - ${_mileageList[index].end_km!.toString()}',style: const TextStyle(
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
                          Text('${_mileageList[index].litre} Litre - ₹${_mileageList[index].price} Price',style: const TextStyle(
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
                                updateMileage(context, _mileageList[index].id!, _mileageList[index].u_name!, _mileageList[index].start_km!, _mileageList[index].end_km!, _mileageList[index].date!, _mileageList[index].day!, _mileageList[index].price!, _mileageList[index].litre!);
                              },
                              icon: const Icon(Icons.edit_note_sharp,color: Colors.green,size: 30.0,)
                          ),
                          IconButton(
                              onPressed: (){
                                deleteMileage(context, _mileageList[index].id!,_mileageList[index].u_name!, _mileageList[index].price!, _mileageList[index].litre!);
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
                          Text(_mileageList[index].date!,style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontSize: 15.0,
                          ),),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Text(_mileageList[index].day!,style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontSize: 15.0,
                          ),),
                        ],
                      ),
                      Text('Mileage : ${((_mileageList[index].end_km! - _mileageList[index].start_km!) / _mileageList[index].litre!).round()}',style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontSize: 15.0,
                      ),),
                    ],
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Text('Total Distance : ${(_mileageList[index].end_km! - _mileageList[index].start_km!)}',style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontSize: 15.0,
                  ),),
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
        title: const Text("Mileage Calculator",style: TextStyle(
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
              height: 800,
              width: double.infinity,
              margin: const EdgeInsets.all(10.0),
              child: _mileageList.isEmpty ? emptyMileage() : showMileage(context),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFffb700),
        onPressed: (){
          addMileage(context);
        },
        child: const Icon(Icons.add,color: Colors.black,),
      ),
    );
  }

  addMileage(BuildContext context){

    TextEditingController start_km = TextEditingController();
    TextEditingController end_km = TextEditingController();
    TextEditingController date = TextEditingController();
    TextEditingController day = TextEditingController();
    TextEditingController litre = TextEditingController();
    TextEditingController price = TextEditingController();

    setState(() {
      if(prev != 0){
        start_km.text = prev.toString();
      }
    });

    bool validateStartKm = false, validateEndKm = false, validateDate = false, validateLitre = false, validatePrice = false;

    List<String> days = ['','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday', 'Sunday'];

    selectDate() async{
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
          date.text = selected.toString().split(" ")[0];
          day.text = days[selected.weekday];
        });
      }
    }

    showModalBottomSheet(
        backgroundColor: const Color(0xFFcaf0f8),
        isScrollControlled: true,
        context: context,
        builder: (param){
          return SingleChildScrollView(
            child: Container(
              height: 700,
              margin: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Record Your Fuel Filling ",style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                      ),),
                      IconButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.clear_outlined,color: Colors.black,size: 30.0,),
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
                            label: const Text("Enter the Start Kilometre",style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: 13.0,
                            ),),
                            errorText: validateStartKm ? 'Empty Start Km Field' : null,
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
                          controller: start_km,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            label: const Text("Enter the End Kilometre",style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: 13.0,
                            ),),
                            errorText: validateEndKm ? 'Empty End Km Field' : null,
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
                          controller: end_km,
                          keyboardType: TextInputType.number,
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
                            label: const Text("Enter the Total Litre",style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: 13.0,
                            ),),
                            errorText: validateLitre ? 'Empty Litre Field' : null,
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
                          controller: litre,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            label: const Text("Enter the Price",style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: 13.0,
                            ),),
                            errorText: validatePrice ? 'Empty Price Field' : null,
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
                          controller: price,
                          keyboardType: TextInputType.number,
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
                            label: const Text("Enter the Date",style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: 13.0,
                            ),),
                            errorText: validateDate ? 'Empty Date Field' : null,
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
                          controller: date,
                          readOnly: true,
                          onTap: (){
                            selectDate();
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            label: const Text("Enter the Day",style: TextStyle(
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
                          controller: day,
                          readOnly: true,
                        ),
                      ),
                    ],
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
                              start_km.clear();
                              end_km.clear();
                              litre.clear();
                              price.clear();
                              date.clear();
                              day.clear();
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
                              validateStartKm = start_km.text.isEmpty;
                              validateEndKm = end_km.text.isEmpty;
                              validateLitre = litre.text.isEmpty;
                              validatePrice = price.text.isEmpty;
                              validateDate = date.text.isEmpty;
                            });

                            if(!validateStartKm && !validateEndKm && !validatePrice && !validateLitre && !validateDate){
                              var mileageModel = MileageModel();
                              mileageModel.u_name = widget.u_name;
                              mileageModel.start_km = int.parse(start_km.text.toString());
                              mileageModel.end_km = int.parse(end_km.text.toString());
                              mileageModel.litre = int.parse(litre.text.toString());
                              mileageModel.price = int.parse(price.text.toString());
                              mileageModel.date = date.text.toString();
                              mileageModel.day = day.text.toString();

                              var result = await _mileageService.AddMileage(mileageModel);

                              if(result != null){
                                Toast.show(
                                    'Fuel Added Today is Successfully Added',
                                    duration: 3,
                                    backgroundColor: Colors.green,
                                    gravity: Toast.bottom,
                                    textStyle: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Poppins',
                                    )
                                );

                                Navigator.pop(context);

                                getAllMileage();
                              }
                              else{
                                Toast.show(
                                    'Fuel not Added Today',
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

  updateMileage(BuildContext context,int id, String u_name, int start, int end, String m_date, String m_day, int m_price, int m_litre){

    TextEditingController start_km = TextEditingController();
    TextEditingController end_km = TextEditingController();
    TextEditingController date = TextEditingController();
    TextEditingController day = TextEditingController();
    TextEditingController litre = TextEditingController();
    TextEditingController price = TextEditingController();

    setState(() {
      start_km.text = start.toString();
      end_km.text = end.toString();
      date.text = m_date.toString();
      day.text = m_day.toString();
      litre.text = m_litre.toString();
      price.text = m_price.toString();
    });

    bool validateStartKm = false, validateEndKm = false, validateDate = false, validateLitre = false, validatePrice = false;

    List<String> days = ['','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday', 'Sunday'];

    selectDate() async{
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
          date.text = selected.toString().split(" ")[0];
          day.text = days[selected.weekday];
        });
      }
    }

    showModalBottomSheet(
        backgroundColor: const Color(0xFFcaf0f8),
        isScrollControlled: true,
        context: context,
        builder: (param){
          return SingleChildScrollView(
            child: Container(
              height: 800,
              margin: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Update Your Fuel Filling ",style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                      ),),
                      IconButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.clear_outlined,color: Colors.black,size: 30.0,),
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
                            label: const Text("Enter the Start Kilometre",style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: 13.0,
                            ),),
                            errorText: validateStartKm ? 'Empty Start Km Field' : null,
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
                          controller: start_km,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            label: const Text("Enter the End Kilometre",style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: 13.0,
                            ),),
                            errorText: validateEndKm ? 'Empty End Km Field' : null,
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
                          controller: end_km,
                          keyboardType: TextInputType.number,
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
                            label: const Text("Enter the Total Litre",style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: 13.0,
                            ),),
                            errorText: validateLitre ? 'Empty Litre Field' : null,
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
                          controller: litre,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            label: const Text("Enter the Price",style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: 13.0,
                            ),),
                            errorText: validatePrice ? 'Empty Price Field' : null,
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
                          controller: price,
                          keyboardType: TextInputType.number,
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
                            label: const Text("Enter the Date",style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: 13.0,
                            ),),
                            errorText: validateDate ? 'Empty Date Field' : null,
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
                          controller: date,
                          readOnly: true,
                          onTap: (){
                            selectDate();
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            label: const Text("Enter the Day",style: TextStyle(
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
                          controller: day,
                          readOnly: true,
                        ),
                      ),
                    ],
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
                              start_km.clear();
                              end_km.clear();
                              litre.clear();
                              price.clear();
                              date.clear();
                              day.clear();
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
                              validateStartKm = start_km.text.isEmpty;
                              validateEndKm = end_km.text.isEmpty;
                              validateLitre = litre.text.isEmpty;
                              validatePrice = price.text.isEmpty;
                              validateDate = date.text.isEmpty;
                            });

                            if(!validateStartKm && !validateEndKm && !validatePrice && !validateLitre && !validateDate){
                              var mileageModel = MileageModel();
                              mileageModel.id = id;
                              mileageModel.u_name = u_name;
                              mileageModel.start_km = int.parse(start_km.text.toString());
                              mileageModel.end_km = int.parse(end_km.text.toString());
                              mileageModel.litre = int.parse(litre.text.toString());
                              mileageModel.price = int.parse(price.text.toString());
                              mileageModel.date = date.text.toString();
                              mileageModel.day = day.text.toString();

                              var result = await _mileageService.UpdateMileage(mileageModel);

                              if(result != null){
                                Toast.show(
                                    'Fuel Updated Today is Successfully Added',
                                    duration: 3,
                                    backgroundColor: Colors.green,
                                    gravity: Toast.bottom,
                                    textStyle: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Poppins',
                                    )
                                );

                                Navigator.pop(context);

                                getAllMileage();
                              }
                              else{
                                Toast.show(
                                    'Fuel not Updated Today',
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

  deleteMileage(BuildContext context,int id,String u_name, int price, int litre){
    return showDialog(
        context: context,
        builder: (param){
          return AlertDialog(
            title: const Text("Do You Want to Delete this Fuel Date",style: TextStyle(
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
                  var result = await _mileageService.DeleteMileage(id, u_name);

                  if(result != null){
                    Toast.show(
                        'Fuel on this Date has been Deleted Successfully',
                        duration: 3,
                        gravity: Toast.bottom,
                        backgroundColor: Colors.green,
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                        )
                    );
                    Navigator.pop(context);

                    // total -= ttl_days;

                    getAllMileage();

                    if(_mileageList.length == 1){
                      setState(() {
                        emptyMileage();
                      });
                    }
                  }
                  else{
                    Toast.show(
                        'Oops!!, this Fuel Date is not Deleted ',
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

  emptyMileage() {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Image(
              image: AssetImage(
                'images/emptyPetrol.jpg',
              ),
              fit: BoxFit.fill,
              height: 250.0,
            ),
            const SizedBox(height: 20),
            const Text(
              'Empty Fuel Record for this Month',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Add Your Fuel Record',
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
                addMileage(context);
              },
              child: const Text('Add Mileage',style: TextStyle(
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
