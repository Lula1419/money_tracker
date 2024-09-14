import 'package:flutter/material.dart';
import 'package:money_tacker/view/components/add_transaction_dialog.dart';
import 'package:money_tacker/view/components/home_header.dart';
import 'package:money_tacker/view/components/transactions_list.dart';
import 'package:money_tacker/view/screens/tools_screen.dart';
import 'package:money_tacker/view/widgets/filter_options_menu.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: SafeArea(
        bottom: false, //No aplica el 'Area segura' de la parte de abajo, sólo la superior (para librar el lente de la camara)
        child: Column(
          children: [
            const HomeHeader(),  //El código de este apartado se extrajo en la clase home_header. La clase se extrae y se copia en un nuevo archivo llamado home_header.dart
            
             Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Transactions',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => _showFilterOptions(context),
                    icon: const Icon(Icons.filter_list),
                    label: const Text('Filter'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.teal,
                      backgroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const TransactionsList(),
          ],
        ),
      ),

      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: 'Tools',
              backgroundColor: Colors.orange.shade300,
              onPressed: (){
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => const ToolsScreen())
                );
              },
              child: const Icon(Icons.build, color: Colors.white,),
            ),
            FloatingActionButton(
              heroTag: 'New transaction',
              backgroundColor: Colors.teal,
              onPressed: () {
                //Mostrar un button para crear la accion
                showModalBottomSheet(
                  context: context, 
                  isScrollControlled: true,
                  builder: (context) {
                    return const AddTransactionDialog();
                  }
                );
              },
              child: const Icon(Icons.add, color: Colors.white,)
            ),
          ],
        ),
      )
     
    );
  }

  void _showFilterOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return FilterOptionsMenu();
      },
    );
  }
}


