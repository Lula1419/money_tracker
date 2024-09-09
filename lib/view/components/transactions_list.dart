

import 'package:flutter/material.dart';
import 'package:money_tacker/controller/transaction_provider.dart';
import 'package:money_tacker/model/transaction.dart';
import 'package:provider/provider.dart';

class TransactionsList extends StatelessWidget {
  const TransactionsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final transactions = Provider.of<TransactionsProvider>(context).transactions;
    

    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (context, index){

            final transaction = transactions[index];

            //Estructura de un if 
            final type = transaction.type == TransactionType.income
              ? 'Income'
              : 'Expenses';
              final value = transaction.type == TransactionType.expense
              ? '-\$${transaction.amount.abs().toStringAsFixed(2)}'
              : '\$${transaction.amount.toStringAsFixed(2)}';
              final color = transaction.type == TransactionType.expense
              ? Colors.red
              : Colors.teal;

            return ListTile(
              leading: const Icon(Icons.money),
              title: Text(transaction.description),
              subtitle: Text(type),
              trailing: Text(value, style: TextStyle(fontSize: 14, color: color),)
            );
          },
        ),
      ),
    );
  }
}

/*
child: ListView(
          children:const [
            ListTile(
              leading: Icon(Icons.attach_money, color: Colors.teal,),
              title: Text('Income'),
              subtitle: Text('You got \$1,000.00'),
              trailing: Text('\$1,000.00', style: TextStyle(fontSize: 14),),
            ),
            ListTile(
              leading: Icon(Icons.money_off, color: Colors.red,),
              title: Text('You spent \$500.00'),
              trailing: Text('\$-500.00', style: TextStyle(fontSize: 14),),
            )
          ],
        )
*/
