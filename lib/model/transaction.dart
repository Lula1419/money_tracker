// ignore_for_file: public_member_api_docs, sort_constructors_first


class Transaction {
  final TransactionType type;
  final double amount;
  final String description;


  Transaction({
    required this.type,
    required this.amount,
    required this.description,
  });

}


enum TransactionType{ income, expense }
