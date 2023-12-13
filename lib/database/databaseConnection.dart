import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseConnection{
  Future<Database> setDatabase() async{
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'Expense_Tracker');
    var database = await openDatabase(path,version: 7,onCreate: _createTables);
    return database;
  }

  Future<void> _createTables(Database db,int version) async{
    String expense = "CREATE TABLE daily_expense(id INTEGER PRIMARY KEY,u_name TEXT,exp_name TEXT,exp_date TEXT,exp_amt INTEGER,exp_type TEXT,exp_trans TEXT)";
    await db.execute(expense);

    String income = "CREATE TABLE income(id INTEGER PRIMARY KEY,u_name TEXT,inc_name TEXT,inc_date TEXT,inc_amt INTEGER,inc_type TEXT,inc_trans TEXT)";
    await db.execute(income);

    String diary = "CREATE TABLE diary(id INTEGER PRIMARY KEY,u_name TEXT,date TEXT, day TEXT, sub TEXT, content TEXT, rating DOUBLE)";
    await db.execute(diary);

    String leave = "CREATE TABLE leave_days(id INTEGER PRIMARY KEY,u_name TEXT,from_date TEXT,to_date TEXT, from_day TEXT, to_day TEXT, type TEXT, sub TEXT, ttl_days INTEGER)";
    await db.execute(leave);

    String mileage = "CREATE TABLE mileage(id INTEGER PRIMARY KEY,u_name TEXT, start_km INTEGER, end_km INTEGER, litre INTEGER, price INTEGER, date TEXT, day TEXT)";
    await db.execute(mileage);

    String health = "CREATE TABLE health(id INTEGER PRIMARY KEY,u_name TEXT, start_date TEXT, end_date TEXT, total_days INTEGER)";
    await db.execute(health);

    String user = "CREATE TABLE user(id INTEGER PRIMARY KEY, u_name TEXT, name TEXT, phoneNo TEXT, age INTEGER, dob TEXT, gender TEXT, email TEXT, marital_status TEXT, type TEXT, psw TEXT)";
    await db.execute(user);

    String remainder = "CREATE TABLE remainder(id INTEGER PRIMARY KEY, u_name TEXT, date TEXT, description TEXT)";
    await db.execute(remainder);

    String bike = "CREATE TABLE bike(id INTEGER PRIMARY KEY, u_name TEXT, name TEXT, date TEXT, price INTEGER, mode TEXT, trans TEXT)";
    await db.execute(bike);
  }
}