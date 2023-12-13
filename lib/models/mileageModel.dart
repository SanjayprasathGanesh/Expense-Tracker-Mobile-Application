class MileageModel{
  int? id;
  String? u_name;
  int? start_km;
  int? end_km;
  int? litre;
  int? price;
  String? date;
  String? day;

  mileageMap(){
    var mapping = Map<String, dynamic>();
    mapping['id'] = id ?? null;
    mapping['u_name'] = u_name!;
    mapping['start_km'] = start_km!;
    mapping['end_km'] = end_km!;
    mapping['litre'] = litre!;
    mapping['price'] = price!;
    mapping['date'] = date!;
    mapping['day'] = day!;
    return mapping;
  }
}