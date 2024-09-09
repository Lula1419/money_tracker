import 'package:flutter/material.dart';
import 'package:money_tacker/model/transaction.dart';

class TransactionsProvider extends ChangeNotifier{

  //_ el guion bajo en la variable significa que es una propiedad privada de la clase, 
  //no puede ser accedida por fuera
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

  void addTransaction(Transaction transaction){
    _transactions.add(transaction);
    notifyListeners();
  }
}