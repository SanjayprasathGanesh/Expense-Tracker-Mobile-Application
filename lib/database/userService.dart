import 'package:expense_tracker/database/repository.dart';
import 'package:expense_tracker/models/userModel.dart';

class UserService {

  late Repository _repository;

  UserService() {
    _repository = Repository();
  }

  AddUser(UserModel userModel) async {
    return await _repository.addUser(userModel.userMap());
  }

  ReadUser(String u_name) async {
    return await _repository.readUser(u_name);
  }

  CheckUser(String u_name, String psw) async {
    return await _repository.checkUser(u_name, psw);
  }

  UpdateUser(UserModel userModel) async {
    return await _repository.updateUser(userModel.userMap());
  }

  UpdatePsw(String u_name, String psw) async{
    return await _repository.updatePsw(u_name, psw);
  }

  DeleteUser(String u_name) async {
    return await _repository.deleteUser(u_name);
  }
}
