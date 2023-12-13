import 'package:expense_tracker/database/repository.dart';
import 'package:expense_tracker/models/healthModel.dart';
import 'package:expense_tracker/models/mileageModel.dart';

class HealthService {

  late Repository _repository;

  HealthService() {
    _repository = Repository();
  }

  AddHealth(HealthModel healthModel) async {
    return await _repository.addHealth(healthModel.healthMap());
  }

  ReadAllHealth(String u_name, int m) async {
    return await _repository.readAllHealth(u_name, m);
  }

  UpdateHealth(HealthModel healthModel) async {
    return await _repository.updateHealth(healthModel.healthMap());
  }

  DeleteHealth(int id, String u_name) async {
    return await _repository.deleteHealth(id, u_name);
  }
}
