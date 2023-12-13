import 'package:expense_tracker/database/userService.dart';
import 'package:expense_tracker/main.dart';
import 'package:expense_tracker/models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class SetUserProfile extends StatefulWidget {
  final String u_name;
  final String psw;
  const SetUserProfile({Key? key, required this.u_name, required this.psw}) : super(key: key);

  @override
  State<SetUserProfile> createState() => _SetUserProfileState();
}

class _SetUserProfileState extends State<SetUserProfile> {
  TextEditingController uname = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phoneNo = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController maritalStatus = TextEditingController();
  TextEditingController type = TextEditingController();

  bool validateName = false, validatePhone = false, validateAge = false, validateDob = false, validateGender = false, validateEmail = false, validateMarital = false, validateType = false;

  UserService userService = UserService();

  String selectedGender = 'Male',selectedMarital = 'Yes', selectedType = 'Bachelor';

  selectDOB() async{
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
      dob.text = _picked.toString().split(" ")[0];
    }
  }

  selectGender() {
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
            value: selectedGender,
            onChanged: (String? newValue) {
              setState(() {
                selectedGender = newValue!;
              });
            },
            isExpanded: true,
            items: <String>[
              'Male',
              'Female',
              'Transgender',
              'Non-Binary',
              'Prefer not to say',
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

  selectMarital() {
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
            value: selectedMarital,
            onChanged: (String? newValue) {
              setState(() {
                selectedMarital = newValue!;
              });
            },
            isExpanded: true,
            items: <String>[
              'Yes',
              'No',
              'Divorced',
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

  selectType() {
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
            value: selectedType,
            onChanged: (String? newValue) {
              setState(() {
                selectedType = newValue!;
              });
            },
            isExpanded: true,
            items: <String>[
              'Bachelor',
              'Student',
              'Family Person',
              'Home Maker',
              'Senior Citizen',
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

  @override
  void initState() {
    super.initState();
    uname.text = widget.u_name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFffb700),
        title: const Text("Set User Profile",style: TextStyle(
            color: Colors.black,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 17.0
        ),),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10.0,),
              const Center(
                child: CircleAvatar(
                  backgroundColor: Colors.orange,
                  radius: 80.0,
                  child: Icon(Icons.person_sharp,size: 60.0,color: Colors.black,),
                ),
              ),
              const SizedBox(height: 20.0,),
              TextField(
                decoration: InputDecoration(
                  label: const Text("User Name",style: TextStyle(
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
                controller: uname,
                readOnly: true,
              ),
              const SizedBox(
                height: 15.0,
              ),
              TextField(
                decoration: InputDecoration(
                  label: const Text("Name",style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontSize: 14.0,
                  ),),
                  errorText: validateName ? 'Empty Name Field' : null,
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
                controller: name,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(
                height: 15.0,
              ),
              TextField(
                decoration: InputDecoration(
                  label: const Text("DOB",style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontSize: 14.0,
                  ),),
                  errorText: validateDob ? 'Empty DOB Field' : null,
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
                controller: dob,
                readOnly: true,
                onTap: (){
                  selectDOB();
                },
              ),
              const SizedBox(
                height: 15.0,
              ),
              TextField(
                decoration: InputDecoration(
                  label: const Text("Age",style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontSize: 14.0,
                  ),),
                  errorText: validateAge ? 'Empty Age Field' : null,
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
                controller: age,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 15.0,
              ),
              TextField(
                decoration: InputDecoration(
                  label: const Text("Phone Number",style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontSize: 14.0,
                  ),),
                  errorText: validatePhone ? 'Empty Phone Field' : null,
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
                controller: phoneNo,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(
                height: 15.0,
              ),
              /*TextField(
                decoration: InputDecoration(
                  label: const Text("Gender",style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontSize: 14.0,
                  ),),
                  errorText: validateGender ? 'Empty Gender Field' : null,
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
                controller: gender,
                onTap: (){
                  selectGender();
                },
              ),*/
              const Text("Select your Gender",style: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontSize: 14.0,
              ),),
              const SizedBox(
                height: 10.0,
              ),
              selectGender(),
              const SizedBox(
                height: 15.0,
              ),
              TextField(
                decoration: InputDecoration(
                  label: const Text("E-mail",style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontSize: 14.0,
                  ),),
                  errorText: validateEmail ? 'Empty Email Field' : null,
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
                controller: email,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 15.0,
              ),
              /*TextField(
                decoration: InputDecoration(
                  label: const Text("Marital Status",style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontSize: 14.0,
                  ),),
                  errorText: validateMarital ? 'Empty Marital Status Field' : null,
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
                controller: maritalStatus,
                onTap: (){
                  selectMarital();
                },
              ),*/
              const Text("Select your Marital Status",style: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontSize: 14.0,
              ),),
              const SizedBox(
                height: 10.0,
              ),
              selectMarital(),
              const SizedBox(
                height: 15.0,
              ),
              /*TextField(
                decoration: InputDecoration(
                  label: const Text("Type",style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontSize: 14.0,
                  ),),
                  errorText: validateType ? 'Empty Type Field' : null,
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
                controller: type,
                onTap: (){
                  selectType();
                },
              ),*/
              const Text("Select Your Type",style: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontSize: 14.0,
              ),),
              const SizedBox(
                height: 10.0,
              ),
              selectType(),
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
                          phoneNo.clear();
                          age.clear();
                          gender.clear();
                          type.clear();
                          dob.clear();
                          email.clear();
                          maritalStatus.clear();
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
                      onPressed: () async{
                        ToastContext().init(context);
                        setState(() {
                          validateName = name.text.isEmpty;
                          validateAge = age.text.isEmpty;
                          validateDob = dob.text.isEmpty;
                          validatePhone = phoneNo.text.isEmpty;
                          validateEmail = email.text.isEmpty;
                        });
                        if(!validateName && !validateAge && !validateDob && !validatePhone && !validateEmail){

                          bool ageValid = valAge(dob.text, int.parse(age.text));
                          bool phoneValid = valPhone(phoneNo.text);

                          if(ageValid){
                            if(phoneValid){
                              var userModel = UserModel();
                              userModel.u_name = widget.u_name;
                              userModel.name = name.text;
                              userModel.age = int.parse(age.text.toString());
                              userModel.phoneNo = phoneNo.text;
                              userModel.email = email.text;
                              userModel.gender = selectedGender;
                              userModel.dob = dob.text;
                              userModel.type = selectedType;
                              userModel.maritialStatus = selectedMarital;
                              userModel.psw = widget.psw;

                              var result = await userService.AddUser(userModel);

                              if(result != null){
                                Toast.show(
                                    'User Profile Setted Successfully',
                                    duration: 3,
                                    backgroundColor: Colors.blue,
                                    textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                      fontSize: 13.0,
                                    )
                                );
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>  ExpenseTracker(u_name: widget.u_name,)));
                              }
                              else{
                                Toast.show(
                                  'Error, User Profile Not Setted,Plz Redo',
                                  backgroundColor: Colors.red,
                                  textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                    fontSize: 13.0,
                                  ),
                                  duration: 3,
                                );
                              }
                            }
                            else{
                              Toast.show(
                                'Invalid Phone Number',
                                backgroundColor: Colors.red,
                                textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Poppins',
                                  fontSize: 13.0,
                                ),
                                duration: 3,
                              );
                            }
                          }
                          else{
                            Toast.show(
                              'Invalid Age',
                              backgroundColor: Colors.red,
                              textStyle: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                fontSize: 13.0,
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
                      child: const Text("Set Profile",style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                      ),)
                  )
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool valName(String name){
    String s = name.replaceAll(RegExp(r'[^A-Za-z]'), '');
    if(s.length == name.length){
      return true;
    }
    return false;
  }

  bool valAge(String date, int g_age){
    DateTime currentDate = DateTime.now();
    DateTime d = DateTime.parse(date);
    int age = currentDate.year - d.year;

    if (currentDate.month < d.month ||
        (currentDate.month == d.month && currentDate.day < d.day)) {
      age--;
    }

    return age == g_age;
  }

  bool valPhone(String phone){
    String s = phone.replaceAll(RegExp(r'[^0-9]'), '');

    if(phone.length == s.length && phone.length == 10){
      return true;
    }
    return false;
  }
}
