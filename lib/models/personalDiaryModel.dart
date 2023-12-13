
class PersonalDiaryModel{
  int? id;
  String? u_name;
  String? date;
  String? day;
  String? sub;
  String? content;
  double? rating;

  personalDairyMap(){
    var mapping = Map<String, dynamic>();
    mapping['id'] = id ?? null;
    mapping['u_name'] = u_name!;
    mapping['date'] = date!;
    mapping['day'] = day!;
    mapping['sub'] = sub!;
    mapping['content'] = content!;
    mapping['rating'] = rating!;
    return mapping;
  }
}