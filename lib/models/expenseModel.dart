class ExpenseModel{
  int? id;
  String? u_name;
  String? exp_name;
  String? exp_date;
  int? exp_amt;
  String? exp_type;
  String? exp_trans;

  expenseMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id ?? null;
    mapping['u_name'] = u_name!;
    mapping['exp_name'] = exp_name!;
    mapping['exp_date'] = exp_date!;
    mapping['exp_amt'] = exp_amt!;
    mapping['exp_type'] = exp_type!;
    mapping['exp_trans'] = exp_trans!;
    return mapping;
  }
}