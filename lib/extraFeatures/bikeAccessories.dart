import 'package:expense_tracker/database/bikeService.dart';
import 'package:expense_tracker/models/BikeModel.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class MyBike extends StatefulWidget {
  final String u_name;
  const MyBike({Key? key, required this.u_name}) : super(key: key);

  @override
  State<MyBike> createState() => _MyBikeState();
}

class _MyBikeState extends State<MyBike> {

  BikeService bikeService = BikeService();

  List<BikeModel> _bikeList = <BikeModel>[];
  var total = 0;

  @override
  initState(){
    super.initState();
    getBike();
    showAllAccessories(context);
  }

  getBike() async{
    total = 0;
    var bikes = await bikeService.ReadBike(widget.u_name);
    _bikeList = <BikeModel>[];
    bikes.forEach((b){
      setState(() {
        var bikeModel = BikeModel();
        bikeModel.id = b['id'];
        bikeModel.u_name = b['u_name'];
        bikeModel.name = b['name'];
        bikeModel.date = b['date'];
        bikeModel.price = b['price'];
        total += bikeModel.price!;
        bikeModel.mode = b['mode'];
        bikeModel.trans = b['trans'];
        _bikeList.add(bikeModel);
      });
    });
  }

  showAllAccessories(BuildContext context) {
    return ListView.builder(
        itemCount: _bikeList.length,
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
                        Text(_bikeList[index].name!,style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                        ),),
                        Text('₹${_bikeList[index].price}',style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                        ),),
                      ],
                    ),
                    const SizedBox(height: 10.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_bikeList[index].date!,style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                        ),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: (){
                                  updateAccessories(context, _bikeList[index].id!, _bikeList[index].name!, _bikeList[index].date!, int.parse(_bikeList[index].price!.toString()), _bikeList[index].mode!, _bikeList[index].trans!);
                                },
                                icon: const Icon(Icons.edit_note_sharp,color: Colors.green,size: 30.0,)
                            ),
                            IconButton(
                                onPressed: (){
                                  deleteAccessories(context, _bikeList[index].id!, _bikeList[index].price!);
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
                        Text(_bikeList[index].mode!,style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                        ),),
                        Text(_bikeList[index].trans!,style: const TextStyle(
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Bike",style: TextStyle(
          color: Colors.black,
          fontSize: 17.0,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
        ),),
        backgroundColor: const Color(0xFFffb700),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 70,
              margin: const EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0),
              child: const Text("With this New Feature, you can able to add your bike accessories",style: TextStyle(
                color: Colors.black,
                fontSize: 15.0,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),),
            ),
            Container(
              height: 500,
              width: double.infinity,
              margin: const EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0),
              child: showAllAccessories(context),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          addAccessories(context);
        },
        tooltip: 'Add Your Bike Accessories Cost',
        backgroundColor: const Color(0xFFffb700),
        child: const Icon(Icons.add,color: Colors.black,),
      ),
      persistentFooterButtons: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Total Products",style: TextStyle(
                  color: Colors.red,
                  fontSize: 15.0,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),),
                Text(" ${_bikeList.length}",style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 15.0,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Total Price",style: TextStyle(
                  color: Colors.blue,
                  fontSize: 15.0,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),),
                Text("₹ $total",style: const TextStyle(
                  color: Colors.green,
                  fontSize: 15.0,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),),
              ],
            ),
          ],
        )
      ],
    );
  }

  addAccessories(BuildContext context){

    TextEditingController name = TextEditingController();
    TextEditingController date = TextEditingController();
    TextEditingController price = TextEditingController();
    TextEditingController mode = TextEditingController();
    TextEditingController trans = TextEditingController();

    String selectedMode = 'Offline', selectedTrans = 'Cash';

    setState(() {
      mode.text = selectedMode;
      trans.text = selectedTrans;
    });

    bool validateName = false, validateDate = false, validatePrice = false;

    selectDate() async{
      DateTime? _picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1930),
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
        date.text = _picked.toString().split(" ")[0];
      }
    }

    selectMode() {
      return Container(
        height: 90,
        width: double.infinity,
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            border: Border.all(
              color: Colors.deepOrangeAccent,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(5.0)
        ),
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: selectedMode,
              onChanged: (String? newValue) {
                setState(() {
                  selectedMode = newValue!;
                  mode.text = selectedMode;
                });
              },
              isExpanded: true,
              items: <String>[
                'Offline',
                'Online - Amazon',
                'Online - Flipkart',
                'Other',
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
              color: Colors.deepOrangeAccent,
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
                  trans.text = selectedTrans;
                });
              },
              isExpanded: true,
              items: <String>[
                'Cash',
                'UPI',
                'Card',
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

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (param){
          return SingleChildScrollView(
            child: Container(
              height: 700,
              width: double.infinity,
              margin: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Add Your Bike Accessories',style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),),
                      IconButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.clear_sharp,color: Colors.black,size: 30.0,),
                      )
                    ],
                  ),
                  const SizedBox(height: 20.0,),
                  TextField(
                    decoration: InputDecoration(
                      label: const Text("Enter the Name",style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontSize: 14.0,
                      ),),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.deepOrange,
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.orange,
                          )
                      ),
                      errorText: validateName ? 'Empty Name Field' : null,
                    ),
                    controller: name,
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      label: const Text("Select the Date",style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontSize: 14.0,
                      ),),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.deepOrange,
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.orange,
                          )
                      ),
                      errorText: validateDate ? 'Empty Date Field' : null,
                    ),
                    controller: date,
                    onTap: (){
                      selectDate();
                    },
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      label: const Text("Enter the Price",style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontSize: 14.0,
                      ),),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.deepOrange,
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.orange,
                          )
                      ),
                      errorText: validatePrice ? 'Empty Price Field' : null,
                    ),
                    controller: price,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            label: const Text("Select the Mode",style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: 14.0,
                            ),),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  color: Colors.deepOrange,
                                )
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  color: Colors.orange,
                                )
                            ),
                          ),
                          controller: mode,
                          keyboardType: TextInputType.text,
                          readOnly: true,
                        ),
                      ),
                      const SizedBox(
                        width: 15.0,
                      ),
                      Expanded(child: selectMode()),
                    ],
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            label: const Text("Select the Trans",style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: 14.0,
                            ),),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  color: Colors.deepOrange,
                                )
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  color: Colors.orange,
                                )
                            ),
                          ),
                          controller: trans,
                          keyboardType: TextInputType.text,
                          readOnly: true,
                        ),
                      ),
                      const SizedBox(
                        width: 15.0,
                      ),
                      Expanded(child: selectTrans()),
                    ],
                  ),
                  const SizedBox(
                    height: 15.0,
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
                              name.clear();
                              date.clear();
                              price.clear();
                              selectedMode = 'Offline';
                            });
                          },
                          child: const Text("Clear",style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontSize: 14.0,
                          ),),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        onPressed: () async{
                          ToastContext().init(context);
                          setState(() {
                            validateName = name.text.isEmpty;
                            validateDate = date.text.isEmpty;
                            validatePrice = price.text.isEmpty;
                          });

                          if(!validateName && !validateDate && !validatePrice){
                            var bikeModel = BikeModel();
                            bikeModel.u_name = widget.u_name;
                            bikeModel.name = name.text;
                            bikeModel.date = date.text;
                            bikeModel.price = int.parse(price.text.toString());
                            bikeModel.mode = mode.text;
                            bikeModel.trans = trans.text;

                            var result = await bikeService.AddBike(bikeModel);
                            if(result != null){
                              Toast.show(
                                'New Accessory added Successfully',
                                backgroundColor: Colors.green,
                                textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                    fontSize: 13.0
                                ),
                                duration: 3,
                              );
                              Navigator.pop(context);

                              getBike();
                            }
                            else{
                              Toast.show(
                                'New Accessory Not added',
                                backgroundColor: Colors.red,
                                textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                    fontSize: 13.0
                                ),
                                duration: 3,
                              );
                            }
                          }
                          else{
                            Toast.show(
                              'Empty Fields',
                              backgroundColor: Colors.red,
                              textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Poppins',
                                  fontSize: 13.0
                              ),
                              duration: 3,
                            );
                          }
                        },
                        child: const Text("Save",style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontSize: 14.0,
                        ),),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        }
    );
  }

  updateAccessories(BuildContext context, int id, String b_name, String b_date, int b_price, String b_mode, String b_trans){

    TextEditingController name = TextEditingController();
    TextEditingController date = TextEditingController();
    TextEditingController price = TextEditingController();
    TextEditingController mode = TextEditingController();
    TextEditingController trans = TextEditingController();

    String selectedMode = 'Offline', selectedTrans = 'Cash';

    setState(() {
      name.text = b_name;
      date.text = b_date;
      price.text = b_price.toString();
      selectedMode = b_mode;
      selectedTrans = b_trans;
      mode.text = selectedMode;
      trans.text = selectedTrans;
    });

    bool validateName = false, validateDate = false, validatePrice = false;

    selectDate() async{
      DateTime? _picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1930),
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
        date.text = _picked.toString().split(" ")[0];
      }
    }

    selectMode() {
      return Container(
        height: 90,
        width: double.infinity,
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            border: Border.all(
              color: Colors.deepOrangeAccent,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(5.0)
        ),
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: selectedMode,
              onChanged: (String? newValue) {
                setState(() {
                  selectedMode = newValue!;
                  mode.text = selectedMode;
                });
              },
              isExpanded: true,
              items: <String>[
                'Offline',
                'Online - Amazon',
                'Online - Flipkart',
                'Other',
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
              color: Colors.deepOrangeAccent,
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
                  trans.text = selectedTrans;
                });
              },
              isExpanded: true,
              items: <String>[
                'Cash',
                'UPI',
                'Card',
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

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (param){
          return SingleChildScrollView(
            child: Container(
              height: 700,
              width: double.infinity,
              margin: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Update Your Bike Accessories',style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),),
                      IconButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.clear_sharp,color: Colors.black,size: 30.0,),
                      )
                    ],
                  ),
                  const SizedBox(height: 20.0,),
                  TextField(
                    decoration: InputDecoration(
                      label: const Text("Enter the Name",style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontSize: 14.0,
                      ),),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.deepOrange,
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.orange,
                          )
                      ),
                      errorText: validateName ? 'Empty Name Field' : null,
                    ),
                    controller: name,
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      label: const Text("Select the Date",style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontSize: 14.0,
                      ),),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.deepOrange,
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.orange,
                          )
                      ),
                      errorText: validateDate ? 'Empty Date Field' : null,
                    ),
                    controller: date,
                    onTap: (){
                      selectDate();
                    },
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      label: const Text("Enter the Price",style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontSize: 14.0,
                      ),),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.deepOrange,
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.orange,
                          )
                      ),
                      errorText: validatePrice ? 'Empty Price Field' : null,
                    ),
                    controller: price,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            label: const Text("Select the Mode",style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: 14.0,
                            ),),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  color: Colors.deepOrange,
                                )
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  color: Colors.orange,
                                )
                            ),
                          ),
                          controller: mode,
                          keyboardType: TextInputType.text,
                          readOnly: true,
                        ),
                      ),
                      const SizedBox(
                        width: 15.0,
                      ),
                      Expanded(child: selectMode()),
                    ],
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            label: const Text("Select the Trans",style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: 14.0,
                            ),),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  color: Colors.deepOrange,
                                )
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  color: Colors.orange,
                                )
                            ),
                          ),
                          controller: trans,
                          keyboardType: TextInputType.text,
                          readOnly: true,
                        ),
                      ),
                      const SizedBox(
                        width: 15.0,
                      ),
                      Expanded(child: selectTrans()),
                    ],
                  ),
                  const SizedBox(
                    height: 15.0,
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
                            name.clear();
                            date.clear();
                            price.clear();
                            selectedMode = 'Offline';
                          });
                        },
                        child: const Text("Clear",style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontSize: 14.0,
                        ),),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        onPressed: () async{
                          ToastContext().init(context);
                          setState(() {
                            validateName = name.text.isEmpty;
                            validateDate = date.text.isEmpty;
                            validatePrice = price.text.isEmpty;
                          });

                          if(!validateName && !validateDate && !validatePrice){
                            var bikeModel = BikeModel();
                            bikeModel.id = id;
                            bikeModel.u_name = widget.u_name;
                            bikeModel.name = name.text;
                            bikeModel.date = date.text;
                            bikeModel.price = int.parse(price.text.toString());
                            bikeModel.mode = mode.text;
                            bikeModel.trans = trans.text;

                            var result = await bikeService.UpdateBike(bikeModel);
                            if(result != null){
                              Toast.show(
                                'New Accessory updated Successfully',
                                backgroundColor: Colors.green,
                                textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                    fontSize: 13.0
                                ),
                                duration: 3,
                              );
                              Navigator.pop(context);

                              getBike();
                            }
                            else{
                              Toast.show(
                                'New Accessory Not updated',
                                backgroundColor: Colors.red,
                                textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                    fontSize: 13.0
                                ),
                                duration: 3,
                              );
                            }
                          }
                          else{
                            Toast.show(
                              'Empty Fields',
                              backgroundColor: Colors.red,
                              textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Poppins',
                                  fontSize: 13.0
                              ),
                              duration: 3,
                            );
                          }
                        },
                        child: const Text("Update",style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontSize: 14.0,
                        ),),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        }
    );
  }

  deleteAccessories(BuildContext context,int id,int amt){
    return showDialog(
        context: context,
        builder: (param){
          return AlertDialog(
            title: const Text("Do You Want to Delete this Accessery",style: TextStyle(
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
                  var result = await bikeService.DeleteBike(id, widget.u_name);

                  if(result != null){
                    Toast.show(
                        'Bike Accessory Deleted Successfully',
                        duration: 3,
                        gravity: Toast.bottom,
                        backgroundColor: Colors.green,
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                        )
                    );

                    total -= amt;

                    getBike();

                    Navigator.pop(context);

                  }
                  else{
                    Toast.show(
                        'Oops!!, Accessory not Deleted ',
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
}
