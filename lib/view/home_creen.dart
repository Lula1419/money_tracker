import 'package:flutter/material.dart';
import 'package:money_tacker/view/components/add_transaction_dialog.dart';
import 'package:money_tacker/view/components/home_header.dart';
import 'package:money_tacker/view/components/transactions_list.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});


 @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: const SafeArea(
        bottom: false, //No aplica el 'Area segura' de la parte de abajo, sólo la superior (para librar el lente de la camara)
        child: Column(
          children: [
            HomeHeader(),  //El código de este apartado se extrajo en la clase home_header. La clase se extrae y se copia en un nuevo archivo llamado home_header.dart
            TransactionsList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
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
    );
  }
}

