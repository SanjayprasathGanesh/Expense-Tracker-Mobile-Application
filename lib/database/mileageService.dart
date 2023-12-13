import 'package:expense_tracker/database/repository.dart';
import 'package:expense_tracker/models/mileageModel.dart';

class MileageService {

  late Repository _repository;

  MileageService() {
    _repository = Repository();
  }

  AddMileage(MileageModel mileageModel) async {
    return await _repository.addMileage(mileageModel.mileageMap());
  }

  ReadAllMileage(String u_name, int m) async {
    return await _repository.readAllMileage(u_name, m);
  }

  GetPrevious(String u_name, int m) async{
    return await _repository.getPrevious(u_name, m);
  }

  UpdateMileage(MileageModel mileageModel) async {
    return await _repository.updateMileage(mileageModel.mileageMap());
  }

  DeleteMileage(int id, String u_name) async {
    return await _repository.deleteMileage(id, u_name);
  }
}
