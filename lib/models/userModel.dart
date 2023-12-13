class UserModel{
  int? id;
  String? u_name;
  String? name;
  int? age;
  String? dob;
  String? phoneNo;
  String? gender;
  String? email;
  String? maritialStatus;
  String? type;
  String? psw;

  userMap(){
    var mapping = Map<String, dynamic>();
    mapping['id'] = id ?? null;
    mapping['u_name'] = u_name!;
    mapping['name'] = name!;
    mapping['age'] = age!;
    mapping['dob'] = dob!;
    mapping['phoneNo'] = phoneNo!;
    mapping['gender'] = gender!;
    mapping['email'] = email!;
    mapping['marital_status'] = maritialStatus!;
    mapping['type'] = type!;
    mapping['psw'] = psw!;
    return mapping;
  }
}