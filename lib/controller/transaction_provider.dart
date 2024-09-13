import 'package:flutter/material.dart';
import 'package:money_tacker/model/transaction.dart';
import 'package:money_tacker/model/database_helper.dart';


class TransactionsProvider extends ChangeNotifier{
  //lógica de programación de datos de listas

  final List<FinancialTransaction> _transactions = [];
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  List<FinancialTransaction> get transactions => _transactions;

  TransactionsProvider(){
    _loadTransactions();
  }

  Future<void> _loadTransactions() async{
    final loadedTransactions = await _dbHelper.getTransactions();
    _transactions.clear();
    _transactions.addAll(loadedTransactions as Iterable<FinancialTransaction>);
    notifyListeners();
  }

  Future<void> addTransactions(FinancialTransaction transaction) async {
    await _dbHelper.insertTransaction(transaction);
    await _loadTransactions();
    notifyListeners();
  }

  void addTransaction(FinancialTransaction transaction) {
    _transactions.add(transaction);
    notifyListeners(); // Notificar a los listeners que los datos han cambiado
  }


  Future<void> updateTransaction(FinancialTransaction transaction) async{
    /*Implementar el metodo updateTransaction en database_helper 
    await _dbHelper.updateTransaction(transacion);
    await _loadTransactions();
    notifyListeners();
    */ 
  }

  Future<void> deleteTransaction(int id) async{
    /*Implementar el metodo deleteTransaction en database_helper 
    await _dbHelper.deleteTransaction(transacion);
    await _loadTransactions();
    notifyListeners();
    */ 
  }


  /*
  final List<Transaction> _transactions =[
    Transaction(type: TransactionType.income, 
                amount: 1000.00, 
                description: 'Salary'),
   
    Transaction(type: TransactionType.expense, 
              amount: -500.00, 
              description: 'Rent'),
  ];

  List<Transaction> get transactions{
    return _transactions;
  }
  */

  double getTotalIncomes(){
    return _transactions
      .where((transaction) => transaction.type == TransactionType.income)
      .map((transaction) => transaction.amount)
      .fold(0, (a,b) => a + b);
  }

  double getTotalExpenses(){
    return _transactions
      .where((transaction) => transaction.type == TransactionType.expense)
      .map((transaction) => transaction.amount)
      .fold(0, (a,b) => a + b);
  }

  double getBalance(){
    return getTotalIncomes() + getTotalExpenses();
  }

  
}