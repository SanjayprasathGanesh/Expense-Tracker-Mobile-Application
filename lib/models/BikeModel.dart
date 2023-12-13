class BikeModel{
  int? id;
  String? u_name;
  String? name;
  String? date;
  int? price;
  String? mode;
  String? trans;

  bikeMap(){
    var mapping = Map<String, dynamic>();
    mapping['id'] = id ?? null;
    mapping['u_name'] = u_name!;
    mapping['name'] = name!;
    mapping['date'] = date!;
    mapping['price'] = price!;
    mapping['mode'] = mode!;
    mapping['trans'] = trans!;
    return mapping;
  }
}