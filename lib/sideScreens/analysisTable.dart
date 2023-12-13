import 'dart:io';

import 'package:expense_tracker/database/expenseService.dart';
import 'package:expense_tracker/database/incomeService.dart';
import 'package:expense_tracker/models/expenseModel.dart';
import 'package:expense_tracker/models/incomeModel.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class AnalysisTable extends StatefulWidget {
  final String u_name;
  const AnalysisTable({Key? key, required this.u_name}) : super(key: key);

  @override
  State<AnalysisTable> createState() => _AnalysisTableState();
}

class _AnalysisTableState extends State<AnalysisTable> {
  ExpenseService _expenseService = ExpenseService();
  IncomeService _incomeService = IncomeService();

  List<String> month = ['January','Febraury','March','April','May','June','July','August','September','October','November','December'];
  int m = DateTime.now().month;


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
  
  @override
  initState(){
    super.initState();

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


  showAllExpenses(BuildContext context) {
    return ListView.builder(
        itemCount: _expList.length,
        itemBuilder: (context, index){
          return Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 10,
            margin: const EdgeInsets.only(bottom: 10,top: 10),
            child: ListTile(
                contentPadding: const EdgeInsets.all(8.0),
                title: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${_expList[index].month}',style: const TextStyle(
                          color: Colors.pink,
                          fontFamily: 'Poppins',
                          fontSize: 14.0,
                        ),),
                        Text('Expenses Count : ${_expList[index].ttlExpCount}',style: const TextStyle(
                          color: Color(0xFF6f1a07),
                          fontFamily: 'Poppins',
                          fontSize: 14.0,
                        ),),
                      ],
                    ),
                    const SizedBox(height: 10.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Income : ₹${_expList[index].incTotal}',style: const TextStyle(
                          color: Colors.green,
                          fontFamily: 'Poppins',
                          fontSize: 14.0,
                        ),),
                        Text('Expense : ₹${_expList[index].expTotal}',style: const TextStyle(
                          color: Colors.red,
                          fontFamily: 'Poppins',
                          fontSize: 14.0,
                        ),),
                      ],
                    ),
                    const SizedBox(height: 10.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Status : ${_expList[index].status}',style: TextStyle(
                          color: _expList[index].status! == 'Profit' ? Colors.green : _expList[index].status! == 'Loss' ? Colors.red : Colors.black,
                          fontFamily: 'Poppins',
                          fontSize: 14.0,
                        ),),
                        Text('Balance : ₹${_expList[index].balance}',style: const TextStyle(
                          color: Colors.blue,
                          fontFamily: 'Poppins',
                          fontSize: 14.0,
                        ),),
                      ],
                    ),
                    const SizedBox(height: 10.0,),
                  ],
                )
            ),
          );
        }
    );
  }

  pw.Widget showExpenses() {
    return pw.ListView.builder(
        itemCount: _expList.length,
        itemBuilder: (context, index){
          return pw.Container(
            margin: const pw.EdgeInsets.only(bottom: 10,top: 10),
            child: pw.Column(
                  children: [
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('${_expList[index].month}',style: pw.TextStyle(
                          color: PdfColors.pink,
                          font: pw.Font.helvetica(),
                          fontSize: 14.0,
                        ),),
                        pw.Text('Expenses Count : ${_expList[index].ttlExpCount}',style: pw.TextStyle(
                          color: PdfColors.brown,
                          font: pw.Font.helvetica(),
                          fontSize: 14.0,
                        ),),
                      ],
                    ),
                    pw.SizedBox(height: 10.0,),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('Income : ₹${_expList[index].incTotal}',style: pw.TextStyle(
                          color: PdfColors.green,
                          font: pw.Font.helvetica(),
                          fontSize: 14.0,
                        ),),
                        pw.Text('Expense : ₹${_expList[index].expTotal}',style: pw.TextStyle(
                          color: PdfColors.red,
                          font: pw.Font.helvetica(),
                          fontSize: 14.0,
                        ),),
                      ],
                    ),
                    pw.SizedBox(height: 10.0,),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('Status : ${_expList[index].status}',style: pw.TextStyle(
                          color: _expList[index].status! == 'Profit' ? PdfColors.green : _expList[index].status! == 'Loss' ? PdfColors.red : PdfColors.black,
                          font: pw.Font.helvetica(),
                          fontSize: 14.0,
                        ),),
                        pw.Text('Balance : ₹${_expList[index].balance}',style: pw.TextStyle(
                          color: PdfColors.blue,
                          font: pw.Font.helvetica(),
                          fontSize: 14.0,
                        ),),
                      ],
                    ),
                    pw.SizedBox(height: 10.0,),
                  ],
                )
            );
        }
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Analytics Report",style: TextStyle(
          color: Colors.black,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
        ),),
        backgroundColor: const Color(0xFFffb700),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("${DateTime.now().year} Year Report",style: const TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),),
            Container(
              padding: EdgeInsets.all(10.0),
              height: 720,
              child: showAllExpenses(context),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFffb700),
        onPressed: () async{
          // generatePDF();
          generatePDF(["Item 1", "Item 2", "Item 3"]);
        },
        // child: const Icon(Icons.download_for_offline_outlined,color: Colors.black,),
        tooltip: 'Download as PDF',
        child: Icon(Icons.picture_as_pdf),
      ),
    );
  }

  Future<void> generatePDF(List<String> items) async {
    final pdf = pw.Document();

    pdf.addPage(pw.Page(
      build: (pw.Context context) {
        return pw.ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return pw.Text(items[index]);
          },
        );
      },
    ));


    final String path = await _getExternalPath();
    final File file = File('$path/example.txt');
    await file.writeAsBytes(await pdf.save());
    print('PDF file saved at: ${file.path}');
  }

  static Future<String> _getExternalPath() async {
    if (Platform.isAndroid) {
      final directory = await getExternalStorageDirectory();
      return directory!.path;
    } else {
      // For other platforms, you may choose a different directory
      final directory = await getApplicationDocumentsDirectory();
      return directory.path;
    }
  }

  static pw.Widget _buildRow(String label, String value) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(label, style: const pw.TextStyle(
          color: PdfColor.fromInt(0xFF000000),
          fontSize: 14.0,
        )),
        pw.Text(value, style: const pw.TextStyle(
          color: PdfColor.fromInt(0xFF000000),
          fontSize: 14.0,
        )),
      ],
    );
  }

}

class ReportModel{
  String? month;
  int? ttlExpCount;
  int? incTotal;
  int? expTotal;
  String? status;
  int? balance;
}
