import 'package:expense_tracker/database/repository.dart';
import 'package:expense_tracker/models/expenseModel.dart';

class ExpenseService{

  late Repository _repository;

  ExpenseService(){
    _repository = Repository();
  }

  AddExpense(ExpenseModel expenseModel) async{
    return await _repository.addDailyExpense(expenseModel.expenseMap());
  }

  ReadAllExpense(String u_name, int m) async{
    return await _repository.readAllDailyExpense(u_name, m);
  }

  UpdateExpense(ExpenseModel expenseModel) async{
    return await _repository.updateDailyExpense(expenseModel.expenseMap());
  }

  DeleteExpense(int id,String u_name) async{
    return await _repository.deleteDailyExpense(id, u_name);
  }

  GetExpenseTotal(String u_name, int m) async{
    return await _repository.getExpenseTotal(u_name, m);
  }

  GetExpenseByDate(String u_name, String date) async{
    return await _repository.getExpenseByDate(u_name, date);
  }

  GetExpenseByAmt(String u_name, int amt) async{
    return await _repository.getExpenseByAmt(u_name, amt);
  }

  GetExpenseByType(String u_name, String type) async{
    return await _repository.getExpenseByType(u_name, type);
  }

  GetExpenseByTrans(String u_name, String trans) async{
    return await _repository.getExpenseByTrans(u_name, trans);
  }

}