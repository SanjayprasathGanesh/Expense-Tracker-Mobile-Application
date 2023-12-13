class IncomeModel{
  int? id;
  String? u_name;
  String? inc_name;
  String? inc_date;
  int? inc_amt;
  String? inc_type;
  String? inc_trans;

  incomeMap(){
    var mapping = Map<String, dynamic>();
    mapping['id'] = id ?? null;
    mapping['u_name'] = u_name!;
    mapping['inc_name'] = inc_name!;
    mapping['inc_date'] = inc_date!;
    mapping['inc_amt'] = inc_amt!;
    mapping['inc_type'] = inc_type!;
    mapping['inc_trans'] = inc_trans!;
    return mapping;
  }
}