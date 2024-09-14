import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:money_tacker/controller/transaction_provider.dart';
import 'package:money_tacker/model/transaction.dart';
import 'package:provider/provider.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

void showEditTransactionDialog(BuildContext context, FinancialTransaction transaction) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return EditTransactionDialog(transaction: transaction);
    },
  );
}

class EditTransactionDialog extends StatefulWidget {
  final FinancialTransaction transaction;

  const EditTransactionDialog({Key? key, required this.transaction}) : super(key: key);

  @override
  _EditTransactionDialogState createState() => _EditTransactionDialogState();
}

class _EditTransactionDialogState extends State<EditTransactionDialog> {
  late int typeIndex;
  late TransactionType type;
  late double amount;
  late String description;
  late TextEditingController _amountController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    typeIndex = widget.transaction.type == TransactionType.income ? 0 : 1;
    type = widget.transaction.type;
    amount = widget.transaction.amount.abs();
    description = widget.transaction.description;
    _amountController = TextEditingController(text: amount.toStringAsFixed(2));
    _descriptionController = TextEditingController(text: description);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        height: 420,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              height: 6,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Edit Transaction',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            CupertinoSlidingSegmentedControl(
              groupValue: typeIndex,
              children: const {
                0: Text('Income'),
                1: Text('Expense'),
              },
              onValueChanged: (value) {
                setState(() {
                  typeIndex = value as int;
                  type = value == 0 ? TransactionType.income : TransactionType.expense;
                });
              },
            ),
            const SizedBox(height: 20),
            Text(
              'AMOUNT',
              style: textTheme.bodySmall?.copyWith(color: Colors.teal, fontSize: 15),
            ),
            TextField(
              controller: _amountController,
              inputFormatters: [CurrencyTextInputFormatter.currency(symbol: '\$')],
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration.collapsed(
                hintText: '\$0.00',
                hintStyle: TextStyle(color: Colors.grey),
              ),
              onChanged: (value) {
                final valueWithoutDollarSign = value.replaceAll('\$', '');
                final valueWithoutCommas = valueWithoutDollarSign.replaceAll(',', '');
                if (valueWithoutCommas.isNotEmpty) {
                  amount = double.parse(valueWithoutCommas);
                }
              },
            ),
            const SizedBox(height: 20),
            Text(
              'DESCRIPTION',
              style: textTheme.bodySmall?.copyWith(color: Colors.teal, fontSize: 15),
            ),
            TextField(
              controller: _descriptionController,
              textAlign: TextAlign.center,
              decoration: const InputDecoration.collapsed(
                hintText: 'Enter a description here',
                hintStyle: TextStyle(color: Colors.grey),
              ),
              onChanged: (value) {
                description = value;
              },
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  final updatedTransaction = FinancialTransaction(
                    id: widget.transaction.id,
                    type: type,
                    amount: type == TransactionType.expense ? -amount : amount,
                    description: description,
                    date: widget.transaction.date,
                    isExpense: type == TransactionType.expense ? 1 : 0,
                  );
                  Provider.of<TransactionsProvider>(context, listen: false)
                      .updateTransaction(updatedTransaction);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                child: const Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}