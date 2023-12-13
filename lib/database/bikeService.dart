import 'package:expense_tracker/database/repository.dart';
import 'package:expense_tracker/models/BikeModel.dart';

class BikeService {

  late Repository _repository;

  BikeService() {
    _repository = Repository();
  }

  AddBike(BikeModel bikeModel) async {
    return await _repository.addBike(bikeModel.bikeMap());
  }

  ReadBike(String u_name) async {
    return await _repository.readAllBike(u_name);
  }

  UpdateBike(BikeModel bikeModel) async {
    return await _repository.updateBike(bikeModel.bikeMap());
  }

  DeleteBike(int id, String u_name) async {
    return await _repository.deleteBike(id, u_name);
  }
}
