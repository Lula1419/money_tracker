
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_tacker/controller/transaction_provider.dart';
import 'package:money_tacker/model/transaction.dart';
import 'package:provider/provider.dart';

class AddTransactionDialog extends StatefulWidget{
  const AddTransactionDialog({super.key});

  @override
  State<AddTransactionDialog> createState() => _AddTransactionDialogState();
}

class _AddTransactionDialogState extends State<AddTransactionDialog> {
  int? typeIndex = 0;
  TransactionType type = TransactionType.income;
  double amount = 0;
  String description = '';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    
    return SizedBox(
      height: 680,
      width: double.infinity,
      child: Column(
        children: [
          Container(
            height: 6,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(3),
            )
          ),
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text('New Transaction', 
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),  
            ),
          ),
          CupertinoSlidingSegmentedControl(
            groupValue: typeIndex,
            children: const {
              0: Text('Income'),
              1: Text('Expense'),
            }, 
            onValueChanged: (value) {
              setState(() {
                typeIndex =  value as int;
                type = value == 0
                  ? TransactionType.income
                  : TransactionType.expense;
              });
            },
          ),
          const SizedBox(height: 20),
          Text(
            'AMOUNT', 
            style: textTheme.bodySmall?.copyWith(color: Colors.teal, fontSize: 15)
          ),
          TextField(
            inputFormatters: [CurrencyTextInputFormatter.currency(symbol: '\$')],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration.collapsed(
              hintText: '\$0.00',
              hintStyle: TextStyle(color: Colors.grey)
            ),
            autofocus: true,
            onChanged: (value) {
              final valueWithowDolarSign = value.replaceAll('\$', '');
              final valueWithowComas = valueWithowDolarSign.replaceAll(',','');

              if (valueWithowComas.isNotEmpty){
                amount = double.parse(valueWithowComas);
              }
            },
          ),
          const SizedBox(height: 20),
          Text(
            'DESCRIPCION', 
            style: textTheme.bodySmall?.copyWith(color: Colors.teal, fontSize: 15)
          ),
          TextField(
            textAlign: TextAlign.center,
            decoration: const InputDecoration.collapsed(
              hintText: 'Enter a description here',
              hintStyle: TextStyle(color: Colors.grey)
            ),
            keyboardType: TextInputType.text,
            onChanged: (value) {
              description = value;
            },
          ),
          const SizedBox(height: 20,),
          SizedBox(
            width: 300,
            child: ElevatedButton(
              onPressed: () async {
                // Crear una nueva transacción con los valores correctos
                final transaction = FinancialTransaction(
                  id: DateTime.now().millisecondsSinceEpoch, // Genera un id único basado en el tiempo actual
                  type: type, 
                  amount: type == TransactionType.expense ? -amount : amount, 
                  description: description,
                  date: DateTime.now(), // Usa la fecha actual para la transacción
                  isExpense: type == TransactionType.expense ? 0 : 1, // Definir si es un gasto
                );
                
                // Añadir la transacción a través del Provider
                await Provider.of<TransactionsProvider>(context, listen: false).addTransaction(transaction);
                
                // Cerrar el diálogo después de añadir la transacción
                if (mounted){
                  Navigator.of(context).pop();
                }
              }, 
 
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
              child: const Text(
                'Add',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}