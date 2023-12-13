class HealthModel{
  int? id;
  String? u_name;
  String? start_date;
  String? end_date;
  int? total_days;

  healthMap(){
    var mapping = Map<String, dynamic>();
    mapping['id'] = id ?? null;
    mapping['u_name'] = u_name!;
    mapping['start_date'] = start_date!;
    mapping['end_date'] = end_date!;
    mapping['total_days'] = total_days!;
    return mapping;
  }
}