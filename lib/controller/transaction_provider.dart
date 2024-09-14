import 'package:flutter/material.dart';
import 'package:money_tacker/model/transaction.dart';
import 'package:money_tacker/model/database_helper.dart';


class TransactionsProvider extends ChangeNotifier{
  //lógica de programación de datos de listas

  final List<FinancialTransaction> _transactions = [];
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  List<FinancialTransaction> get transactions => List.unmodifiable(_transactions);

  TransactionsProvider(){
    _loadTransactions();
  }

  Future<void> _loadTransactions() async{
    final loadedTransactions = await _dbHelper.getTransactions();
    _transactions.clear();
    _transactions.addAll(loadedTransactions);
    notifyListeners();
  }

  Future<void> addTransaction(FinancialTransaction transaction) async {
    await _dbHelper.insertTransaction(transaction);
    _transactions.add(transaction);
    notifyListeners();
  }

  Future<void> updateTransaction(FinancialTransaction updatedTransaction) async {
    final index = _transactions.indexWhere((t) => t.id == updatedTransaction.id);
    if (index != -1) {
      _transactions[index] = updatedTransaction;
      await _dbHelper.updateTransaction(updatedTransaction);
      notifyListeners();
    }
  }

  Future<void> deleteTransaction(int? id) async {
    if (id == null) {
      throw ArgumentError('Transaction ID cannot be null');
    }else{
      _transactions.removeWhere((t) => t.id == id);
      await _dbHelper.deleteTransaction(id);
      notifyListeners();
    }
  }


 Future<void> updateTransactionData({
    required int? id,
    required String description,
    required double amount,
    required TransactionType type,
    required DateTime date,
    required int isExpense,
  }) async {
    final updatedTransaction = FinancialTransaction(
      id: id,
      type: type,
      amount: amount,
      description: description,
      date: date,
      isExpense: isExpense,
    );
    
    await _dbHelper.updateTransaction(updatedTransaction);
    
    final index = _transactions.indexWhere((t) => t.id == id);
    if (index != -1){
      _transactions[index] = updatedTransaction;
      notifyListeners();
    }
  }

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