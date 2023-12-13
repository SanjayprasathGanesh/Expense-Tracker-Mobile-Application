import 'package:expense_tracker/database/personalDiaryService.dart';
import 'package:expense_tracker/models/personalDiaryModel.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class ViewDiary extends StatefulWidget {
  final String u_name;
  const ViewDiary({Key? key, required this.u_name}) : super(key: key);

  @override
  State<ViewDiary> createState() => _ViewDiaryState();
}

class _ViewDiaryState extends State<ViewDiary> {
  
  PersonalDiaryService _diaryService = PersonalDiaryService();

  TextEditingController date = TextEditingController();
  TextEditingController day = TextEditingController();
  TextEditingController sub = TextEditingController();
  TextEditingController content = TextEditingController();

  double rating = 0.0;

  void _clearRating() {
    setState(() {
      rating = 0.0;
    });
  }

  bool validateDate = false,validateSub = false,validateContent = false;

  List<String> days = ['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'];

  var value = 0;

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

  List<PersonalDiaryModel> _diaryList = <PersonalDiaryModel>[];

  List<String> month = ['January','Febraury','March','April','May','June','July','August','September','October','November','December'];
  int m = DateTime.now().month;

  bool isLoaded = false, check = false;

  @override
  initState(){
    super.initState();
    getAllDiary();
    showDiary(context);
  }

  getAllDiary() async{
    var diary = await _diaryService.ReadAllDairy(widget.u_name, m);
    _diaryList = <PersonalDiaryModel>[];
    diary.forEach((d){
      setState(() {
        var personalDiaryModel = PersonalDiaryModel();
        personalDiaryModel.id = d['id'];
        personalDiaryModel.u_name = d['u_name'];
        personalDiaryModel.date = d['date'];
        personalDiaryModel.day = d['day'];
        personalDiaryModel.sub = d['sub'];
        personalDiaryModel.content = d['content'];
        personalDiaryModel.rating = d['rating'];
        _diaryList.add(personalDiaryModel);
        isLoaded = true;
      });
    });
  }

  showDiary(BuildContext context){
    return ListView.builder(
        itemCount: _diaryList.length,
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
                      Text(_diaryList[index].date!,style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                      ),),
                      Text(_diaryList[index].day!,style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                      ),)
                    ],
                  ),
                  const SizedBox(height: 10.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          _diaryList[index].rating! >= 1 ? const Icon(Icons.star,color: Colors.orange,) : const Icon(Icons.star_border,color: Colors.black,),
                          _diaryList[index].rating! >= 2 ? const Icon(Icons.star,color: Colors.orange,) : const Icon(Icons.star_border,color: Colors.black,),
                          _diaryList[index].rating! >= 3 ? const Icon(Icons.star,color: Colors.orange,) : const Icon(Icons.star_border,color: Colors.black,),
                          _diaryList[index].rating! >= 4 ? const Icon(Icons.star,color: Colors.orange,) : const Icon(Icons.star_border,color: Colors.black,),
                          _diaryList[index].rating! == 5 ? const Icon(Icons.star,color: Colors.orange,) : const Icon(Icons.star_border,color: Colors.black,),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: (){
                                updateDiary(context, _diaryList[index].id!, _diaryList[index].u_name!, _diaryList[index].date!, _diaryList[index].day!, _diaryList[index].sub!, _diaryList[index].content!, _diaryList[index].rating!);
                              },
                              icon: const Icon(Icons.edit_note_sharp,color: Colors.green,size: 30.0,)
                          ),
                          IconButton(
                              onPressed: (){
                                deleteDiary(context, _diaryList[index].id!,_diaryList[index].u_name!);
                              },
                              icon: const Icon(Icons.delete_outline,color: Colors.red,size: 30.0,)
                          ),
                          IconButton(
                              onPressed: (){
                                viewSpecificDiary(context, _diaryList[index].id!, _diaryList[index].u_name!);
                              },
                              icon: const Icon(Icons.arrow_forward_ios_outlined,color: Colors.blue,size: 30.0,)
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 10.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_diaryList[index].sub!,style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
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

    if(isLoaded && _diaryList.length == 0){
      check = true;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFffb700),
        title: const Text("Personal Diary",style: TextStyle(
          color: Colors.black,
          fontFamily: 'Poppins',
          fontSize: 17.0,
          fontWeight: FontWeight.bold,
        ),),
      ),
      body: Visibility(
          visible: isLoaded,
          replacement: Center(
            child: check ? const CircularProgressIndicator(color: Colors.deepOrange,) : emptyDiary(),
          ),
          child:  SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 750,
                  padding: const EdgeInsets.all(15.0),
                  child: _diaryList.isEmpty ? emptyDiary() : showDiary(context),
                )
              ],
            ),
          ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFffb700),
        onPressed: (){
          openAddPersonal(context);
        },
        child: const Icon(Icons.add,color: Colors.black,),
      ),
    );
  }

  openAddPersonal(BuildContext context){
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: const Color(0xFFffc8dd),
        builder: (param){
          return SingleChildScrollView(
            child: Container(
              height: 800,
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Record Your Daily Happenings',
                        style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                      ),),
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.clear_outlined,color: Colors.black,size: 30.0,),
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
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            label: const Text("Select a Date",style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
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
                          keyboardType: TextInputType.datetime,
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
                              label: const Text("Day",style: TextStyle(
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
                            controller: day,
                            keyboardType: TextInputType.datetime,
                            enabled: false,
                          )
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      label: const Text("Enter the Subject",style: TextStyle(
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
                      errorText: validateSub ? 'Empty Subject Field' : null,
                    ),
                    controller: sub,
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    height: 200,
                    child: TextField(
                      maxLines: 10,
                      decoration: InputDecoration(
                        label: const Text("Enter the Content",style: TextStyle(
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
                        errorText: validateContent ? 'Empty Content Field' : null,
                      ),
                      controller: content,
                      keyboardType: TextInputType.text,
                      onChanged: (text) {
                        List<String> words = text.split(' ');
                        if (words.length > 100) {
                          content.text = words.sublist(0, 100).join(' ');
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Word limit exceeded!'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      }
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Text("Rate Your Day",style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                  ),),
                  const SizedBox(
                    height: 10.0,
                  ),
                  StarRating(
                    onChanged: (newRating) {
                      setState(() {
                        rating = newRating;
                      });
                    },
                    initialRating: rating,
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
                              date.clear();
                              day.clear();
                              sub.clear();
                              content.clear();
                              rating = 0;
                              _clearRating();
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
                              validateDate = date.text.isEmpty;
                              validateSub = sub.text.isEmpty;
                              validateContent = sub.text.isEmpty;
                            });
                            if(!validateDate && !validateSub && !validateContent && rating >= 1.0){

                              var check = await _diaryService.ReadOnDate(widget.u_name, date.text);
                              if(check.toString().length == 2){
                                var personalDiaryModel = PersonalDiaryModel();
                                personalDiaryModel.u_name = widget.u_name;
                                personalDiaryModel.date = date.text.toString();
                                personalDiaryModel.day = day.text.toString();
                                personalDiaryModel.sub = sub.text.toString();
                                personalDiaryModel.content = content.text.toString();
                                personalDiaryModel.rating = rating;
                                var result = await _diaryService.AddDairy(personalDiaryModel);
                                if(result != null){
                                  Toast.show(
                                    'Todays Diary has been Added Successfully',
                                    backgroundColor: Colors.green,
                                    textStyle: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Poppins',
                                    ),
                                    duration: 3,
                                    gravity: Toast.bottom,
                                  );
                                  setState(() {
                                    date.clear();
                                    day.clear();
                                    sub.clear();
                                    content.clear();
                                    rating = 0;
                                    _clearRating();
                                  });
                                  Navigator.pop(context, result);
                                  getAllDiary();
                                }
                                else{
                                  Toast.show(
                                    'OOPs, plz redo again',
                                    backgroundColor: Colors.red,
                                    textStyle: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Poppins',
                                    ),
                                    duration: 3,
                                    gravity: Toast.bottom,
                                  );
                                }
                              }
                              else{
                                Toast.show(
                                  'You have Already Added Diary on this date, if you need to add again, plz update on that date',
                                  backgroundColor: Colors.red,
                                  textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                  ),
                                  duration: 5,
                                  gravity: Toast.bottom,
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
                                ),
                                duration: 3,
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

  viewSpecificDiary(BuildContext context, int id,String u_name) async {
    var diary = await _diaryService.ReadSpecificDairy(u_name, id);
    List<PersonalDiaryModel> _specificList = <PersonalDiaryModel>[];
    _specificList = <PersonalDiaryModel>[];
    diary.forEach((d) {
      setState(() {
        var personalDiaryModel = PersonalDiaryModel();
        personalDiaryModel.id = d['id'];
        personalDiaryModel.u_name = d['u_name'];
        personalDiaryModel.date = d['date'];
        personalDiaryModel.day = d['day'];
        personalDiaryModel.sub = d['sub'];
        personalDiaryModel.content = d['content'];
        personalDiaryModel.rating = d['rating'];
        _specificList.add(personalDiaryModel);
      });
    });

    return showDialog(
        context: context,
        builder: (param){
          return AlertDialog(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Date : ',style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontSize: 16.0,
                    ),),
                    Text(_specificList[0].date!,style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontSize: 16.0,
                    ),)
                  ],
                ),
                Row(
                  children: [
                    Text('Day : ',style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontSize: 16.0,
                    ),),
                    Text(_specificList[0].day!,style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontSize: 16.0,
                    ),)
                  ],
                ),
                Text('Subject : ',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  fontSize: 16.0,
                ),),
                Text(_specificList[0].sub!,style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  fontSize: 16.0,
                ),),
                Text('Content : ',style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  fontSize: 16.0,
                ),),
                Container(
                  height: 400,
                  child: SingleChildScrollView(
                    child: Text(_specificList[0].content!,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontSize: 15.0,
                    ),),
                  ),
                )
              ],
            ),
          );
        }
    );
  }

  updateDiary(BuildContext context,int id,String name,String date, String day, String sub,String content, double rating){

    TextEditingController u_date = TextEditingController();
    TextEditingController u_day = TextEditingController();
    TextEditingController u_sub = TextEditingController();
    TextEditingController u_content = TextEditingController();

    double u_rating = 0.0;
    bool validateUDate = false,validateUSub = false,validateUContent = false;

    setState(() {
      u_date.text = date;
      u_day.text = day;
      u_sub.text = sub;
      u_content.text = content;
      u_rating = rating;
    });

    selectDate2() async {
      DateTime? selected = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(DateTime
              .now()
              .year),
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

      if (selected != null) {
        setState(() {
          u_date.text = selected.toString().split(" ")[0];
          u_day.text = days[selected.weekday];
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
              height: 800,
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Update Your Daily Happenings',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                        ),),
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.clear_outlined,color: Colors.black,size: 30.0,),
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
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            label: const Text("Select a Date",style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                            ),),
                            errorText: validateUDate ? 'Empty Date Field' : null,
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
                          controller: u_date,
                          keyboardType: TextInputType.datetime,
                          onTap: (){
                            selectDate2();
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              label: const Text("Day",style: TextStyle(
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
                            controller: u_day,
                            keyboardType: TextInputType.datetime,
                            enabled: false,
                          )
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      label: const Text("Enter the Subject",style: TextStyle(
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
                      errorText: validateUSub ? 'Empty Subject Field' : null,
                    ),
                    controller: u_sub,
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    height: 200,
                    child: TextField(
                        maxLines: 10,
                        decoration: InputDecoration(
                          label: const Text("Enter the Content",style: TextStyle(
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
                          errorText: validateUContent ? 'Empty Content Field' : null,
                        ),
                        controller: u_content,
                        keyboardType: TextInputType.text,
                        onChanged: (text) {
                          List<String> words = text.split(' ');
                          if (words.length > 100) {
                            u_content.text = words.sublist(0, 100).join(' ');
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Word limit exceeded!'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                        }
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Text("Rate Your Day",style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                  ),),
                  const SizedBox(
                    height: 10.0,
                  ),
                  StarRating2(
                    onChanged: (newRating) {
                      setState(() {
                        u_rating = newRating;
                      });
                    },
                    initialRating: u_rating, // Set the initial value here
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
                              u_date.clear();
                              u_day.clear();
                              u_sub.clear();
                              u_content.clear();
                              u_rating = 0;
                              _clearRating();
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
                              validateUDate = u_date.text.isEmpty;
                              validateUSub = u_sub.text.isEmpty;
                              validateUContent = u_sub.text.isEmpty;
                            });
                            if(!validateUDate && !validateUSub && !validateUContent && u_rating >= 1.0){
                              var personalDiaryModel = PersonalDiaryModel();
                              personalDiaryModel.id = id;
                              personalDiaryModel.u_name = name;
                              personalDiaryModel.date = u_date.text.toString();
                              personalDiaryModel.day = u_day.text.toString();
                              personalDiaryModel.sub = u_sub.text.toString();
                              personalDiaryModel.content = u_content.text.toString();
                              personalDiaryModel.rating = u_rating;
                              var result = await _diaryService.UpdateDiary(personalDiaryModel);
                              if(result != null){
                                Toast.show(
                                  'Todays Diary has been updated Successfully',
                                  backgroundColor: Colors.green,
                                  textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                  ),
                                  duration: 3,
                                  gravity: Toast.bottom,
                                );

                                setState(() {
                                  getAllDiary();
                                });

                                Navigator.pop(context, result);
                              }
                              else{
                                Toast.show(
                                  'OOPs, plz redo again',
                                  backgroundColor: Colors.red,
                                  textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                  ),
                                  duration: 3,
                                  gravity: Toast.bottom,
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
                                ),
                                duration: 3,
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

  deleteDiary(BuildContext context,int id,String u_name){
    return showDialog(
        context: context,
        builder: (param){
          return AlertDialog(
            title: const Text("Do You Want to Delete this Day",style: TextStyle(
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
                  var result = await _diaryService.DeleteDiary(id, u_name);

                  if(result != null){
                    Toast.show(
                        'Diary on this Date has been Deleted Successfully',
                        duration: 3,
                        gravity: Toast.bottom,
                        backgroundColor: Colors.green,
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                        )
                    );
                    Navigator.pop(context);

                    getAllDiary();

                    if(_diaryList.length == 1){
                      setState(() {
                        emptyDiary();
                      });
                    }
                  }
                  else{
                    Toast.show(
                        'Oops!!, this Date Diary not Deleted ',
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

  emptyDiary() {
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
              'Empty Diary for this Month',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Add Your Daily Diary',
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
                openAddPersonal(context);
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

class StarRating extends StatefulWidget {
  final Function(double) onChanged;
  final double initialRating;

  StarRating({
    required this.onChanged,
    this.initialRating = 0.0,
  });

  @override
  _StarRatingState createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  late double _rating;

  @override
  void initState() {
    super.initState();
    _rating = widget.initialRating;
  }

  void clearRating() {
    setState(() {
      _rating = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _rating = index + 1.0;
              widget.onChanged(_rating);
            });
          },
          child: Icon(
            index < _rating ? Icons.star : Icons.star_border,
            color: index < _rating ? Colors.orange : Colors.black,
            size: 40.0,
          ),
        );
      }),
    );
  }
}


class StarRating2 extends StatefulWidget {
  final Function(double) onChanged;
  final double initialRating;

  StarRating2({
    required this.onChanged,
    this.initialRating = 0.0,
  });

  @override
  _StarRating2State createState() => _StarRating2State();
}


class _StarRating2State extends State<StarRating2> {
  late double _rating;

  @override
  void initState() {
    super.initState();
    _rating = widget.initialRating;
  }

  void clearRating() {
    setState(() {
      _rating = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _rating = index + 1.0;
              widget.onChanged(_rating);
            });
          },
          child: Icon(
            index < _rating ? Icons.star : Icons.star_border,
            color: index < _rating ? Colors.orange : Colors.black,
            size: 40.0,
          ),
        );
      }),
    );
  }
}
