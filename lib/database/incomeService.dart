import 'package:expense_tracker/database/repository.dart';
import 'package:expense_tracker/models/incomeModel.dart';

class IncomeService{
  late Repository _repository;

  IncomeService(){
    _repository = Repository();
  }

  AddIncome(IncomeModel incomeModel) async{
    return await _repository.addDailyIncome(incomeModel.incomeMap());
  }

  ReadAllIncome(String u_name, int m) async{
    return await _repository.readAllDailyIncome(u_name, m);
  }

  UpdateIncome(IncomeModel incomeModel) async{
    return await _repository.updateDailyIncome(incomeModel.incomeMap());
  }

  DeleteIncome(int id,String u_name) async{
    return await _repository.deleteDailyIncome(id, u_name);
  }

  GetIncomeByDate(String u_name, String date) async{
    return await _repository.getIncomeByDate(u_name, date);
  }

  GetIncomeByAmt(String u_name, int amt) async{
    return await _repository.getIncomeByAmt(u_name, amt);
  }

  GetIncomeByType(String u_name, String type) async{
    return await _repository.getIncomeByType(u_name, type);
  }

  GetIncomeByTrans(String u_name, String trans) async{
    return await _repository.getIncomeByTrans(u_name, trans);
  }

}