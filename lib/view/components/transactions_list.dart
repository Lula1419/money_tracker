

import 'package:flutter/material.dart';
import 'package:money_tacker/controller/transaction_provider.dart';
import 'package:money_tacker/model/transaction.dart';
import 'package:money_tacker/view/components/edit_transaction_dialog.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class TransactionsList extends StatelessWidget {
  const TransactionsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionsProvider>(
      builder: (context, provider, child) {
          //final transactions = Provider.of<TransactionsProvider>(context).transactions;
          final transactions = provider.transactions;
          return Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index){
                  final transaction = transactions[index];
                  return TransactionListItem(
                    transaction: transaction,
                    onDelete: () => provider.deleteTransaction(transaction.id),
                    onEdit: () => showEditTransactionDialog(context, transaction),
                  );
                },
              ),
            ),
          );
        },
       );
  }
}


class TransactionListItem extends StatelessWidget{
  final FinancialTransaction transaction;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

/*final String formattedDate = DateFormat.yMd();
DateFormat('yyyy/MM/dd')*/

  const TransactionListItem({
    Key? key,
    required this.transaction,
    required this.onDelete,
    required this.onEdit,
  }) : super(key : key);


  @override
  Widget build(BuildContext context){
  //Estructura de un if 
    final type = transaction.type == TransactionType.income ? 'Income' : 'Expenses';
    final value = transaction.type == TransactionType.expense
      ? '-\$${transaction.amount.abs().toStringAsFixed(2)}'
      : '\$${transaction.amount.toStringAsFixed(2)}';
    final color = transaction.type == TransactionType.expense
      ? Colors.red
      : Colors.teal;

    return Dismissible(
      key: Key(transaction.id.toString()),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),

      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        onDelete();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${transaction.description} deleted')),
        );
      },
      child: ListTile(
        leading: const Icon(Icons.money),
        title: Text(transaction.description),
       subtitle: Text(DateFormat('yyyy/MM/dd').format(transaction.date)),
        //subtitle: Text(type),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(value, style: TextStyle(fontSize: 14, color: color)),
            IconButton(
              icon: const Icon(Icons.edit, size: 20),
              onPressed: (onEdit), 
            ),
          ],
        ),
      ),
    );
  }
}
