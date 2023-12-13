import 'package:expense_tracker/database/repository.dart';
import 'package:expense_tracker/models/personalDiaryModel.dart';

class PersonalDiaryService {

  late Repository _repository;

  PersonalDiaryService() {
    _repository = Repository();
  }

  AddDairy(PersonalDiaryModel personalDiaryModel) async {
    return await _repository.addDailyDiary(
        personalDiaryModel.personalDairyMap());
  }

  ReadAllDairy(String u_name, int m) async {
    return await _repository.readAllDiary(u_name, m);
  }

  ReadSpecificDairy(String u_name, int id) async {
    return await _repository.readSpecificDiary(u_name, id);
  }

  ReadOnDate(String u_name, String date) async{
    return await _repository.readOnDate(u_name, date);
  }

  UpdateDiary(PersonalDiaryModel personalDiaryModel) async {
    return await _repository.updateDiary(personalDiaryModel.personalDairyMap());
  }

  DeleteDiary(int id, String u_name) async {
    return await _repository.deleteDiary(id, u_name);
  }

}
