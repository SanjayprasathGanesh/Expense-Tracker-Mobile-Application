class LeaveModel{
  int? id;
  String? u_name;
  String? from_date;
  String? to_date;
  String? from_day;
  String? to_day;
  String? type;
  String? sub;
  int? ttl_days;

  leaveMap(){
    var mapping = Map<String, dynamic>();
    mapping['id'] = id ?? null;
    mapping['u_name'] = u_name!;
    mapping['from_date'] = from_date!;
    mapping['to_date'] = to_date!;
    mapping['from_day'] = from_day!;
    mapping['to_day'] = to_day!;
    mapping['type'] = type!;
    mapping['sub'] = sub!;
    mapping['ttl_days'] = ttl_days!;
    return mapping;
  }
}