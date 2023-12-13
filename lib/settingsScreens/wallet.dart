import 'package:flutter/material.dart';
import '../database/expenseService.dart';
import '../database/incomeService.dart';
import '../models/expenseModel.dart';
import '../models/incomeModel.dart';
import '../sideScreens/analysisTable.dart';

class Wallet extends StatefulWidget {
  final String u_name;
  const Wallet({Key? key, required this.u_name}) : super(key: key);

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {

  List<String> month = ['January','Febraury','March','April','May','June','July','August','September','October','November','December'];
  int m = DateTime.now().month;

  ExpenseService _expenseService = ExpenseService();
  IncomeService _incomeService = IncomeService();

  List<ExpenseModel> _expenseList = <ExpenseModel>[];
  List<IncomeModel> _incomeList = <IncomeModel>[];
  late var exp_total = 0;
  late var inc_total = 0;

  @override
  initState() {
    super.initState();
    getAllExpenses();
    getIncomes();

    getJanIncomes();
    getFebIncomes();
    getMarIncomes();
    getAplIncomes();
    getMayIncomes();
    getJuneIncomes();
    getJulyIncomes();
    getAugIncomes();
    getSepIncomes();
    getOctIncomes();
    getNovIncomes();
    getDecIncomes();

    getJanExpenses();
    getFebExpenses();
    getMarExpenses();
    getAplExpenses();
    getMayExpenses();
    getJuneExpenses();
    getJulyExpenses();
    getAugExpenses();
    getSepExpenses();
    getOctExpenses();
    getNovExpenses();
    getDecExpenses();
  }

  getAllExpenses() async{
    exp_total = 0;
    var expenses = await _expenseService.ReadAllExpense(widget.u_name,m);
    _expenseList = <ExpenseModel>[];
    expenses.forEach((expense){
      setState(() {
        var expenseModel = ExpenseModel();
        expenseModel.id = expense['id'];
        expenseModel.u_name = expense['u_name'];
        expenseModel.exp_name = expense['exp_name'];
        expenseModel.exp_amt = expense['exp_amt'];
        exp_total += expenseModel.exp_amt!;
        expenseModel.exp_date = expense['exp_date'];
        expenseModel.exp_type = expense['exp_type'];
        expenseModel.exp_trans = expense['exp_trans'];
        _expenseList.add(expenseModel);
      });
    });
  }

  getIncomes() async{
    inc_total = 0;
    var incomes = await _incomeService.ReadAllIncome(widget.u_name, m);
    _incomeList = <IncomeModel>[];
    incomes.forEach((income){
      setState(() {
        var incomeModel = IncomeModel();
        incomeModel.id = income['id'];
        incomeModel.u_name = income['u_name'];
        incomeModel.inc_name = income['inc_name'];
        incomeModel.inc_date = income['inc_date'];
        incomeModel.inc_amt = income['inc_amt'];
        inc_total += incomeModel.inc_amt!;
        incomeModel.inc_type = income['inc_type'];
        incomeModel.inc_trans = income['inc_trans'];
        _incomeList.add(incomeModel);
      });
    });
  }


  List<ExpenseModel> _janExp = <ExpenseModel>[];
  List<ExpenseModel> _febExp = <ExpenseModel>[];
  List<ExpenseModel> _marExp = <ExpenseModel>[];
  List<ExpenseModel> _aplExp = <ExpenseModel>[];
  List<ExpenseModel> _mayExp = <ExpenseModel>[];
  List<ExpenseModel> _juneExp = <ExpenseModel>[];
  List<ExpenseModel> _julyExp = <ExpenseModel>[];
  List<ExpenseModel> _augExp = <ExpenseModel>[];
  List<ExpenseModel> _sepExp = <ExpenseModel>[];
  List<ExpenseModel> _octExp = <ExpenseModel>[];
  List<ExpenseModel> _novExp = <ExpenseModel>[];
  List<ExpenseModel> _decExp = <ExpenseModel>[];
  List<ReportModel> _expList = <ReportModel>[];

  List<IncomeModel> _janInc = <IncomeModel>[];
  List<IncomeModel> _febInc = <IncomeModel>[];
  List<IncomeModel> _marInc = <IncomeModel>[];
  List<IncomeModel> _aplInc = <IncomeModel>[];
  List<IncomeModel> _mayInc = <IncomeModel>[];
  List<IncomeModel> _juneInc = <IncomeModel>[];
  List<IncomeModel> _julyInc = <IncomeModel>[];
  List<IncomeModel> _augInc = <IncomeModel>[];
  List<IncomeModel> _sepInc = <IncomeModel>[];
  List<IncomeModel> _octInc = <IncomeModel>[];
  List<IncomeModel> _novInc = <IncomeModel>[];
  List<IncomeModel> _decInc = <IncomeModel>[];
  List<ReportModel> _incList = <ReportModel>[];

  var janIncCount = 0,febIncCount = 0,marIncCount = 0,aplIncCount = 0,mayIncCount = 0,juneIncCount = 0,julyIncCount = 0,
      augIncCount = 0,sepIncCount = 0,octIncCount = 0,novIncCount = 0,decIncCount = 0;

  var janExpCount = 0,febExpCount = 0,marExpCount = 0,aplExpCount = 0,mayExpCount = 0,juneExpCount = 0,julyExpCount = 0,
      augExpCount = 0,sepExpCount = 0,octExpCount = 0,novExpCount = 0,decExpCount = 0;

  getJanIncomes() async{
    janIncCount = 0;
    var incomes = await _incomeService.ReadAllIncome(widget.u_name, DateTime.january);
    _janInc = <IncomeModel>[];
    incomes.forEach((income){
      setState(() {
        var incomeModel = IncomeModel();
        incomeModel.id = income['id'];
        incomeModel.u_name = income['u_name'];
        incomeModel.inc_name = income['inc_name'];
        incomeModel.inc_date = income['inc_date'];
        incomeModel.inc_amt = income['inc_amt'];
        janIncCount += incomeModel.inc_amt!;
        incomeModel.inc_type = income['inc_type'];
        incomeModel.inc_trans = income['inc_trans'];
        _janInc.add(incomeModel);
      });
    });
  }

  getFebIncomes() async{
    febIncCount = 0;
    var incomes = await _incomeService.ReadAllIncome(widget.u_name, DateTime.february);
    _janInc = <IncomeModel>[];
    incomes.forEach((income){
      setState(() {
        var incomeModel = IncomeModel();
        incomeModel.id = income['id'];
        incomeModel.u_name = income['u_name'];
        incomeModel.inc_name = income['inc_name'];
        incomeModel.inc_date = income['inc_date'];
        incomeModel.inc_amt = income['inc_amt'];
        febIncCount += incomeModel.inc_amt!;
        incomeModel.inc_type = income['inc_type'];
        incomeModel.inc_trans = income['inc_trans'];
        _febInc.add(incomeModel);
      });
    });
  }

  getMarIncomes() async{
    marIncCount = 0;
    var incomes = await _incomeService.ReadAllIncome(widget.u_name, DateTime.march);
    _marInc = <IncomeModel>[];
    incomes.forEach((income){
      setState(() {
        var incomeModel = IncomeModel();
        incomeModel.id = income['id'];
        incomeModel.u_name = income['u_name'];
        incomeModel.inc_name = income['inc_name'];
        incomeModel.inc_date = income['inc_date'];
        incomeModel.inc_amt = income['inc_amt'];
        marIncCount += incomeModel.inc_amt!;
        incomeModel.inc_type = income['inc_type'];
        incomeModel.inc_trans = income['inc_trans'];
        _marInc.add(incomeModel);
      });
    });
  }

  getAplIncomes() async{
    aplIncCount = 0;
    var incomes = await _incomeService.ReadAllIncome(widget.u_name, DateTime.april);
    _aplInc = <IncomeModel>[];
    incomes.forEach((income){
      setState(() {
        var incomeModel = IncomeModel();
        incomeModel.id = income['id'];
        incomeModel.u_name = income['u_name'];
        incomeModel.inc_name = income['inc_name'];
        incomeModel.inc_date = income['inc_date'];
        incomeModel.inc_amt = income['inc_amt'];
        aplIncCount += incomeModel.inc_amt!;
        incomeModel.inc_type = income['inc_type'];
        incomeModel.inc_trans = income['inc_trans'];
        _aplInc.add(incomeModel);
      });
    });
  }

  getMayIncomes() async{
    mayIncCount = 0;
    var incomes = await _incomeService.ReadAllIncome(widget.u_name, DateTime.may);
    _mayInc = <IncomeModel>[];
    incomes.forEach((income){
      setState(() {
        var incomeModel = IncomeModel();
        incomeModel.id = income['id'];
        incomeModel.u_name = income['u_name'];
        incomeModel.inc_name = income['inc_name'];
        incomeModel.inc_date = income['inc_date'];
        incomeModel.inc_amt = income['inc_amt'];
        mayIncCount += incomeModel.inc_amt!;
        incomeModel.inc_type = income['inc_type'];
        incomeModel.inc_trans = income['inc_trans'];
        _mayInc.add(incomeModel);
      });
    });
  }

  getJuneIncomes() async{
    juneIncCount = 0;
    var incomes = await _incomeService.ReadAllIncome(widget.u_name, DateTime.june);
    _juneInc = <IncomeModel>[];
    incomes.forEach((income){
      setState(() {
        var incomeModel = IncomeModel();
        incomeModel.id = income['id'];
        incomeModel.u_name = income['u_name'];
        incomeModel.inc_name = income['inc_name'];
        incomeModel.inc_date = income['inc_date'];
        incomeModel.inc_amt = income['inc_amt'];
        juneIncCount += incomeModel.inc_amt!;
        incomeModel.inc_type = income['inc_type'];
        incomeModel.inc_trans = income['inc_trans'];
        _juneInc.add(incomeModel);
      });
    });
  }

  getJulyIncomes() async{
    julyIncCount = 0;
    var incomes = await _incomeService.ReadAllIncome(widget.u_name, DateTime.july);
    _julyInc = <IncomeModel>[];
    incomes.forEach((income){
      setState(() {
        var incomeModel = IncomeModel();
        incomeModel.id = income['id'];
        incomeModel.u_name = income['u_name'];
        incomeModel.inc_name = income['inc_name'];
        incomeModel.inc_date = income['inc_date'];
        incomeModel.inc_amt = income['inc_amt'];
        julyIncCount += incomeModel.inc_amt!;
        incomeModel.inc_type = income['inc_type'];
        incomeModel.inc_trans = income['inc_trans'];
        _julyInc.add(incomeModel);
      });
    });
  }

  getAugIncomes() async{
    augIncCount = 0;
    var incomes = await _incomeService.ReadAllIncome(widget.u_name, DateTime.august);
    _augInc = <IncomeModel>[];
    incomes.forEach((income){
      setState(() {
        var incomeModel = IncomeModel();
        incomeModel.id = income['id'];
        incomeModel.u_name = income['u_name'];
        incomeModel.inc_name = income['inc_name'];
        incomeModel.inc_date = income['inc_date'];
        incomeModel.inc_amt = income['inc_amt'];
        augIncCount += incomeModel.inc_amt!;
        incomeModel.inc_type = income['inc_type'];
        incomeModel.inc_trans = income['inc_trans'];
        _augInc.add(incomeModel);
      });
    });
  }

  getSepIncomes() async{
    sepIncCount = 0;
    var incomes = await _incomeService.ReadAllIncome(widget.u_name, DateTime.september);
    _sepInc = <IncomeModel>[];
    incomes.forEach((income){
      setState(() {
        var incomeModel = IncomeModel();
        incomeModel.id = income['id'];
        incomeModel.u_name = income['u_name'];
        incomeModel.inc_name = income['inc_name'];
        incomeModel.inc_date = income['inc_date'];
        incomeModel.inc_amt = income['inc_amt'];
        sepIncCount += incomeModel.inc_amt!;
        incomeModel.inc_type = income['inc_type'];
        incomeModel.inc_trans = income['inc_trans'];
        _sepInc.add(incomeModel);
      });
    });
  }

  getOctIncomes() async{
    octIncCount = 0;
    var incomes = await _incomeService.ReadAllIncome(widget.u_name, DateTime.october);
    _octInc = <IncomeModel>[];
    incomes.forEach((income){
      setState(() {
        var incomeModel = IncomeModel();
        incomeModel.id = income['id'];
        incomeModel.u_name = income['u_name'];
        incomeModel.inc_name = income['inc_name'];
        incomeModel.inc_date = income['inc_date'];
        incomeModel.inc_amt = income['inc_amt'];
        octIncCount += incomeModel.inc_amt!;
        incomeModel.inc_type = income['inc_type'];
        incomeModel.inc_trans = income['inc_trans'];
        _octInc.add(incomeModel);
      });
    });
  }

  getNovIncomes() async{
    novIncCount = 0;
    var incomes = await _incomeService.ReadAllIncome(widget.u_name, DateTime.november);
    _novInc = <IncomeModel>[];
    incomes.forEach((income){
      setState(() {
        var incomeModel = IncomeModel();
        incomeModel.id = income['id'];
        incomeModel.u_name = income['u_name'];
        incomeModel.inc_name = income['inc_name'];
        incomeModel.inc_date = income['inc_date'];
        incomeModel.inc_amt = income['inc_amt'];
        novIncCount += incomeModel.inc_amt!;
        incomeModel.inc_type = income['inc_type'];
        incomeModel.inc_trans = income['inc_trans'];
        _novInc.add(incomeModel);
      });
    });
  }

  getDecIncomes() async{
    decIncCount = 0;
    var incomes = await _incomeService.ReadAllIncome(widget.u_name, DateTime.december);
    _decInc = <IncomeModel>[];
    incomes.forEach((income){
      setState(() {
        var incomeModel = IncomeModel();
        incomeModel.id = income['id'];
        incomeModel.u_name = income['u_name'];
        incomeModel.inc_name = income['inc_name'];
        incomeModel.inc_date = income['inc_date'];
        incomeModel.inc_amt = income['inc_amt'];
        decIncCount += incomeModel.inc_amt!;
        incomeModel.inc_type = income['inc_type'];
        incomeModel.inc_trans = income['inc_trans'];
        _decInc.add(incomeModel);
      });
    });
  }


  getJanExpenses() async{
    janExpCount = 0;
    var expenses = await _expenseService.ReadAllExpense(widget.u_name,DateTime.january);
    _janExp = <ExpenseModel>[];
    expenses.forEach((expense){
      setState(() {
        var expenseModel = ExpenseModel();
        expenseModel.id = expense['id'];
        expenseModel.u_name = expense['u_name'];
        expenseModel.exp_name = expense['exp_name'];
        expenseModel.exp_amt = expense['exp_amt'];
        janExpCount += expenseModel.exp_amt!;
        expenseModel.exp_date = expense['exp_date'];
        expenseModel.exp_type = expense['exp_type'];
        expenseModel.exp_trans = expense['exp_trans'];
        _janExp.add(expenseModel);
      });
    });
    setState(() {
      var reportModel = ReportModel();
      reportModel.month = 'January';
      reportModel.ttlExpCount = _janExp.length;
      reportModel.incTotal = janIncCount;
      reportModel.expTotal = janExpCount;
      reportModel.balance = janIncCount - janExpCount;
      if(reportModel.balance! == 0){
        reportModel.status = 'Balanced';
      }
      else{
        reportModel.status = reportModel.balance! >= 0 ? 'Profit' : 'Loss';
      }
      _expList.add(reportModel);
    });

  }

  getFebExpenses() async{
    febExpCount = 0;
    var expenses = await _expenseService.ReadAllExpense(widget.u_name,DateTime.february);
    _febExp = <ExpenseModel>[];
    expenses.forEach((expense){
      setState(() {
        var expenseModel = ExpenseModel();
        expenseModel.id = expense['id'];
        expenseModel.u_name = expense['u_name'];
        expenseModel.exp_name = expense['exp_name'];
        expenseModel.exp_amt = expense['exp_amt'];
        febExpCount += expenseModel.exp_amt!;
        expenseModel.exp_date = expense['exp_date'];
        expenseModel.exp_type = expense['exp_type'];
        expenseModel.exp_trans = expense['exp_trans'];
        _febExp.add(expenseModel);
      });
    });

    setState(() {
      var reportModel = ReportModel();
      reportModel.month = 'February';
      reportModel.ttlExpCount = _febExp.length;
      reportModel.incTotal = febIncCount;
      reportModel.expTotal = febExpCount;
      reportModel.balance = febIncCount - febExpCount;
      if(reportModel.balance! == 0){
        reportModel.status = 'Balanced';
      }
      else{
        reportModel.status = reportModel.balance! >= 0 ? 'Profit' : 'Loss';
      }
      _expList.add(reportModel);
    });

  }

  getMarExpenses() async{
    marExpCount = 0;
    var expenses = await _expenseService.ReadAllExpense(widget.u_name,DateTime.march);
    _marExp = <ExpenseModel>[];
    expenses.forEach((expense){
      setState(() {
        var expenseModel = ExpenseModel();
        expenseModel.id = expense['id'];
        expenseModel.u_name = expense['u_name'];
        expenseModel.exp_name = expense['exp_name'];
        expenseModel.exp_amt = expense['exp_amt'];
        marExpCount += expenseModel.exp_amt!;
        expenseModel.exp_date = expense['exp_date'];
        expenseModel.exp_type = expense['exp_type'];
        expenseModel.exp_trans = expense['exp_trans'];
        _marExp.add(expenseModel);
      });
    });

    setState(() {
      var reportModel = ReportModel();
      reportModel.month = 'March';
      reportModel.ttlExpCount = _marExp.length;
      reportModel.incTotal = marIncCount;
      reportModel.expTotal = marExpCount;
      reportModel.balance = marIncCount - marExpCount;
      if(reportModel.balance! == 0){
        reportModel.status = 'Balanced';
      }
      else{
        reportModel.status = reportModel.balance! >= 0 ? 'Profit' : 'Loss';
      }
      _expList.add(reportModel);
    });

  }

  getAplExpenses() async{
    aplExpCount = 0;
    var expenses = await _expenseService.ReadAllExpense(widget.u_name,DateTime.april);
    _aplExp = <ExpenseModel>[];
    expenses.forEach((expense){
      setState(() {
        var expenseModel = ExpenseModel();
        expenseModel.id = expense['id'];
        expenseModel.u_name = expense['u_name'];
        expenseModel.exp_name = expense['exp_name'];
        expenseModel.exp_amt = expense['exp_amt'];
        aplExpCount += expenseModel.exp_amt!;
        expenseModel.exp_date = expense['exp_date'];
        expenseModel.exp_type = expense['exp_type'];
        expenseModel.exp_trans = expense['exp_trans'];
        _aplExp.add(expenseModel);
      });
    });

    setState(() {
      var reportModel = ReportModel();
      reportModel.month = 'April';
      reportModel.ttlExpCount = _aplExp.length;
      reportModel.incTotal = aplIncCount;
      reportModel.expTotal = aplExpCount;
      reportModel.balance = aplIncCount - aplExpCount;
      if(reportModel.balance! == 0){
        reportModel.status = 'Balanced';
      }
      else{
        reportModel.status = reportModel.balance! >= 0 ? 'Profit' : 'Loss';
      }
      _expList.add(reportModel);
    });
  }

  getMayExpenses() async{
    mayExpCount = 0;
    var expenses = await _expenseService.ReadAllExpense(widget.u_name,DateTime.may);
    _mayExp = <ExpenseModel>[];
    expenses.forEach((expense){
      setState(() {
        var expenseModel = ExpenseModel();
        expenseModel.id = expense['id'];
        expenseModel.u_name = expense['u_name'];
        expenseModel.exp_name = expense['exp_name'];
        expenseModel.exp_amt = expense['exp_amt'];
        mayExpCount += expenseModel.exp_amt!;
        expenseModel.exp_date = expense['exp_date'];
        expenseModel.exp_type = expense['exp_type'];
        expenseModel.exp_trans = expense['exp_trans'];
        _mayExp.add(expenseModel);
      });
    });

    setState(() {
      var reportModel = ReportModel();
      reportModel.month = 'May';
      reportModel.ttlExpCount = _mayExp.length;
      reportModel.incTotal = mayIncCount;
      reportModel.expTotal = mayExpCount;
      reportModel.balance = mayIncCount - mayExpCount;
      if(reportModel.balance! == 0){
        reportModel.status = 'Balanced';
      }
      else{
        reportModel.status = reportModel.balance! >= 0 ? 'Profit' : 'Loss';
      }
      _expList.add(reportModel);
    });
  }

  getJuneExpenses() async{
    juneExpCount = 0;
    var expenses = await _expenseService.ReadAllExpense(widget.u_name,DateTime.june);
    _juneExp = <ExpenseModel>[];
    expenses.forEach((expense){
      setState(() {
        var expenseModel = ExpenseModel();
        expenseModel.id = expense['id'];
        expenseModel.u_name = expense['u_name'];
        expenseModel.exp_name = expense['exp_name'];
        expenseModel.exp_amt = expense['exp_amt'];
        juneExpCount += expenseModel.exp_amt!;
        expenseModel.exp_date = expense['exp_date'];
        expenseModel.exp_type = expense['exp_type'];
        expenseModel.exp_trans = expense['exp_trans'];
        _juneExp.add(expenseModel);
      });
    });

    setState(() {
      var reportModel = ReportModel();
      reportModel.month = 'June';
      reportModel.ttlExpCount = _juneExp.length;
      reportModel.incTotal = juneIncCount;
      reportModel.expTotal = juneExpCount;
      reportModel.balance = juneIncCount - juneExpCount;
      if(reportModel.balance! == 0){
        reportModel.status = 'Balanced';
      }
      else{
        reportModel.status = reportModel.balance! >= 0 ? 'Profit' : 'Loss';
      }
      _expList.add(reportModel);
    });
  }

  getJulyExpenses() async{
    julyExpCount = 0;
    var expenses = await _expenseService.ReadAllExpense(widget.u_name,DateTime.july);
    _julyExp = <ExpenseModel>[];
    expenses.forEach((expense){
      setState(() {
        var expenseModel = ExpenseModel();
        expenseModel.id = expense['id'];
        expenseModel.u_name = expense['u_name'];
        expenseModel.exp_name = expense['exp_name'];
        expenseModel.exp_amt = expense['exp_amt'];
        julyExpCount += expenseModel.exp_amt!;
        expenseModel.exp_date = expense['exp_date'];
        expenseModel.exp_type = expense['exp_type'];
        expenseModel.exp_trans = expense['exp_trans'];
        _julyExp.add(expenseModel);
      });
    });

    setState(() {
      var reportModel = ReportModel();
      reportModel.month = 'July';
      reportModel.ttlExpCount = _julyExp.length;
      reportModel.incTotal = julyIncCount;
      reportModel.expTotal = julyExpCount;
      reportModel.balance = julyIncCount - julyExpCount;
      if(reportModel.balance! == 0){
        reportModel.status = 'Balanced';
      }
      else{
        reportModel.status = reportModel.balance! >= 0 ? 'Profit' : 'Loss';
      }
      _expList.add(reportModel);
    });
  }

  getAugExpenses() async{
    augExpCount = 0;
    var expenses = await _expenseService.ReadAllExpense(widget.u_name,DateTime.august);
    _augExp = <ExpenseModel>[];
    expenses.forEach((expense){
      setState(() {
        var expenseModel = ExpenseModel();
        expenseModel.id = expense['id'];
        expenseModel.u_name = expense['u_name'];
        expenseModel.exp_name = expense['exp_name'];
        expenseModel.exp_amt = expense['exp_amt'];
        augExpCount += expenseModel.exp_amt!;
        expenseModel.exp_date = expense['exp_date'];
        expenseModel.exp_type = expense['exp_type'];
        expenseModel.exp_trans = expense['exp_trans'];
        _augExp.add(expenseModel);
      });
    });

    setState(() {
      var reportModel = ReportModel();
      reportModel.month = 'August';
      reportModel.ttlExpCount = _augExp.length;
      reportModel.incTotal = augIncCount;
      reportModel.expTotal = augExpCount;
      reportModel.balance = augIncCount - augExpCount;
      if(reportModel.balance! == 0){
        reportModel.status = 'Balanced';
      }
      else{
        reportModel.status = reportModel.balance! >= 0 ? 'Profit' : 'Loss';
      }
      _expList.add(reportModel);
    });
  }

  getSepExpenses() async{
    janExpCount = 0;
    var expenses = await _expenseService.ReadAllExpense(widget.u_name,DateTime.september);
    _sepExp = <ExpenseModel>[];
    expenses.forEach((expense){
      setState(() {
        var expenseModel = ExpenseModel();
        expenseModel.id = expense['id'];
        expenseModel.u_name = expense['u_name'];
        expenseModel.exp_name = expense['exp_name'];
        expenseModel.exp_amt = expense['exp_amt'];
        sepExpCount += expenseModel.exp_amt!;
        expenseModel.exp_date = expense['exp_date'];
        expenseModel.exp_type = expense['exp_type'];
        expenseModel.exp_trans = expense['exp_trans'];
        _sepExp.add(expenseModel);
      });
    });

    setState(() {
      var reportModel = ReportModel();
      reportModel.month = 'September';
      reportModel.ttlExpCount = _sepExp.length;
      reportModel.incTotal = sepIncCount;
      reportModel.expTotal = sepExpCount;
      reportModel.balance = sepIncCount - sepExpCount;
      if(reportModel.balance! == 0){
        reportModel.status = 'Balanced';
      }
      else{
        reportModel.status = reportModel.balance! >= 0 ? 'Profit' : 'Loss';
      }
      _expList.add(reportModel);
    });
  }

  getOctExpenses() async{
    janExpCount = 0;
    var expenses = await _expenseService.ReadAllExpense(widget.u_name,DateTime.october);
    _octExp = <ExpenseModel>[];
    expenses.forEach((expense){
      setState(() {
        var expenseModel = ExpenseModel();
        expenseModel.id = expense['id'];
        expenseModel.u_name = expense['u_name'];
        expenseModel.exp_name = expense['exp_name'];
        expenseModel.exp_amt = expense['exp_amt'];
        octExpCount += expenseModel.exp_amt!;
        expenseModel.exp_date = expense['exp_date'];
        expenseModel.exp_type = expense['exp_type'];
        expenseModel.exp_trans = expense['exp_trans'];
        _octExp.add(expenseModel);
      });
    });

    setState(() {
      var reportModel = ReportModel();
      reportModel.month = 'October';
      reportModel.ttlExpCount = _octExp.length;
      reportModel.incTotal = octIncCount;
      reportModel.expTotal = octExpCount;
      reportModel.balance = octIncCount - octExpCount;
      if(reportModel.balance! == 0){
        reportModel.status = 'Balanced';
      }
      else{
        reportModel.status = reportModel.balance! >= 0 ? 'Profit' : 'Loss';
      }
      _expList.add(reportModel);
    });
  }

  getNovExpenses() async{
    novExpCount = 0;
    var expenses = await _expenseService.ReadAllExpense(widget.u_name,DateTime.november);
    _novExp = <ExpenseModel>[];
    expenses.forEach((expense){
      setState(() {
        var expenseModel = ExpenseModel();
        expenseModel.id = expense['id'];
        expenseModel.u_name = expense['u_name'];
        expenseModel.exp_name = expense['exp_name'];
        expenseModel.exp_amt = expense['exp_amt'];
        novExpCount += expenseModel.exp_amt!;
        expenseModel.exp_date = expense['exp_date'];
        expenseModel.exp_type = expense['exp_type'];
        expenseModel.exp_trans = expense['exp_trans'];
        _novExp.add(expenseModel);
      });
    });

    setState(() {
      var reportModel = ReportModel();
      reportModel.month = 'November';
      reportModel.ttlExpCount = _novExp.length;
      reportModel.incTotal = novIncCount;
      reportModel.expTotal = novExpCount;
      reportModel.balance = novIncCount - novExpCount;
      if(reportModel.balance! == 0){
        reportModel.status = 'Balanced';
      }
      else{
        reportModel.status = reportModel.balance! >= 0 ? 'Profit' : 'Loss';
      }
      _expList.add(reportModel);
    });
  }

  getDecExpenses() async{
    decExpCount = 0;
    var expenses = await _expenseService.ReadAllExpense(widget.u_name,DateTime.december);
    _decExp = <ExpenseModel>[];
    expenses.forEach((expense){
      setState(() {
        var expenseModel = ExpenseModel();
        expenseModel.id = expense['id'];
        expenseModel.u_name = expense['u_name'];
        expenseModel.exp_name = expense['exp_name'];
        expenseModel.exp_amt = expense['exp_amt'];
        decExpCount += expenseModel.exp_amt!;
        expenseModel.exp_date = expense['exp_date'];
        expenseModel.exp_type = expense['exp_type'];
        expenseModel.exp_trans = expense['exp_trans'];
        _decExp.add(expenseModel);
      });
    });

    setState(() {
      var reportModel = ReportModel();
      reportModel.month = 'December';
      reportModel.ttlExpCount = _decExp.length;
      reportModel.incTotal = decIncCount;
      reportModel.expTotal = decExpCount;
      reportModel.balance = decIncCount - decExpCount;
      if(reportModel.balance! == 0){
        reportModel.status = 'Balanced';
      }
      else{
        reportModel.status = reportModel.balance! >= 0 ? 'Profit' : 'Loss';
      }
      _expList.add(reportModel);
    });
  }

  showAllWallet(context){

    print(_expenseList.length);
    print(_incomeList.length);

    return ListView.builder(
        itemCount: _expenseList.length,
        itemBuilder: (context, index){
          return Card(
            child: ListTile(
              title: Column(
                children: [
                  Text('${month[m-1]} Month Stats',style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),),
                  Container(
                    height: 150,
                    width: double.infinity,
                    margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)
                              ),
                              child: Container(
                                margin: const EdgeInsets.all(5.0),
                                padding: const EdgeInsets.all(10.0),
                                decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [Color(0xFF52b788),Color(0xFFb7e4c7),Color(0xFFd8f3dc)],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    )
                                ),
                                height: 150,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Incomes',textAlign: TextAlign.center,style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Poppins',
                                      letterSpacing: 0.8,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0,
                                    ),),
                                    Text('₹ ${_incomeList[index].inc_amt}',style: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0,
                                    ),)
                                  ],
                                ),
                              ),
                            )
                        ),
                        Expanded(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)
                              ),
                              child: Container(
                                margin: const EdgeInsets.all(5.0),
                                padding: const EdgeInsets.all(10.0),
                                decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [Color(0xFFef6351),Color(0xFFf7a399),Color(0xFFffe3e0)],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    )
                                ),
                                height: 150,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Expenses',textAlign: TextAlign.center,style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Poppins',
                                      letterSpacing: 0.8,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0,
                                    ),),
                                    Text('₹ ${_expenseList[index].exp_amt}',style: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0,
                                    ),)
                                  ],
                                ),
                              ),
                            )
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {

    int balance = 0;
    balance += janIncCount - janExpCount;
    balance += febIncCount - febExpCount;
    balance += marIncCount - marExpCount;
    balance += aplIncCount - aplExpCount;
    balance += mayIncCount - mayExpCount;
    balance += juneIncCount - juneExpCount;
    balance += julyIncCount - julyExpCount;
    balance += augIncCount - augExpCount;
    balance += sepIncCount - sepExpCount;
    balance += octIncCount - octExpCount;
    balance += novIncCount - novExpCount;
    balance += decIncCount - decExpCount;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Wallet",style: TextStyle(
          color: Colors.black,
          fontSize: 17.0,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
        ),),
        backgroundColor: const Color(0xFFffb700),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10.0,
            ),
            Container(
              height: 500,
              child: showAllWallet(context),
            ),
            const Divider(thickness: 2.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${DateTime.now().year} Year Total Balance : ',style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15.0,
                ),),
                const SizedBox(width: 10.0,),
                Text('$balance',style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15.0,
                ),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
