import 'package:expense_tracker/database/repository.dart';
import 'package:expense_tracker/models/leaveModel.dart';

class LeaveService {

  late Repository _repository;

  LeaveService() {
    _repository = Repository();
  }

  AddLeave(LeaveModel leaveModel) async {
    return await _repository.addDailyLeave(leaveModel.leaveMap());
  }

  ReadAllLeave(String u_name, int m) async {
    return await _repository.readAllLeave(u_name, m);
  }

  UpdateLeave(LeaveModel leaveModel) async {
    return await _repository.updateLeave(leaveModel.leaveMap());
  }

  DeleteLeave(int id, String u_name) async {
    return await _repository.deleteLeave(id, u_name);
  }
}
