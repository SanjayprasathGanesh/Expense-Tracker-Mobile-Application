import 'package:expense_tracker/database/databaseConnection.dart';
import 'package:expense_tracker/models/expenseModel.dart';
import 'package:sqflite/sqflite.dart';

class Repository{
  late DatabaseConnection _databaseConnection;

  Repository(){
    _databaseConnection = DatabaseConnection();
  }

  static Database? _database;
  Future<Database?> get database async{
    if(_database != null){
      return _database;
    }
    else{
      _database = await _databaseConnection.setDatabase();
      return _database;
    }
  }


  addDailyExpense(data) async{
    var connection = await database;
    return await connection?.insert('daily_expense', data);
  }
  
  readAllDailyExpense(String u_name,int m) async{
    var connection = await database;
    // return await connection?.query('daily_expense', where: 'u_name = ? ', whereArgs: [u_name]);

    DateTime startOfMonth = DateTime(DateTime.now().year, m, 1);
    DateTime endOfMonth = DateTime(DateTime.now().year, m + 1, 0);

    return await connection?.query(
      'daily_expense',
      where: 'u_name = ? AND exp_date >= ? AND exp_date <= ?',
      whereArgs: [u_name, startOfMonth.toIso8601String(), endOfMonth.toIso8601String()],
      orderBy: 'exp_date',
    );

  }
  
  updateDailyExpense(data) async{
    var connection = await database;
    return await connection?.update('daily_expense', data, where: 'id = ? AND u_name = ?',whereArgs: [data['id'], data['u_name']]);
  }

  deleteDailyExpense(int id,String u_name) async{
    var connection = await database;
    // return await connection?.rawDelete("DELETE FROM daily_expense WHERE id = $id AND u_name = $u_name");
    return await connection?.delete('daily_expense', where: 'id = ? AND u_name = ?', whereArgs: [id, u_name]);
  }

  addDailyIncome(data) async{
    var connection = await database;
    return await connection?.insert('income', data);
  }

  readAllDailyIncome(String u_name,int m) async{
    var connection = await database;
    // return await connection?.query('daily_expense', where: 'u_name = ? ', whereArgs: [u_name]);

    DateTime startOfMonth = DateTime(DateTime.now().year, m, 1);
    DateTime endOfMonth = DateTime(DateTime.now().year, m + 1, 0);

    return await connection?.query(
      'income',
      where: 'u_name = ? AND inc_date >= ? AND inc_date <= ?',
      whereArgs: [u_name, startOfMonth.toIso8601String(), endOfMonth.toIso8601String()],
      orderBy: 'inc_date',
    );

  }

  updateDailyIncome(data) async{
    var connection = await database;
    return await connection?.update('income', data, where: 'id = ? AND u_name = ?',whereArgs: [data['id'], data['u_name']]);
  }

  deleteDailyIncome(int id,String u_name) async{
    var connection = await database;
    // return await connection?.rawDelete("DELETE FROM daily_expense WHERE id = $id AND u_name = $u_name");
    return await connection?.delete('income', where: 'id = ? AND u_name = ?', whereArgs: [id, u_name]);
  }

  getExpenseTotal(String u_name, int m) async {
    var connection = await database;
    // return await connection?.query('daily_expense', where: 'u_name = ? ', whereArgs: [u_name]);

    DateTime startOfMonth = DateTime(DateTime.now().year, m, 1);
    DateTime endOfMonth = DateTime(DateTime.now().year, m + 1, 0);

    return await connection?.query(
      'daily_expense',
      where: 'u_name = ? AND exp_date >= ? AND exp_date <= ?',
      whereArgs: [u_name, startOfMonth.toIso8601String(), endOfMonth.toIso8601String()],
      orderBy: 'inc_date',
    );
  }


  getIncomeTotal(String u_name,int m) async{
    var connection = await database;
    // return await connection?.query('daily_expense', where: 'u_name = ? ', whereArgs: [u_name]);

    DateTime startOfMonth = DateTime(DateTime.now().year, m, 1);
    DateTime endOfMonth = DateTime(DateTime.now().year, m + 1, 0);

    return await connection?.query(
      'income',
      where: 'u_name = ? AND inc_date >= ? AND inc_date <= ?',
      whereArgs: [u_name, startOfMonth.toIso8601String(), endOfMonth.toIso8601String()],
      orderBy: 'inc_date',
    );
  }

  getExpenseByDate(String u_name, String date) async {
    var connection = await database;
    return await connection?.rawQuery(
      "SELECT * FROM daily_expense WHERE u_name = ? AND exp_date = ?",
      [u_name, date],
    );
  }

  getExpenseByAmt(String u_name, int amt) async {
    DateTime start = DateTime(DateTime.now().year,1,1);
    DateTime end = DateTime(DateTime.now().year,12,31);
    var connection = await database;
    return await connection?.rawQuery(
      "SELECT * FROM daily_expense WHERE u_name = ? AND exp_amt = ? AND exp_date >= ? AND exp_date <= ?",
      [u_name, amt, start.toIso8601String(), end.toIso8601String()],
    );
  }

  getExpenseByType(String u_name, String type) async {
    DateTime start = DateTime(DateTime.now().year,1,1);
    DateTime end = DateTime(DateTime.now().year,12,31);
    var connection = await database;
    return await connection?.rawQuery(
      "SELECT * FROM daily_expense WHERE u_name = ? AND exp_type = ? AND exp_date >= ? AND exp_date <= ?",
      [u_name, type, start.toIso8601String(), end.toIso8601String()],
    );
  }

  getExpenseByTrans(String u_name, String trans) async {
    DateTime start = DateTime(DateTime.now().year,1,1);
    DateTime end = DateTime(DateTime.now().year,12,31);
    var connection = await database;
    return await connection?.rawQuery(
      "SELECT * FROM daily_expense WHERE u_name = ? AND exp_trans = ? AND exp_date >= ? AND exp_date <= ?",
      [u_name, trans, start.toIso8601String(), end.toIso8601String()],
    );
  }

  getIncomeByDate(String u_name, String date) async {
    var connection = await database;
    return await connection?.rawQuery(
      "SELECT * FROM income WHERE u_name = ? AND inc_date = ?",
      [u_name, date],
    );
  }

  getIncomeByAmt(String u_name, int amt) async {
    DateTime start = DateTime(DateTime.now().year,1,1);
    DateTime end = DateTime(DateTime.now().year,12,31);
    var connection = await database;
    return await connection?.rawQuery(
      "SELECT * FROM income WHERE u_name = ? AND inc_amt = ? AND inc_date >= ? AND inc_date <= ?",
      [u_name, amt, start.toIso8601String(), end.toIso8601String()],
    );
  }

  getIncomeByType(String u_name, String type) async {
    DateTime start = DateTime(DateTime.now().year,1,1);
    DateTime end = DateTime(DateTime.now().year,12,31);
    var connection = await database;
    return await connection?.rawQuery(
      "SELECT * FROM income WHERE u_name = ? AND inc_type = ? AND inc_date >= ? AND inc_date <= ?",
      [u_name, type, start.toIso8601String(), end.toIso8601String()],
    );
  }

  getIncomeByTrans(String u_name, String trans) async {
    DateTime start = DateTime(DateTime.now().year,1,1);
    DateTime end = DateTime(DateTime.now().year,12,31);
    var connection = await database;
    return await connection?.rawQuery(
      "SELECT * FROM income WHERE u_name = ? AND inc_trans = ? AND inc_date >= ? AND inc_date <= ?",
      [u_name, trans, start.toIso8601String(), end.toIso8601String()],
    );
  }

  addDailyDiary(data) async{
    var connection = await database;
    return await connection?.insert('diary', data);
  }

  readAllDiary(String u_name,int m) async{
    var connection = await database;

    DateTime startOfMonth = DateTime(DateTime.now().year, m, 1);
    DateTime endOfMonth = DateTime(DateTime.now().year, m + 1, 0);

    return await connection?.query(
      'diary',
      where: 'u_name = ? AND date >= ? AND date <= ?',
      whereArgs: [u_name, startOfMonth.toIso8601String(), endOfMonth.toIso8601String()],
      orderBy: 'date',
    );
  }

  readSpecificDiary(String u_name,int id) async{
    var connection = await database;
    return await connection?.query(
      'diary',
      where: 'u_name = ? AND id = ?',
      whereArgs: [u_name, id],
      orderBy: 'id',
    );
  }

  readOnDate(String u_name,String date) async{
    var connection = await database;
    return await connection?.query(
      'diary',
      where: 'u_name = ? AND date = ?',
      whereArgs: [u_name, date],
      orderBy: 'date',
    );
  }

  updateDiary(data) async{
    var connection = await database;
    return await connection?.update('diary', data, where: 'id = ? AND u_name = ?',whereArgs: [data['id'], data['u_name']]);
  }

  deleteDiary(int id,String u_name) async{
    var connection = await database;
    return await connection?.delete('diary', where: 'id = ? AND u_name = ?', whereArgs: [id, u_name]);
  }

  addDailyLeave(data) async{
    var connection = await database;
    return await connection?.insert('leave_days', data);
  }

  readAllLeave(String u_name,int m) async{
    var connection = await database;

    DateTime startOfMonth = DateTime(DateTime.now().year, m, 1);
    DateTime endOfMonth = DateTime(DateTime.now().year, m + 1, 0);

    return await connection?.query(
      'leave_days',
      where: 'u_name = ? AND from_date >= ? AND to_date <= ?',
      whereArgs: [u_name, startOfMonth.toIso8601String(), endOfMonth.toIso8601String()],
      orderBy: 'from_date',
    );
  }

  updateLeave(data) async{
    var connection = await database;
    return await connection?.update('leave_days', data, where: 'id = ? AND u_name = ?',whereArgs: [data['id'], data['u_name']]);
  }

  deleteLeave(int id,String u_name) async{
    var connection = await database;
    return await connection?.delete('leave_days', where: 'id = ? AND u_name = ?', whereArgs: [id, u_name]);
  }

  addMileage(data) async{
    var connection = await database;
    return await connection?.insert('mileage', data);
  }

  readAllMileage(String u_name,int m) async{
    var connection = await database;

    DateTime startOfMonth = DateTime(DateTime.now().year, m, 1);
    DateTime endOfMonth = DateTime(DateTime.now().year, m + 1, 0);

    return await connection?.query(
      'mileage',
      where: 'u_name = ? AND date >= ? AND date <= ?',
      whereArgs: [u_name, startOfMonth.toIso8601String(), endOfMonth.toIso8601String()],
      orderBy: 'date',
    );
  }

  getPrevious(String u_name,int m) async{
    var connection = await database;

    DateTime startOfMonth = DateTime(DateTime.now().year, m, 1);
    DateTime endOfMonth = DateTime(DateTime.now().year, m + 1, 0);

    return await connection?.query(
      'mileage',
      where: 'u_name = ? AND date >= ? AND date <= ?',
      whereArgs: [u_name, startOfMonth.toIso8601String(), endOfMonth.toIso8601String()],
      orderBy: 'end_km DESC',
      limit: 1,
    );

  }

  updateMileage(data) async{
    var connection = await database;
    return await connection?.update('mileage', data, where: 'id = ? AND u_name = ?',whereArgs: [data['id'], data['u_name']]);
  }

  deleteMileage(int id,String u_name) async{
    var connection = await database;
    return await connection?.delete('mileage', where: 'id = ? AND u_name = ?', whereArgs: [id, u_name]);
  }

  addHealth(data) async{
    var connection = await database;
    return await connection?.insert('health', data);
  }

  readAllHealth(String u_name,int m) async{
    var connection = await database;

    DateTime startOfMonth = DateTime(DateTime.now().year, m, 1);
    DateTime endOfMonth = DateTime(DateTime.now().year, m + 1, 0);

    return await connection?.query(
      'health',
      where: 'u_name = ? AND start_date >= ? AND end_date <= ?',
      whereArgs: [u_name, startOfMonth.toIso8601String(), endOfMonth.toIso8601String()],
      orderBy: 'start_date',
    );
  }

  updateHealth(data) async{
    var connection = await database;
    return await connection?.update('health', data, where: 'id = ? AND u_name = ?',whereArgs: [data['id'], data['u_name']]);
  }

  deleteHealth(int id,String u_name) async{
    var connection = await database;
    return await connection?.delete('health', where: 'id = ? AND u_name = ?', whereArgs: [id, u_name]);
  }

  addUser(data) async{
    var connection = await database;
    return await connection?.insert('user', data);
  }

  readUser(String u_name) async{
    var connection = await database;
    return await connection?.query(
      'user',
      where: 'u_name = ?',
      whereArgs: [u_name],
      orderBy: 'id',
    );
  }

  checkUser(String u_name, String psw) async{
    var connection = await database;
    return await connection?.query(
      'user',
      where: 'u_name = ? AND psw = ?',
      whereArgs: [u_name, psw],
      orderBy: 'u_name',
    );
  }

  updateUser(data) async{
    var connection = await database;
    return await connection?.update('user', data, where: 'id = ? AND u_name = ?',whereArgs: [data['id'], data['u_name']]);
  }

  updatePsw(String uName, String newPassword) async {
    var connection = await database;
    var data = {'psw': newPassword};

    return await connection?.update(
      'user',
      data,
      where: 'u_name = ?',
      whereArgs: [uName],
    );
  }

  deleteUser(String u_name) async{
    var connection = await database;
    return await connection?.delete('user', where: 'u_name = ?', whereArgs: [u_name]);
  }

  addBike(data) async{
    var connection = await database;
    return await connection?.insert('bike', data);
  }

  readAllBike(String u_name) async{
    var connection = await database;
    return await connection?.query(
      'bike',
      where: 'u_name = ?',
      whereArgs: [u_name],
      orderBy: 'date',
    );
  }

  updateBike(data) async{
    var connection = await database;
    return await connection?.update('bike', data, where: 'id = ? AND u_name = ?',whereArgs: [data['id'], data['u_name']]);
  }

  deleteBike(int id,String u_name) async{
    var connection = await database;
    return await connection?.delete('bike', where: 'id = ? AND u_name = ?', whereArgs: [id, u_name]);
  }
}