
import 'package:flutter/material.dart';
import 'package:money_tacker/controller/transaction_provider.dart';
import 'package:money_tacker/view/home_creen.dart';
import 'package:flutter/src/painting/text_style.dart';
import 'package:money_tacker/view/widgets/header_card.dart';
import 'package:provider/provider.dart';


class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TransactionsProvider>(context);
    final balance = provider.getBalance();
    final incomes = provider.getTotalIncomes();
    final expenses = provider.getTotalExpenses();

    final textTheme = Theme.of(context).textTheme;

    return Container(
      
      width: double.infinity,
      child: Column(
        children: [
          const SizedBox(height: 20,),
          Text(
            'MONEY TRACKER', 
            style: textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold, color: Colors.grey.shade900
            ),
          ),
          const SizedBox(height: 12,),
          Text(
            'Balance',
            style: textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white.withOpacity(0.5),
            ),
          ),
          Text(
            '\$ ${balance.toStringAsFixed(2)}',
            style: textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),
          ),

          Padding(
            padding: EdgeInsets.all(12),
            child: Row( children:[
              HeaderCard(
                title: 'Incomes',
                amount: incomes,
                icon: const Icon(Icons.attach_money, color: Colors.teal)
              ),//Se extrae el codigo y se mete al archivo header_card.dart (para limpiar código y reutilizarlo)
              const SizedBox(width: 12),
              HeaderCard(
                title: 'Expensives',
                amount: expenses,
                icon: const Icon(Icons.money_off, color: Colors.red)
              )
            ]),
          )




          
        ],
      )     
    );
  }
}

